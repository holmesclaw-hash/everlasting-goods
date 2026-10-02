import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "sawstop-jss-120a60";
const productUrl = "https://www.sawstop.com/product/jobsite-saw-pro-jss-120a60";
const manualUrl = "https://www.sawstop.com/wp-content/uploads/2026/04/Jobsite-Saw-Pro-Owners-Manual.pdf";
const partsListUrl = "https://www.sawstop.com/wp-content/uploads/2026/04/Parts-Lists-JSS-Pro-WEB-1.pdf";
const partsUrl = "https://www.sawstop.com/product-category/parts/jss/jss-120a60/";
const beltProcedureUrl = "https://www.sawstop.com/wp-content/uploads/2025/10/Belt-Replacing-JSS-Belt-Motor.pdf";
const switchBoxProcedureUrl = "https://www.sawstop.com/wp-content/uploads/2025/10/Switchbox-JSS-Switchbox-Replacement.pdf";
const warrantyUrl = "https://www.sawstop.com/support/warranty-information/";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the SawStop JSS-120A60 record preserves package, repair, and evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "SawStop");
  assert.equal(product.model, "Jobsite Saw Pro");
  assert.equal(product.sku, "JSS-120A60");
  assert.equal(product.category, "table-saws");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-02");
  assert.match(product.variant_notes, /JSS-120A60.*120V.*full set.*mobile cart.*JSS-230A50I.*JSS-MCA.*CTS-120A60/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsListUrl,
    partsUrl,
    beltProcedureUrl,
    switchBoxProcedureUrl,
    warrantyUrl,
    "https://www.amazon.com/dp/B07WV5X277",
    "https://www.mcguckin.com/2925123/product/Sawstop-JSS-120A60",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /120V.*15A.*10-inch.*mobile cart.*25-1\/2-inch/i);
  assert.match(fields.parts_availability.display_value, /partial.*motor.*switch box.*fence.*cart/i);
  assert.match(fields.repair_manual.display_value, /owner's manual.*service procedures.*belt.*switch-box/i);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*power-cord.*blade-guard.*belt.*switch-box/i);
  assert.match(fields.warranty.display_value, /two-year.*registration/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /no qualifying exact-SKU duration evidence.*expected service life.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 1);
  assert.equal(product.repairability.repair_manual_url, switchBoxProcedureUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B07WV5X277?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-02",
  }]);
});
