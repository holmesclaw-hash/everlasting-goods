import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "sawstop-cns175-tgp236";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the SawStop CNS175-TGP236 record preserves configuration and repair boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "SawStop");
  assert.equal(product.model, "Contractor Saw CNS175");
  assert.equal(product.sku, "CNS175-TGP236");
  assert.equal(product.category, "table-saws");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-09-30");
  assert.match(product.variant_notes, /CNS175-TGP236.*1\.75.*36-inch.*T-Glide/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.sawstop.com/product/contractor-saw-cns175-tgp236",
    "https://www.sawstop.com/wp-content/uploads/2026/04/Contractor-Saw-Owners-Manual_US_EN-3-1.pdf",
    "https://www.sawstop.com/wp-content/uploads/2026/04/Parts_Lists_CNS.pdf",
    "https://sawstop.com/product-category/parts/cns",
    "https://www.sawstop.com/support/warranty-information/",
    "https://www.amazon.com/dp/B006G36VHG",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /1\.75.*10-inch.*36-inch.*T-Glide/i);
  assert.match(fields.parts_availability.display_value, /partial.*official.*parts/i);
  assert.match(fields.repair_manual.display_value, /owner.*maintenance manual.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*cartridge.*gearing.*motor-belt/i);
  assert.match(fields.warranty.display_value, /two-year.*eligible original retail purchaser/i);
  assert.doesNotMatch(fields.warranty.raw_value, /registration/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /exact-SKU duration evidence.*service life.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B006G36VHG?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-30",
  }]);
});
