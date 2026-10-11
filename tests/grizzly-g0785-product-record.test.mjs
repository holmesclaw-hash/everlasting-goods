import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0785";
const productUrl = "https://www.grizzly.com/products/grizzly-1-hp-wall-mount-dust-collector-with-canister-filter/g0785";
const specificationUrl = "https://cdn0.grizzly.com/specsheets/g0785_ds.pdf";
const manualUrl = "https://cdn0.grizzly.com/manuals/g0785_m.pdf";
const partsUrl = "https://www.grizzly.com/products/g0785/parts";
const partsListUrl = "https://cdn0.grizzly.com/partslists/g0785_pl.pdf";
const warrantyUrl = "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty";
const repairUrl = "https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item";
const motorUrl = "https://www.grizzly.com/parts/grizzly-motor-1hp-120-240v-1-ph/p0785010";
const impellerUrl = "https://www.grizzly.com/parts/grizzly-aluminium-impeller-10/p0785009";
const collectionBagUrl = "https://www.grizzly.com/products/grizzly-dust-collection-bag-for-g0785-and-g0944-series-3-pk./t21820";
const obsoleteCollectionBagUrl = "https://www.grizzly.com/products/grizzly-dust-collection-bag-for-g0583z-g0785-and-g0944-series/t24268";
const cpscRecallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0785&format=json";
const blockedCpscSearchUrl = "https://www.cpsc.gov/Recalls?search_combined_fields=G0785";
const independentTestUrl = "https://www.finewoodworking.com/project-guides/shop-machines/tool-test-wall-mounted-dust-collectors";
const ownerReportUrl = "https://www.reddit.com/r/woodworking/comments/1n2x91e/is_a_dedicated_dust_collection_set_up_worth_it/";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Grizzly G0785 record preserves exact configuration, support, and evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0785");
  assert.equal(product.sku, "G0785");
  assert.equal(product.category, "dust-collectors");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-11");
  assert.match(product.variant_notes, /G0785.*single-stage.*1 HP.*120V\/240V.*1-micron.*canister/is);
  assert.match(product.variant_notes, /No .* transferred from G0785Z.*G0944.*G0944HEP.*W1844/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    specificationUrl,
    manualUrl,
    partsUrl,
    partsListUrl,
    warrantyUrl,
    repairUrl,
    motorUrl,
    impellerUrl,
    collectionBagUrl,
    cpscRecallApiUrl,
    independentTestUrl,
    ownerReportUrl,
  ]) {
    assert.ok(sourceUrls.has(url), `missing source ${url}`);
  }
  assert.equal(sourceUrls.has(obsoleteCollectionBagUrl), false, "obsolete T24268 destination must not support current G0785 bag orderability");
  assert.equal(sourceUrls.has(blockedCpscSearchUrl), false, "blocked CPSC search page must not stand in for a fetched recall query");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-11");

  assert.equal(product.warranty.warranty_length, "1 year limited warranty");
  assert.equal(product.warranty.source_url, warrantyUrl);
  assert.equal(product.warranty.verified_date, "2026-10-11");

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0785.*wall-mount.*single-stage.*1 HP.*120V\/240V.*one 4-inch inlet.*1-micron canister/is);
  assert.match(fields.parts_availability.display_value, /Partial.*exact-model.*catalog.*motor.*impeller.*canister filter.*collection bags/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*maintenance.*troubleshooting.*wiring.*impeller-tightening.*does not provide.*comprehensive.*internal repair/is);
  assert.match(fields.serviceability.display_value, /clean.*replace.*filter.*collection bag.*impeller.*qualified.*repair intake/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /2020.*hands-on.*no ownership duration.*owner.*planer and jointer.*expected service life.*failure rate.*repair economics.*not yet verified/is);

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
  assert.equal(product.affiliate_links[0].url, "https://www.amazon.com/dp/B083JQWX18?tag=everlastin08f-20");
  assert.equal(product.affiliate_links[0].exact_model, true);
  assert.equal(product.affiliate_links[0].verified_date, "2026-10-11");
});
