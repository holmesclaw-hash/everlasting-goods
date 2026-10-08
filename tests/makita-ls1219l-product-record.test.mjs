import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-ls1219l";
const productUrl = "https://www.makitatools.com/products/details/LS1219L";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/LS1/b54a9ea9-3bbb-491a-befd-b66075fc70e3_LS1219L_IM__885618A943_C1920.pdf";
const partsUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/LS1/d654a02d-1035-4495-9ada-4eb6b6bcc3b9_LS1219L_PB_Breakdown_LS1219L_01-18.pdf";
const priceListUrl = "https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx";
const warrantyUrl = "https://www.makitatools.com/service/warranty";
const serviceUrl = "https://www.makitatools.com/service/service-centers";
const ownerUrl = "https://www.reddit.com/r/Tools/comments/wrk0p0/ntd_bought_my_dream_saw_makita_ls1219l/";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita LS1219L record preserves exact package, service, parts, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "LS1219L");
  assert.equal(product.sku, "LS1219L");
  assert.equal(product.category, "miter-saws");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-08");
  assert.match(product.variant_notes, /standalone.*U\.S\..*1-inch arbor.*blade.*dust bag.*vertical vise.*triangular rule.*6 mm.*2\.5 mm.*stand.*not included.*LS1219LX.*WST06.*LS1219.*non-laser.*regional.*not transferred/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    priceListUrl,
    warrantyUrl,
    serviceUrl,
    "https://www.makitatools.com/service/directrepairfaq",
    "https://www.makitatools.com/recall",
    "https://www.cpsc.gov/s3fs-public/recall-data/recalls_recall_listing.csv",
    ownerUrl,
    "https://www.amazon.com/dp/B07B3WF2Y2",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /12-inch.*15 AMP.*3,200 RPM.*60°.*48°.*laser.*65-pound.*15-inch/i);
  assert.match(fields.identity.raw_value, /current.*U\.S\..*1-inch arbor/i);
  assert.match(fields.parts_availability.display_value, /partial.*exact.*parts breakdown.*September 2026.*brush.*armature.*field.*laser.*belt.*kerf board.*stock.*not verified/i);
  assert.match(fields.repair_manual.display_value, /owner manual.*blade.*alignment.*laser.*carbon brushes.*cleaning.*lubrication.*not.*internal repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*blade.*alignment.*laser.*brushes.*guard.*switch.*brake.*authorized service/i);
  assert.match(fields.warranty.display_value, /one-year.*general-product.*original purchase.*current.*terms/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /owner reports.*anecdotal.*mixed.*expected service life.*failure rate.*repair economics.*recommendation remain unverified/i);

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
    verified_date: "2026-10-08",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B07B3WF2Y2?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-08",
  }]);
});
