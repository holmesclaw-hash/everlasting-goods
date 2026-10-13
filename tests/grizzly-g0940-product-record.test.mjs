import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0940";
const productUrl = "https://www.grizzly.com/products/grizzly-13-2-hp-benchtop-planer-w-helical-cutterhead/g0940";
const specificationUrl = "https://cdn0.grizzly.com/specsheets/g0940_ds.pdf";
const manualUrl = "https://cdn0.grizzly.com/manuals/g0940_m.pdf";
const partsUrl = "https://www.grizzly.com/products/g0940/parts";
const partsListUrl = "https://cdn0.grizzly.com/partslists/g0940_pl.pdf";
const faqUrl = "https://support.grizzly.com/hc/en-us/articles/34323368216983-FAQ-G0940-13-2-HP-Benchtop-Planer-w-Helical-Cutterhead";
const bearingProcedureUrl = "https://support.grizzly.com/hc/en-us/articles/41752518807191-G0940-Planer-Cutterhead-Bearing-Replacement";
const insertCompatibilityUrl = "https://support.grizzly.com/hc/en-us/articles/39161065351319-Which-Knives-Inserts-or-Cutterhead-Upgrades-Fit-My-Jointer-or-Planer";
const brushUrl = "https://www.grizzly.com/parts/grizzly-carbon-brush-2-pk/p0940135";
const beltUrl = "https://www.grizzly.com/parts/grizzly-poly-v-belt-135j/p0940111";
const cutterheadUrl = "https://www.grizzly.com/parts/grizzly-cutterhead-13-helical/p0940129";
const insertUrl = "https://www.grizzly.com/products/grizzly-indexable-carbide-insert-15-x-15-x-2.5mm-10-pk./h9893";
const versionFourManualUrl = "https://www.grizzly.com/parts/grizzly-manual-g0939-g0940-mfd-10.25-v4.10.25/p0939manv4";
const ownerAdjustmentUrl = "https://forestryforum.com/board?topic=123522.0";
const shippingReportUrl = "https://sawmillcreek.org/threads/in-search-of-a-benchtop-wood-planer.295150/";
const cpscRecallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0940&format=json";
const separateRecallUrl = "https://www.cpsc.gov/Recalls/2026/Grizzly-Industrial-Recalls-Heavy-Duty-Planers-Due-to-Impact-and-Laceration-Hazards";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Grizzly G0940 record preserves revision, repair, recall, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0940");
  assert.equal(product.sku, "G0940");
  assert.equal(product.category, "benchtop-planers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-12");
  assert.match(product.variant_notes, /G0940.*13-inch.*2 HP.*120V.*single-phase.*15A.*two-row helical.*30.*H9893.*granite table/is);
  assert.match(product.variant_notes, /V3.*03\/25.*V4.*10\/25.*manufacture date.*serial/is);
  assert.match(product.variant_notes, /No .* transferred from G0939.*G0505.*G0959.*G0999.*G0815.*W1877/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    specificationUrl,
    manualUrl,
    partsUrl,
    partsListUrl,
    faqUrl,
    bearingProcedureUrl,
    insertCompatibilityUrl,
    brushUrl,
    beltUrl,
    cutterheadUrl,
    insertUrl,
    versionFourManualUrl,
    ownerAdjustmentUrl,
    shippingReportUrl,
    cpscRecallApiUrl,
    separateRecallUrl,
  ]) {
    assert.ok(sourceUrls.has(url), `missing source ${url}`);
  }

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-12");

  assert.equal(product.warranty.warranty_length, "1 year limited warranty");
  assert.equal(product.warranty.verified_date, "2026-10-12");

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0940.*13-inch.*2 HP.*120V.*single-phase.*15A.*30.*15 x 15 x 2\.5 mm.*granite table/is);
  assert.match(fields.parts_availability.display_value, /Partial.*exact-model.*catalog.*H9893.*brush.*belt.*cutterhead.*mixed.*motor.*feed rollers/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*insert.*brush.*belt.*pinion.*calibration.*advanced.*bearing.*not.*comprehensive/is);
  assert.match(fields.serviceability.display_value, /rotate or replace.*insert.*brush.*belt.*bearing.*advanced.*electrical.*qualified/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /scratch-and-dent.*three successive.*(?:shipping damage|damaged during shipping).*expected service life.*failure rate.*repair economics.*not yet verified/is);

  assert.equal(product.expected_service_life_years, null);
  assert.equal(product.street_price_cents, null);
  assert.equal(product.annual_maintenance_cost_cents, null);
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);
  assert.equal(product.image_license_basis, null);
  assert.equal(product.image_license_url, null);
  assert.equal(product.image_attribution, null);
  assert.equal(product.image_alt, null);

  assert.equal(product.affiliate_links.length, 1);
  assert.equal(product.affiliate_links[0].program_name, "Amazon Associates");
  assert.equal(product.affiliate_links[0].url, "https://www.amazon.com/dp/B0BBKQ4W6S?tag=everlastin08f-20");
  assert.equal(product.affiliate_links[0].exact_model, true);
  assert.equal(product.affiliate_links[0].verified_date, "2026-10-12");
});
