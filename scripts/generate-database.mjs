import { createHash } from "node:crypto";
import { createRequire } from "node:module";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

import initSqlJs from "sql.js";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const databasePath = path.join(root, "data", "everlasting.db");
const outputPath = path.join(root, "src", "generated", "database.json");
const require = createRequire(import.meta.url);
const wasmPath = require.resolve("sql.js/dist/sql-wasm.wasm");

const SQL = await initSqlJs({ locateFile: () => wasmPath });
const databaseBytes = await readFile(databasePath);
const db = new SQL.Database(databaseBytes);

function rows(sql, params = []) {
  const statement = db.prepare(sql);
  statement.bind(params);
  const result = [];
  while (statement.step()) result.push(statement.getAsObject());
  statement.free();
  return result;
}

const metadata = Object.fromEntries(rows("SELECT key, value FROM metadata").map(({ key, value }) => [key, value]));
const products = rows("SELECT * FROM products ORDER BY category, brand, model").map((product) => {
  const sources = rows(`
    SELECT DISTINCT s.url, s.title, s.source_type, s.retrieved_date, ps.purpose
    FROM sources s
    JOIN product_sources ps ON ps.source_id = s.id
    WHERE ps.product_id = ?
    ORDER BY ps.purpose, s.url
  `, [product.id]);
  const fields = rows(`
    SELECT pf.name, pf.raw_value, pf.display_value, pf.evidence_tier,
           s.url AS source_url, pf.verified_date, pf.reverify_days,
           date(pf.verified_date, '+' || pf.reverify_days || ' days') AS stale_after
    FROM product_fields pf
    LEFT JOIN sources s ON s.id = pf.source_id
    WHERE pf.product_id = ?
    ORDER BY pf.name
  `, [product.id]);
  const affiliateLinks = rows(`
    SELECT program_name, url, exact_model, verified_date
    FROM affiliate_links
    WHERE product_id = ?
    ORDER BY program_name
  `, [product.id]).map((link) => ({ ...link, exact_model: Boolean(link.exact_model) }));
  const repairability = rows("SELECT * FROM repairability WHERE product_id = ?", [product.id])[0] ?? null;
  const warranty = rows(`
    SELECT w.warranty_length, w.warranty_coverage, w.warranty_exclusions,
           s.url AS source_url, w.verified_date
    FROM warranties w JOIN sources s ON s.id = w.source_id
    WHERE w.product_id = ?
  `, [product.id])[0] ?? null;
  const economics = rows("SELECT cost_per_year FROM product_economics WHERE product_id = ?", [product.id])[0] ?? { cost_per_year: null };
  return {
    ...product,
    sources,
    fields,
    affiliate_links: affiliateLinks,
    repairability,
    warranty,
    cost_per_year: economics.cost_per_year,
  };
});

const freshnessQueue = rows(`
  SELECT p.slug, fq.field_name, fq.verified_date, fq.reverify_days, fq.stale_after, fq.is_stale
  FROM freshness_queue fq JOIN products p ON p.id = fq.product_id
  ORDER BY fq.stale_after, p.slug, fq.field_name
`).map((item) => ({ ...item, is_stale: Boolean(item.is_stale) }));

const generated = {
  schema_version: Number(metadata.schema_version),
  database_sha256: createHash("sha256").update(databaseBytes).digest("hex"),
  generated_at: `${metadata.last_migrated_date}T00:00:00.000Z`,
  products,
  freshness_queue: freshnessQueue,
};

await mkdir(path.dirname(outputPath), { recursive: true });
await writeFile(outputPath, `${JSON.stringify(generated, null, 2)}\n`, "utf8");
console.log(`Generated ${products.length} products from ${databasePath}`);
