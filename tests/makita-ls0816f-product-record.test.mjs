import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-ls0816f";
const productUrl = "https://www.makitatools.com/products/details/LS0816F";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/LS0/5a667c69-f6b2-4cc6-89d1-683656871f48_LS0816F_IM_NA3-2311.pdf";
const partsUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/LS0/f3b24fa2-2e6e-451c-86a1-2497a27b408b_LS0816F_PB_Breakdown_LS0816F_11-24.pdf";
const priceListUrl = "https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx";
const warrantyUrl = "https://www.makitatools.com/service/warranty";
const serviceUrl = "https://www.makitatools.com/service/service-centers";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita LS0816F record preserves U.S. package, maintenance, parts, and regional boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "LS0816F");
  assert.equal(product.sku, "LS0816F");
  assert.equal(product.category, "miter-saws");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-07");
  assert.match(product.variant_notes, /U\.S\..*120V.*5\/8-inch arbor.*blade.*hex wrench.*dust bag.*vertical vise.*stand.*not included.*LS0815F.*LS0815FL.*LS1019L.*regional.*not transferred/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    priceListUrl,
    warrantyUrl,
    serviceUrl,
    "https://www.makitatools.com/service/directrepair",
    "https://www.makitatools.com/recall",
    "https://www.cpsc.gov/s3fs-public/recall-data/recalls_recall_listing.csv",
    "https://www.amazon.com/dp/B0CRHR8FBC",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /8-1\/2-inch.*corded.*10\.5 AMP.*5,000 RPM.*47°.*LED.*30\.6.*12-inch/i);
  assert.match(fields.identity.raw_value, /miter range.*47 degrees left and right.*bevel range.*47 degrees left and 2 degrees right/i);
  assert.doesNotMatch(fields.identity.raw_value, /dual-bevel|60 degrees right/i);
  assert.match(fields.parts_availability.display_value, /partial.*exact.*parts breakdown.*September 2026.*motor.*switch.*soft-start.*guards.*brushes.*stock.*not verified/i);
  assert.match(fields.repair_manual.display_value, /owner manual.*blade.*carbon brushes.*alignment.*cleaning.*lubrication.*not.*internal repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*blade.*brushes.*alignment.*guard.*switch.*brake.*authorized service/i);
  assert.match(fields.warranty.display_value, /one-year.*general-product.*original purchase.*current.*terms/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /exact.*owner manual.*parts breakdown.*price list.*no qualifying.*owner.*duration.*expected service life.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.warranty, {
    warranty_length: "One-year general-product limited warranty.",
    warranty_coverage: "Defects in workmanship and materials; Makita may repair or replace after inspection under the current policy.",
    warranty_exclusions: "Repairs made or attempted by others, normal wear and tear, abuse, misuse, improper maintenance or operation, alterations, and accessories are excluded; current Makita terms apply.",
    source_url: warrantyUrl,
    verified_date: "2026-10-07",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0CRHR8FBC?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-07",
  }]);
});
