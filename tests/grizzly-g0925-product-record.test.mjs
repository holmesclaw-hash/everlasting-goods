import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0925";
const productUrl = "https://www.grizzly.com/products/grizzly-8-benchtop-drill-press/g0925";
const specificationUrl = "https://cdn0.grizzly.com/specsheets/g0925_ds.pdf";
const manualUrl = "https://cdn0.grizzly.com/manuals/g0925_m.pdf";
const partsListUrl = "https://cdn0.grizzly.com/partslists/g0925_pl.pdf";
const partsUrl = "https://www.grizzly.com/products/g0925/parts";
const partsPolicyUrl = "https://support.grizzly.com/hc/en-us/articles/4405505042839-How-can-I-purchase-parts";
const repairUrl = "https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item";
const warrantyUrl = "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty";
const warrantyClaimUrl = "https://support.grizzly.com/hc/en-us/articles/34277374404503-How-Do-I-Submit-a-Warranty-Claim";
const ownerUrl = "https://www.garagejournal.com/forum/threads/attn-rockler-woodworking-regulars.502568/";
const retailerOwnerUrl = "https://www.mowersatjacks.com/product-details/grizzly/g0925";
const recallsUrl = "https://www.grizzly.com/recalls";
const recallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0925&format=json";
const imageRightsUrl = "https://support.grizzly.com/hc/en-us/articles/4404772793495-Grizzly-Terms-Conditions";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Grizzly G0925 record preserves exact identity, revision boundaries, support, and evidence limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0925");
  assert.equal(product.sku, "G0925");
  assert.equal(product.category, "drill-presses");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-16");
  assert.match(product.variant_notes, /G0925.*(?:8|eight)-inch.*1\/3 HP.*120V.*2\.3A.*(?:5|five).*740.*3140.*JT33/is);
  assert.match(product.variant_notes, /manufactured since 02\/20.*manufacture date.*ID label/is);
  assert.match(product.variant_notes, /depth stop bracket.*chuck guard/is);
  assert.match(product.variant_notes, /T32006.*variable-speed.*W1667.*oscillating/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    specificationUrl,
    manualUrl,
    partsListUrl,
    partsUrl,
    partsPolicyUrl,
    repairUrl,
    warrantyUrl,
    warrantyClaimUrl,
    ownerUrl,
    retailerOwnerUrl,
    recallsUrl,
    recallApiUrl,
    imageRightsUrl,
  ]) assert.ok(sourceUrls.has(url), `missing source ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0925.*(?:8|eight)-inch.*1\/3 HP.*120V.*2\.3A.*TEFC.*induction.*belt.*(?:5|five).*740.*3140.*JT33/is);
  assert.match(fields.parts_availability.display_value, /Partial.*V-belt.*motor.*capacitor.*chuck.*quill.*bearing.*switch.*table/is);
  assert.match(fields.parts_availability.display_value, /not every.*orderable/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*maintenance.*troubleshooting.*spring tension.*pulley.*wiring.*illustrated parts.*not.*comprehensive/is);
  assert.match(fields.serviceability.display_value, /spindle speed.*belt.*spring tension.*align.*pulley.*clean.*lubricat/is);
  assert.match(fields.warranty.display_value, /one-year.*original purchaser.*proof of purchase/is);
  assert.match(fields.warranty.display_value, /consumables.*misuse.*wiring.*maintenance/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /August 20, 2022.*working aluminum.*portable/is);
  assert.match(product.recommendation_reasoning, /March 15, 2024.*April 14, 2024/is);
  assert.match(product.recommendation_reasoning, /no purchase date.*ownership duration.*repair history/is);
  assert.match(product.recommendation_reasoning, /expected service life.*failure rate.*repair economics.*not yet verified/is);
  assert.match(product.recommendation_reasoning, /recall.*empty.*not safety clearance/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-16");

  assert.equal(product.warranty.warranty_length, "1 year limited warranty");
  assert.equal(product.warranty.verified_date, "2026-10-16");

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
    url: "https://www.amazon.com/dp/B088FZKW39?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-16",
  }]);
});
