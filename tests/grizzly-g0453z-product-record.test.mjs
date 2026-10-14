import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0453z";
const productUrl = "https://www.grizzly.com/products/grizzly-15-3-hp-planer-w-spiral-cutterhead/g0453z";
const specificationUrl = "https://cdn0.grizzly.com/specsheets/g0453z_ds.pdf";
const manualUrl = "https://cdn0.grizzly.com/manuals/g0453z_m.pdf";
const partsUrl = "https://www.grizzly.com/products/g0453z/parts";
const partsListUrl = "https://cdn0.grizzly.com/partslists/g0453z_pl.pdf";
const faqUrl = "https://support.grizzly.com/hc/en-us/articles/35556139763863-FAQ-G0453Z-G0453ZX-15-Planer";
const parallelismUrl = "https://support.grizzly.com/hc/en-us/articles/41750070246423-Checking-and-Adjusting-Table-Parallelism-on-Fixed-Head-Planers";
const newerInsertUrl = "https://www.grizzly.com/products/grizzly-indexable-carbide-inserts-14-x-14-x-2mm-10-pk./h7319";
const olderInsertUrl = "https://www.grizzly.com/products/grizzly-indexable-carbide-inserts-14.18-x-14.18-x-2mm-10-pk./t21348";
const motorUrl = "https://www.grizzly.com/parts/P0453Z518V2";
const switchUrl = "https://www.grizzly.com/parts/P0453Z551V2";
const rollerUrl = "https://www.grizzly.com/parts/P0453Z063V2";
const ownerMotorUrl = "https://sawmillcreek.org/threads/15-planer-recommendations.192413/post-1986882";
const ownerBeltUrl = "https://sawmillcreek.org/threads/grizzly-g0453w-planer-belt-life.262847/post-2786219";
const ownerLeakUrl = "https://sawmillcreek.org/threads/grizzly-15-planer-leaking-gearbox-oil.197376/post-2040047";
const ownerSwitchUrl = "https://www.lumberjocks.com/threads/grizzly-15-inch-planer-help.56358/";
const recallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0453Z&format=json";
const separateRecallUrl = "https://www.cpsc.gov/Recalls/2026/Grizzly-Industrial-Recalls-Heavy-Duty-Planers-Due-to-Impact-and-Laceration-Hazards";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Grizzly G0453Z record preserves exact identity, revisions, support, and evidence limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0453Z");
  assert.equal(product.sku, "G0453Z");
  assert.equal(product.category, "stationary-planers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-14");
  assert.match(product.variant_notes, /G0453Z.*15-inch.*3 HP.*240V.*single-phase.*15A.*four-row spiral.*74.*indexable carbide inserts/is);
  assert.match(product.variant_notes, /03\/15.*T21348.*04\/15.*H7319.*manufacture date.*ID label/is);
  assert.match(product.variant_notes, /09\/17.*outfeed roller/is);
  assert.match(product.variant_notes, /G0453(?!Z).*G0453P.*G0453PX.*G0453W.*G0453ZW.*G0453ZX.*G0454Z.*G0815/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    specificationUrl,
    manualUrl,
    partsUrl,
    partsListUrl,
    faqUrl,
    parallelismUrl,
    newerInsertUrl,
    olderInsertUrl,
    motorUrl,
    switchUrl,
    rollerUrl,
    ownerMotorUrl,
    ownerBeltUrl,
    ownerLeakUrl,
    ownerSwitchUrl,
    recallApiUrl,
    separateRecallUrl,
  ]) assert.ok(sourceUrls.has(url), `missing source ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0453Z.*15-inch.*3 HP.*240V.*single-phase.*15A.*four-row spiral.*74.*14 x 14 x 2 mm/is);
  assert.match(fields.parts_availability.display_value, /Partial.*revision-aware.*H7319.*T21348.*motor.*magnetic switch.*outfeed roller.*not.*every.*orderable/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*maintenance.*troubleshooting.*wiring.*illustrated.*parts.*insert.*belt.*chain.*adjustment.*not.*comprehensive/is);
  assert.match(fields.serviceability.display_value, /rotate or replace.*insert.*belt.*chain.*table parallelism.*240V.*qualified.*655-pound.*freight/is);
  assert.match(fields.warranty.display_value, /one-year.*original purchaser.*consumables.*non-transferable/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /two-year.*motor.*three-year.*oil leak.*four-year.*centrifugal switch.*since 2010.*same belts.*anecdotal.*failure rate.*repair economics.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-14");

  assert.equal(product.warranty.warranty_length, "1 year limited warranty");
  assert.equal(product.warranty.verified_date, "2026-10-14");

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
    url: "https://www.amazon.com/dp/B0017IF2RU?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-14",
  }]);
});
