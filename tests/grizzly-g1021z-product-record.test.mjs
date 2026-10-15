import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g1021z";
const productUrl = "https://www.grizzly.com/products/grizzly-15-3-hp-planer-with-cabinet-stand/g1021z";
const specificationUrl = "https://cdn0.grizzly.com/specsheets/g1021z_ds.pdf";
const manualUrl = "https://cdn0.grizzly.com/manuals/g1021z_m.pdf";
const partsUrl = "https://www.grizzly.com/products/g1021z/parts";
const partsListUrl = "https://cdn0.grizzly.com/partslists/g1021z_pl.pdf";
const motorUrl = "https://www.grizzly.com/parts/P1021Z016V2";
const switchUrl = "https://www.grizzly.com/parts/P1021Z040V2";
const knivesUrl = "https://www.grizzly.com/parts/P1021Z170";
const gearboxUrl = "https://www.grizzly.com/parts/P1021Z109AV2";
const partsPolicyUrl = "https://support.grizzly.com/hc/en-us/articles/4405505042839-How-can-I-purchase-parts";
const repairUrl = "https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item";
const warrantyUrl = "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty";
const ownerRebuildUrl = "https://www.woodworkingtalk.com/threads/grizzly-g1021z-planer-rebuild-helical-cutter-install-and-other-upgrades.221945/";
const ownerReliabilityUrl = "https://sawmillcreek.org/threads/grizzly-g1021-planer-opinions-please.219189/";
const recallsUrl = "https://www.grizzly.com/recalls";
const recallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G1021Z&format=json";
const separateRecallUrl = "https://www.cpsc.gov/Recalls/2026/Grizzly-Industrial-Recalls-Heavy-Duty-Planers-Due-to-Impact-and-Laceration-Hazards";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Grizzly G1021Z record preserves exact identity, revisions, support, and evidence limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G1021Z");
  assert.equal(product.sku, "G1021Z");
  assert.equal(product.category, "stationary-planers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-15");
  assert.match(product.variant_notes, /G1021Z.*15-inch.*3 HP.*230V.*single-phase.*12A.*three-knife.*cabinet stand/is);
  assert.match(product.variant_notes, /manual versions.*01\/00.*04\/20/is);
  assert.match(product.variant_notes, /manufacture date.*ID label.*matching manual version/is);
  assert.match(product.variant_notes, /12A.*474.*15A.*507.*conflict/is);
  assert.match(product.variant_notes, /G1021X2.*G1021(?!Z).*G0453Z.*G0815/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    specificationUrl,
    manualUrl,
    partsUrl,
    partsListUrl,
    motorUrl,
    switchUrl,
    knivesUrl,
    gearboxUrl,
    partsPolicyUrl,
    repairUrl,
    warrantyUrl,
    ownerRebuildUrl,
    ownerReliabilityUrl,
    recallsUrl,
    recallApiUrl,
    separateRecallUrl,
  ]) assert.ok(sourceUrls.has(url), `missing source ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G1021Z.*15-inch.*3 HP.*230V.*single-phase.*12A.*three-knife.*15 x 1 x 1\/8.*16 and 28 FPM/is);
  assert.match(fields.parts_availability.display_value, /Partial.*revision-aware.*substitut.*motor.*magnetic switch.*knives.*gearbox/is);
  assert.match(fields.parts_availability.display_value, /not every.*orderable/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*setup.*maintenance.*troubleshooting.*wiring.*illustrated.*parts.*knife.*belt.*chain.*gearbox.*not.*comprehensive/is);
  assert.match(fields.serviceability.display_value, /knives.*belts.*chains.*gearbox oil.*230V.*qualified.*474-pound.*freight/is);
  assert.match(fields.warranty.display_value, /one-year.*original purchaser.*consumables.*non-transferable/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /purchas.*2005.*outdoors.*15 years.*bearings.*rebuild/is);
  assert.match(product.recommendation_reasoning, /reliable.*two years.*anecdotes.*failure rate.*repair economics.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-15");

  assert.equal(product.warranty.warranty_length, "1 year limited warranty");
  assert.equal(product.warranty.verified_date, "2026-10-15");

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
    url: "https://www.amazon.com/dp/B0000DD0AS?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-15",
  }]);
});
