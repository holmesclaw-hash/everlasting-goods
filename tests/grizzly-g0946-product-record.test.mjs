import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0946";
const productUrl = "https://www.grizzly.com/products/grizzly-6-benchtop-jointer-with-spiral-type-cutterhead/g0946";
const specificationUrl = "https://cdn0.grizzly.com/specsheets/g0946_ds.pdf";
const manualUrl = "https://cdn0.grizzly.com/manuals/g0946_m.pdf";
const partsUrl = "https://www.grizzly.com/products/g0946/parts";
const replacementInsertUrl = "https://www.grizzly.com/products/grizzly-indexable-carbide-inserts-14.25-x-14.25-x-2mm-10-pk./t32739";
const partsPolicyUrl = "https://support.grizzly.com/hc/en-us/articles/4405505042839-How-can-I-purchase-parts";
const repairUrl = "https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item";
const warrantyUrl = "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty";
const ownerUrl = "https://www.lumberjocks.com/threads/review-grizzly-g0946-6-inch-bench-top-spiral-head-jointer.357799/";
const recallsUrl = "https://www.grizzly.com/recalls";
const recallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0946&format=json";
const imageRightsUrl = "https://support.grizzly.com/hc/en-us/articles/4404772793495-Grizzly-Terms-Conditions";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Grizzly G0946 record preserves exact identity, insert conflicts, support, and evidence limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0946");
  assert.equal(product.sku, "G0946");
  assert.equal(product.category, "benchtop-jointers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-15");
  assert.match(product.variant_notes, /G0946.*six-inch.*1-1\/2 HP.*120V.*10A.*12.*14 x 14 x 2.*HSS/is);
  assert.match(product.variant_notes, /manual.*manufactured since 12\/23.*manufacture date.*ID label/is);
  assert.match(product.variant_notes, /G0945.*straight-knife.*G0947.*(?:8|eight)-inch.*G0986.*(?:10|ten)-inch/is);
  assert.match(product.variant_notes, /HSS.*carbide.*26.*12.*T32937.*saw-blade.*conflict/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    specificationUrl,
    manualUrl,
    partsUrl,
    replacementInsertUrl,
    partsPolicyUrl,
    repairUrl,
    warrantyUrl,
    ownerUrl,
    recallsUrl,
    recallApiUrl,
    imageRightsUrl,
  ]) assert.ok(sourceUrls.has(url), `missing source ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0946.*(?:6|six)-inch.*1-1\/2 HP.*120V.*10A.*six-row.*12.*HSS.*14 x 14 x 2.*11,000 RPM/is);
  assert.match(fields.parts_availability.display_value, /Partial.*table assembly.*cutterhead assembly.*belt.*bearing.*motor.*brush.*switch.*cord/is);
  assert.match(fields.parts_availability.display_value, /not every.*orderable/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*maintenance.*troubleshooting.*insert.*table parallelism.*fence.*belt.*motor[- ]brush.*wiring.*not.*comprehensive/is);
  assert.match(fields.serviceability.display_value, /rotate or replace.*inserts.*belt.*motor[- ]brush.*adjust.*table.*fence/is);
  assert.match(fields.warranty.display_value, /one-year.*original purchaser.*proof of purchase/is);
  assert.match(fields.warranty.display_value, /consumables.*misuse.*wiring.*maintenance/is);
  assert.match(fields.insert_compatibility.display_value, /12.*HSS.*14 x 14 x 2/is);
  assert.match(fields.insert_compatibility.display_value, /P0946160-2.*carbide/is);
  assert.match(fields.insert_compatibility.display_value, /14\.25 x 14\.25 x 2.*T32739.*26.*12/is);
  assert.match(fields.insert_compatibility.display_value, /T32937.*saw-blade/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /April 5, 2024.*early-use.*6\/4 rough cherry/is);
  assert.match(product.recommendation_reasoning, /anecdote.*expected service life.*failure rate.*repair economics.*not yet verified/is);
  assert.match(product.recommendation_reasoning, /recall.*empty.*not safety clearance/is);

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
    url: "https://www.amazon.com/dp/B0B75GFZ98?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-15",
  }]);
});
