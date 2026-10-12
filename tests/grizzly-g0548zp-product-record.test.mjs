import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0548zp";
const productUrl = "https://www.grizzly.com/products/grizzly-2-hp-canister-dust-collector-w-aluminum-impeller/g0548zp";
const specificationUrl = "https://cdn1.grizzly.com/specsheets/g0548zp_ds.pdf";
const manualUrl = "https://cdn0.grizzly.com/manuals/g0548zp_m.pdf";
const partsUrl = "https://www.grizzly.com/products/g0548zp/parts";
const partsListUrl = "https://cdn0.grizzly.com/partslists/g0548zp_pl.pdf";
const warrantyUrl = "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty";
const repairUrl = "https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item";
const motorUrl = "https://www.grizzly.com/parts/grizzly-motor-2hp-240v-1-ph/p0548zp017";
const adapterUrl = "https://www.grizzly.com/parts/grizzly-inlet-adapter-6-x-4-x-3-pc-v2.01.22/p0548zp029v2";
const collectionBagUrl = "https://www.grizzly.com/products/grizzly-plastic-lower-bag-500mm-3-pack/t21821";
const cpscRecallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0548ZP&format=json";
const ownerReportUrl = "https://www.reddit.com/r/woodworking/comments/h03chl/dust_collector_grizzly_g0548zp_or_shop_fox_w1666/";
const supportAnecdoteUrl = "https://sawmillcreek.org/threads/grizzly-dust-collector-spewing-fine-dust.206845/";
const measuredComparisonUrl = "https://davidmpeters.wordpress.com/2017/01/08/jet-jcdc-2-vs-grizzly-g0548zp-showdown/";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Grizzly G0548ZP record preserves configuration, revision, support, and evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0548ZP");
  assert.equal(product.sku, "G0548ZP");
  assert.equal(product.category, "dust-collectors");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-12");
  assert.match(product.variant_notes, /G0548ZP.*single-stage.*2 HP.*240V.*single-phase.*three 4-inch.*1-micron canister.*12-3\/4-inch.*aluminum impeller/is);
  assert.match(product.variant_notes, /No .* (?:are )?transferred from G0548Z.*G0548.*G1028Z2.*G1029Z2.*G1029Z2P.*W1666.*SB1100/is);
  assert.match(product.variant_notes, /post-2021.*P0548ZP029V2.*manufacture date/is);

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
    adapterUrl,
    collectionBagUrl,
    cpscRecallApiUrl,
    ownerReportUrl,
    supportAnecdoteUrl,
    measuredComparisonUrl,
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
  assert.equal(product.warranty.source_url, warrantyUrl);
  assert.equal(product.warranty.verified_date, "2026-10-12");

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0548ZP.*single-stage.*2 HP.*240V.*single-phase.*one 6-inch.*inlet.*three 4-inch ports.*1-micron canister.*12-3\/4-inch aluminum impeller/is);
  assert.match(fields.parts_availability.display_value, /Partial.*exact-model catalog.*motor.*collector body.*post-2021 inlet adapter.*collection bags.*canister.*impeller orderability.*not.*confirmed/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*assembly.*system[- ]design.*maintenance.*troubleshooting.*wiring.*illustrated[- ]parts.*does not provide.*comprehensive.*internal repair/is);
  assert.match(fields.serviceability.display_value, /clean.*replace.*canister.*collection bag.*cataloged assemblies.*qualified.*repair intake/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /few months.*new-unit filter.*2017.*measured comparison.*expected service life.*failure rate.*repair economics.*not yet verified/is);

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
  assert.equal(product.affiliate_links[0].url, "https://www.amazon.com/dp/B00DQJPBJ2?tag=everlastin08f-20");
  assert.equal(product.affiliate_links[0].exact_model, true);
  assert.equal(product.affiliate_links[0].verified_date, "2026-10-12");
});
