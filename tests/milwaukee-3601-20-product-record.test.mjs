import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "milwaukee-3601-20";
const productUrl = "https://www.milwaukeetool.com/products/details/m18-compact-brushless-1-2-drill-driver/3601-20";
const manualUrl = "https://documents.milwaukeetool.com/58-14-9845d2.pdf";
const partsUrl = "https://documents.milwaukeetool.com/54-06-2995R.pdf";
const warrantyUrl = "https://www.milwaukeetool.com/support/registration-and-warranty";
const ownerUrl = "https://www.reddit.com/r/MilwaukeeTool/comments/1u55mxz/how_do_i_replace_chuck_screw_that_sheared_off_on/";
const recallUrl = "https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=3601-20";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Milwaukee 3601-20 record preserves bare-tool, service-parts, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Milwaukee");
  assert.equal(product.model, "3601-20");
  assert.equal(product.sku, "3601-20");
  assert.equal(product.category, "drill-drivers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-25");
  assert.match(product.variant_notes, /3601-20.*M18.*compact.*brushless.*1\/2-inch.*bare[- ]tool/is);
  assert.match(product.variant_notes, /belt clip.*battery.*charger.*not included/is);
  assert.match(product.variant_notes, /3601-22CT.*kit/is);
  assert.match(product.variant_notes, /3602-20.*hammer drill/is);
  assert.match(product.variant_notes, /July 2025.*serial N66A/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [productUrl, manualUrl, partsUrl, warrantyUrl, ownerUrl, recallUrl]) {
    assert.ok(sourceUrls.has(url), `missing source ${url}`);
  }

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /3601-20.*M18.*brushless.*1\/2-inch.*bare[- ]tool/is);
  assert.match(fields.identity.display_value, /5\.7.*2\.3.*550.*0-550.*0-1,700/is);
  assert.match(fields.parts_availability.display_value, /Partial.*July 2025.*N66A/is);
  assert.match(fields.parts_availability.display_value, /chuck.*rotor.*gearbox.*electronic.*housing/is);
  assert.match(fields.parts_availability.display_value, /current individual orderability.*not.*verified/is);
  assert.match(fields.repair_manual.display_value, /no comprehensive owner repair manual/is);
  assert.match(fields.repair_manual.display_value, /service-parts list.*chuck.*wiring.*torque/is);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*cleaning.*inspection.*battery[- ]contact/is);
  assert.match(fields.warranty.display_value, /five-year.*limited.*original purchaser.*chucks.*normal[- ]wear/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");

  assert.match(product.recommendation_reasoning, /June 13, 2026.*chuck screw.*sheared/is);
  assert.match(product.recommendation_reasoning, /no purchase date.*ownership duration.*outcome/is);
  assert.match(product.recommendation_reasoning, /40-year.*not.*3601-20/is);
  assert.match(product.recommendation_reasoning, /recall.*empty.*not safety clearance/is);
  assert.match(product.recommendation_reasoning, /service life.*failure rate.*repair economics.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-25");

  assert.equal(product.warranty.warranty_length, "5-year limited power-tool warranty");
  assert.equal(product.warranty.verified_date, "2026-10-25");

  assert.equal(product.expected_service_life_years, null);
  assert.equal(product.street_price_cents, null);
  assert.equal(product.annual_maintenance_cost_cents, null);
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);
  assert.equal(product.image_license_basis, null);
  assert.equal(product.image_license_url, null);
  assert.equal(product.image_attribution, null);
  assert.equal(product.image_alt, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0CRPLWH24?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-25",
  }]);
});
