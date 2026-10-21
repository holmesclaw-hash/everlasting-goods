import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "bosch-gsr18v-535fcb15";
const productUrl = "https://www.boschtools.com/us/en/products/gsr18v-535fcb15-06019G7114";
const manualUrl = "https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf";
const partsUrl = "https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110";
const warrantyUrl = "https://www.boschtools.com/us/en/service/product-warranty";
const longTermReviewUrl = "https://www.finehomebuilding.com/2026/07/20/multi-head-drills";
const ownerThreadUrl = "https://festoolownersgroup.com/threads/bosch-18v-cabinet-makers-drill.69974/";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Bosch GSR18V-535FCB15 record preserves exact kit identity, current parts support, and bounded owner evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Bosch");
  assert.equal(product.model, "GSR18V-535FCB15");
  assert.equal(product.sku, "06019G7114");
  assert.equal(product.category, "drill-drivers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-21");
  assert.match(product.variant_notes, /GSR18V-535FCB15.*06019G7114.*GSR18V-535FC.*one.*4 Ah.*charger.*metal keyless chuck.*right-angle.*offset-angle.*carrying bag/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [productUrl, manualUrl, partsUrl, warrantyUrl, longTermReviewUrl, ownerThreadUrl]) {
    assert.ok(sourceUrls.has(url), `missing source ${url}`);
  }

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /06019G7114.*535 in.-lb.*4 Ah.*three.*attachments/is);
  assert.match(fields.parts_availability.display_value, /Partial.*current.*3601JG7110.*gearbox.*electronics.*motor.*attachments/is);
  assert.match(fields.repair_manual.display_value, /operating and safety manual.*not an owner-repair manual/is);
  assert.match(fields.serviceability.display_value, /owner care.*cleaning.*qualified repair personnel.*Bosch.*authorized service/is);
  assert.match(fields.warranty.display_value, /5-year.*18V power tool.*3-year.*battery.*original end-user/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");

  assert.match(product.recommendation_reasoning, /over three years.*thousands of holes.*attachment.*about a year.*anecdotal.*expected service life.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-21");

  assert.equal(product.warranty.warranty_length, "5 years for the 18V power tool; 3 years for the included 18V battery.");
  assert.equal(product.warranty.source_url, warrantyUrl);
  assert.equal(product.warranty.verified_date, "2026-10-21");

  assert.equal(product.expected_service_life_years, null);
  assert.equal(product.street_price_cents, null);
  assert.equal(product.annual_maintenance_cost_cents, null);
  assert.equal(product.image_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B07Z5QNBVS?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-21",
  }]);
});
