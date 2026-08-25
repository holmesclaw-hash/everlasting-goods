import { mkdir, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

import database from "../src/generated/database.json" with { type: "json" };
import { buildWeeklyDigest } from "../src/lib/digest.mjs";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const periodEnding = process.argv[2] ?? new Date().toISOString().slice(0, 10);
const output = buildWeeklyDigest({
  periodEnding,
  products: database.products,
  freshnessQueue: database.freshness_queue,
  changes: [
    "Phase 1 sitemap, claims, links, assets, and disclosure audit generated with row-level dispositions.",
    "Legacy article bodies quarantined; public author identity normalized.",
    "SQLite database and fifteen manufacturer-documented tool/shop records generated.",
    "Database pages, comparison tables, Product/Review JSON-LD, and two decision tools added.",
    "Consent-gated referral classification added for LLM, organic, direct, and other referrals.",
  ],
  exceptions: [
    "T1 shop notes and photos have not been supplied; no T1 claim is published.",
    "Traffic, Search Console, analytics reporting, and affiliate revenue accounts are not connected.",
    "Affiliate-program registrations require Daniel to accept program terms.",
    "No scheduler change is authorized; run this digest on demand until Daniel approves scheduling.",
    "A second consecutive weekly digest cannot exist before the next weekly period.",
  ],
  traffic: null,
  revenue: null,
});
const outputPath = path.join(root, "ops", "digests", `${periodEnding}.md`);
await mkdir(path.dirname(outputPath), { recursive: true });
await writeFile(outputPath, output, "utf8");
console.log(`Wrote ${outputPath}`);
