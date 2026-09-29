import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dcs7485b";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the DEWALT DCS7485B record preserves package, type, and repair boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "DEWALT");
  assert.equal(product.model, "DCS7485");
  assert.equal(product.sku, "DCS7485B");
  assert.equal(product.category, "table-saws");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-09-29");
  assert.match(product.variant_notes, /bare-tool.*DCS7485T1.*battery.*charger.*Types 1, 3, and 10/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.dewalt.com/en-us/product/dcs7485b/60v-max-table-saw-tool-only",
    "https://assets.dewalt.com/GLOBALBOM/QU/DCS7485B/3/Instruction_Manual/EN/N785278_DCS7485_NA.pdf",
    "https://www.toolservicenet.com/en//Dewalt/WOODWORKING/BENCH-SAWS/60V-MAX-TABLE-SAW---BARE/p/DCS7485B_10",
    "https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool",
    "https://www.dewalt.com/en-us/support/warranty",
    "https://www.amazon.com/dp/B01H9BLZ6A",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /cordless.*brushless.*8-1\/4-inch.*tool-only/i);
  assert.match(fields.parts_availability.display_value, /partial.*type-specific.*ServiceNet/i);
  assert.match(fields.repair_manual.display_value, /operating.*maintenance manual.*not.*owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*cleaning.*height-adjustment screw.*authorized service/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /qualifying exact-SKU duration evidence.*service life.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B01H9BLZ6A?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-29",
  }]);
});
