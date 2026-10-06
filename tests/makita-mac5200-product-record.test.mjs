import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-mac5200";
const productUrl = "https://www.makitatools.com/products/details/MAC5200";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/MAC/6c053afe-5af8-4199-9800-542d3ad26216_MAC5200_IM.pdf";
const partsUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/MAC/22580537-bd3c-41b9-ac3f-25cdf10bbfc0_MAC5200_PB.pdf";
const warrantyUrl = "https://www.makitatools.com/service/warranty";
const serviceUrl = "https://www.makitatools.com/service/service-centers";
const priceListUrl = "https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita MAC5200 record preserves maintenance, repair, parts, and package boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "MAC5200");
  assert.equal(product.sku, "MAC5200");
  assert.equal(product.category, "air-compressors");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-05");
  assert.match(product.variant_notes, /MAC5200.*120V.*5\.2-gallon.*oil-lubricated.*quick couplers.*does not list.*hose.*air tool.*included.*MAC2400.*MAC700.*not transferred/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    warrantyUrl,
    serviceUrl,
    "https://www.makitatools.com/service/directrepair",
    "https://www.makitatools.com/recall",
    priceListUrl,
    "https://www.amazon.com/dp/B0001Q2VPU",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /120V.*3\.0 HP.*5\.2-gallon.*oil-lubricated.*6\.5 CFM.*90 PSI.*140 PSI.*couplers/i);
  assert.match(fields.parts_availability.display_value, /partial.*exact.*parts breakdown.*current.*price list.*motor.*tank.*regulator.*ring.*gasket.*pressure switch.*alternate.*stock.*not verified/i);
  assert.match(fields.repair_manual.display_value, /owner.*oil.*filter.*tank.*check[- ]valve.*not.*complete internal repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*oil.*filter.*tank.*check[- ]valve.*electrical.*authorized service.*tank.*replace/i);
  assert.match(fields.warranty.display_value, /one-year.*general-product.*original purchase.*current.*terms/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /exact.*manual.*parts breakdown.*price list.*no qualifying.*owner.*duration.*expected service life.*recommendation remain unverified/i);

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
    warranty_exclusions: "Repairs made or attempted by others, normal wear and tear, abuse, misuse, improper maintenance or operation, and alterations are excluded; current Makita terms apply.",
    source_url: warrantyUrl,
    verified_date: "2026-10-05",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0001Q2VPU?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-05",
  }]);
});
