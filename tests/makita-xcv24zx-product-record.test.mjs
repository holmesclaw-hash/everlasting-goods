import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-xcv24zx";
const productUrl = "https://www.makitatools.com/products/details/XCV24ZX";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/XCV/b58f6877-de2d-4939-96c0-2ea531cdeddd_XCV24_IM.pdf";
const partsUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/XCV/2c7a26bd-5cec-457d-87d5-c35c68b0d626_XCV24_PB_Breakdown_XCV24ZX_03-22.pdf";
const warrantyUrl = "https://www.makitatools.com/service/warranty";
const serviceUrl = "https://www.makitatools.com/service/service-centers";
const partsSnapshotUrl = "https://www.ereplacementparts.com/models/canister-vacuum/makita/id1348887/xcv24zx/";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita XCV24ZX record preserves discontinued package, parts, and service boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "XCV24ZX");
  assert.equal(product.sku, "XCV24ZX");
  assert.equal(product.category, "dust-extractors");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-05");
  assert.match(product.variant_notes, /XCV24ZX.*tool-only.*discontinued.*batteries.*charger.*not included.*XCV21.*XCV25.*XCV23.*not transferred/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    warrantyUrl,
    serviceUrl,
    partsSnapshotUrl,
    "https://cdn.makitatools.com/apps/cms/doc/prod/XCV/f0459c40-0721-4500-849e-c26581c4f5ef_XCV24ZX_NTFE.pdf",
    "https://makitatools.com/company/press-releases/2022/makita-expands-dust-extraction-system-with-two-new-hepa-dry-vacuums",
    "https://www.amazon.com/dp/B09SNVX392",
    "https://toolup.com/products/makita-xcv24zx-36v-18v-x2-lxt-hepa-filter-dry-dust-extractor-4-gal-tool-only",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /36V.*18V X2.*(?:4|four)-gallon.*dry.*tool-only.*batteries.*charger.*not included.*UPC.*088381898959/i);
  assert.match(fields.parts_availability.display_value, /partial.*XCV24.*parts breakdown.*motor.*rotor.*stator.*controller.*filters.*mixed.*orderability/i);
  assert.match(fields.repair_manual.display_value, /owner.*filter.*tank.*battery.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /owner.*filters.*tank.*internal.*authorized service/i);
  assert.match(fields.warranty.display_value, /three-year.*tool.*batter(?:y|ies).*charger/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /introduced.*2022.*discontinued.*no qualifying.*owner.*duration.*expected service life.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B09SNVX392?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-05",
  }]);
});
