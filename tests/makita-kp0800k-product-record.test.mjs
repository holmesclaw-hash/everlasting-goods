import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-kp0800k";
const productUrl = "https://www.makitatools.com/products/details/KP0800K";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/KP0/69b0a804-31cf-45e1-a370-0dfb478ff682_KP0800K_IM.pdf";
const partsUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/KP0/99eafa22-ff0d-4654-9ef1-c525d875c5e6_KP0800K_PB.pdf";
const priceListUrl = "https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx";
const warrantyUrl = "https://www.makitatools.com/service/warranty";
const serviceUrl = "https://www.makitatools.com/service/service-centers";
const ownerUrl = "https://www.productreview.com.au/reviews/c9fb61e2-1546-5478-982c-9553c0d69fb4";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita KP0800K record preserves exact kit, regional, repair, parts, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "KP0800K");
  assert.equal(product.sku, "KP0800K");
  assert.equal(product.category, "handheld-planers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-09");
  assert.match(product.variant_notes, /current.*U\.S\..*cased kit.*KP0800.*planer.*D-46246.*123010-1.*782209-3.*165581-2.*824892-1.*KP0800KX.*230V.*regional.*not transferred/i);

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
    "https://www.cpsc.gov/manufacturer/makita",
    ownerUrl,
    "https://www.makitatools.com/products/buy-online/KP0800K",
    "https://www.amazon.com/dp/B0033WSK5O",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /3-1\/4-inch.*corded.*6\.5 AMP.*17,000 RPM.*3\/32-inch.*5\.7-pound/i);
  assert.match(fields.identity.raw_value, /current.*U\.S\..*KP0800K.*UPC 088381-603935.*cased kit/i);
  assert.match(fields.parts_availability.display_value, /partial.*exact.*parts breakdown.*September 2026.*motor.*drum.*belt.*switch.*cord.*base.*discontinued.*stock.*not verified/i);
  assert.match(fields.repair_manual.display_value, /owner manual.*blade.*sharpening.*carbon brushes.*not.*internal repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*blade.*brush.*internal repair.*authorized service/i);
  assert.match(fields.warranty.display_value, /one-year.*general-product.*original purchase.*current.*terms/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /owner report.*July 2020.*June 2022.*anecdotal.*expected service life.*failure rate.*repair economics.*recommendation remain unverified/i);

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
    verified_date: "2026-10-09",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0033WSK5O?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-09",
  }]);
});
