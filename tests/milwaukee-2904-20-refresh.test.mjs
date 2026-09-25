import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "milwaukee-2904-20";
const manualUrl = "https://documents.milwaukeetool.com/58-14-9998d1.pdf";
const partsUrl = "https://documents.milwaukeetool.com/54-24-2990R.pdf";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Milwaukee 2904-20 record separates documented maintenance, service parts, and warranty limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-09-25");
  assert.match(product.variant_notes, /2904-20.*cordless power[- ]tool.*side handle.*belt clip.*battery.*charger/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.milwaukeetool.com/products/details/m18-fuel-1-2-hammer-drill-driver-cordless-power-tool/2904-20",
    manualUrl,
    partsUrl,
    "https://www.milwaukeetool.com/support/registration-and-warranty",
    "https://www.reddit.com/r/MilwaukeeTool/comments/1sa31uk/warranty_disappointment_saga/",
    "https://www.reddit.com/r/MilwaukeeTool/comments/1su3pj4/milwaukee_5_year_warranty_is_not_a_joke/",
    "https://www.reddit.com/r/MilwaukeeTool/comments/16g1f1f/",
    "https://www.amazon.com/dp/B0BB854SJ8",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /2904-20.*M18 FUEL.*1\/2-inch hammer drill\/driver/i);
  assert.match(fields.parts_availability.display_value, /partial.*May 2025.*chuck.*gearbox.*rotor.*electronic.*orderability.*not verified/i);
  assert.match(fields.repair_manual.display_value, /operator manual.*not.*owner-repair manual.*service-parts list/i);
  assert.match(fields.serviceability.display_value, /cleaning.*inspection.*battery contacts.*internal repairs.*service facility/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-09-25");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.match(product.recommendation_reasoning, /2\.5 years.*warranty replacement.*wobble.*multiple service attempts.*replacement chuck.*resolved binding.*anecdotal.*expected service life.*unverified/i);

  assert.deepEqual(product.warranty, {
    warranty_length: "5-year limited power-tool warranty.",
    warranty_coverage: "For the original purchaser, Milwaukee may repair or replace parts it determines defective in material or workmanship, subject to current terms and exceptions.",
    warranty_exclusions: "Unauthorized repair attempts, misuse, alterations, abuse, normal wear, lack of maintenance, and accidents are excluded; the policy specifically lists chucks among normal-wear parts.",
    source_url: "https://www.milwaukeetool.com/support/registration-and-warranty",
    verified_date: "2026-09-25",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0BB854SJ8?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-25",
  }]);
});
