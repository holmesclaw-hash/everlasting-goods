import assert from "node:assert/strict";
import { createHash } from "node:crypto";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function loadGeneratedDatabase() {
  const text = await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8");
  return JSON.parse(text);
}

test("generated database is synchronized to the tracked SQLite source", async () => {
  const generated = await loadGeneratedDatabase();
  const database = await readFile(new URL("../data/everlasting.db", import.meta.url));
  const digest = createHash("sha256").update(database).digest("hex");
  assert.equal(generated.database_sha256, digest);
  assert.equal(generated.schema_version, 1);
});

test("database generation is deterministic for a fixed migration", async () => {
  const generated = await loadGeneratedDatabase();
  assert.equal(generated.generated_at, "2026-08-25T00:00:00.000Z");
});

test("category one contains at least fifteen publishable T1 or T2 tool records", async () => {
  const generated = await loadGeneratedDatabase();
  const publishable = generated.products.filter((product) =>
    ["T1", "T2"].includes(product.evidence_tier)
    && product.category_group === "tools-shop"
  );
  assert.ok(publishable.length >= 15, `expected >=15 publishable tool records, found ${publishable.length}`);

  for (const product of publishable) {
    assert.ok(product.brand);
    assert.ok(product.model);
    assert.ok(product.slug);
    assert.ok(product.last_reviewed_date);
    assert.ok(product.sources.length >= 1, `${product.slug} needs a source`);
    for (const source of product.sources) {
      assert.match(source.url, /^https:\/\//);
      assert.match(source.retrieved_date, /^\d{4}-\d{2}-\d{2}$/);
    }
  }
});

test("published fields declare evidence and freshness instead of plausible guesses", async () => {
  const generated = await loadGeneratedDatabase();
  for (const product of generated.products) {
    for (const field of product.fields) {
      assert.ok(["T1", "T2", "T3", "T4"].includes(field.evidence_tier));
      assert.match(field.verified_date, /^\d{4}-\d{2}-\d{2}$/);
      assert.ok(Number.isInteger(field.reverify_days) && field.reverify_days > 0);
      if (field.evidence_tier === "T4") {
        assert.equal(field.display_value, "Not yet verified");
      } else {
        assert.ok(field.source_url, `${product.slug}.${field.name} needs a source URL`);
      }
    }
  }
});

test("affiliate destinations are exact-model links only", async () => {
  const generated = await loadGeneratedDatabase();
  for (const product of generated.products) {
    for (const link of product.affiliate_links) {
      assert.equal(link.exact_model, true);
      const parsed = new URL(link.url);
      assert.notEqual(parsed.pathname, "/s");
      assert.equal(parsed.searchParams.has("k"), false);
    }
  }
});
