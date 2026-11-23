import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "fein-turbo-i";
const productUrl = "https://fein.com/en_us/tools/wet-dry-dust-extraction/wet-dry-dust-extraction/turbo-i-92035236090";
const manualUrl = "https://fein.com/fileadmin/Assets/Documents/Products/Instructions/8/c/4/8c4a1f4799718a165f3443ea50b4b3f9-ZBA_34101211210_Turbo_l_ll_20221212.pdf";
const partsUrl = "https://etk.fein.de/spc/index.php?r=item%2Flist&id=9768";
const warrantyUrl = "https://fein.com/en_us/services/3-year-fein-plus-warranty";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the FEIN Turbo I record preserves exact-SKU, parts-status, maintenance, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "FEIN");
  assert.equal(product.model, "Turbo I");
  assert.equal(product.sku, "9 20 35 236 09 0");
  assert.equal(product.category, "dust-extractors");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-11-23");
  assert.match(product.variant_notes, /9 20 35 236 09 0.*92035236090.*United States.*60 Hz.*120 V.*5\.8-gallon.*Turbo I HEPA.*Turbo II/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    warrantyUrl,
    "https://sawmillcreek.org/threads/fein-turbo-i.233488/",
    "https://www.lumberjocks.com/threads/fein-turbo-1.345144/",
    "https://www.amazon.com/dp/B00K69ILFQ",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /Turbo I.*92035236090.*120 V.*5\.8-gallon.*151 cfm.*98\.4 in.*67 dB/i);
  assert.match(fields.parts_availability.display_value, /Partial.*65.*52.*available.*12.*available soon.*assembly aid.*no longer available.*motor.*electronics.*switch.*hose/i);
  assert.equal(fields.parts_availability.verified_date, "2026-11-23");
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /owner-replaceable.*filter.*hose.*tool adapter.*annual.*inspection.*qualified/i);
  assert.match(fields.warranty.display_value, /3-year.*registr.*6 weeks.*proof of purchase.*wear.*improper use/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-11-23");
  assert.match(product.recommendation_reasoning, /65.*52.*available.*12.*available soon.*one.*no longer available/i);
  assert.match(product.recommendation_reasoning, /two years.*working well.*three years/i);
  assert.match(product.recommendation_reasoning, /seven or eight years.*sanders.*Domino.*not.*exact package order number.*production revision/i);
  assert.match(product.recommendation_reasoning, /expected service life.*failure rate.*repair economics.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-11-23");
  assert.equal(product.image_url, null);

  assert.deepEqual(product.warranty, {
    warranty_length: "3-year FEIN PLUS warranty after timely registration.",
    warranty_coverage: "FEIN states that registered eligible products receive three years of coverage under the published FEIN PLUS terms, with proof of purchase required.",
    warranty_exclusions: "Registration must be completed within six weeks of purchase; current terms exclude wear parts and damage from improper use, overload, unsuitable accessories, or unauthorized opening or repair.",
    source_url: warrantyUrl,
    verified_date: "2026-11-23",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00K69ILFQ?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-11-23",
  }]);
});
