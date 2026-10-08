import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "california-air-tools-8010";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the California Air Tools 8010 record publishes sourced maintenance and serviceability limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-10-08");

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://californiaairtools.com/product/california-air-tools-8010-ultra-quiet-1-0-hp-oil-free-lightweight-8-gallon-air-compressor",
    "https://californiaairtools.com/wp-content/uploads/2025/09/8010-Owners-Manual-EN-FR-2025-09-29.pdf",
    "https://californiaairtools.com/maintenance-troubleshooting-guide",
    "https://www.reddit.com/r/airbrush/comments/1hbgdpo/compressor_choice/",
    "https://www.reddit.com/r/airbrush/comments/1obm6k7/best_air_compressor_under_500/",
    "https://airpsi.com/low-noise/california-air-tools-8010-review/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);
  assert.equal(
    sourceUrls.has("https://www.reddit.com/r/Tools/comments/iyaif5/california_air_compressors_any_good"),
    false,
    "family-level and sibling-model reports must not be attached to the exact 8010 record",
  );

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.parts_availability.display_value, /air filter.*90227.*authorized.*parts providers.*stock.*not verified/i);
  assert.equal(fields.parts_availability.evidence_tier, "T2");
  assert.match(fields.serviceability.display_value, /user-serviceable.*routine maintenance.*troubleshooting.*authorized service/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-10-08");
  assert.match(fields.warranty.display_value, /12-month.*parts and labor.*original retail purchaser/i);
  assert.equal(fields.warranty.verified_date, "2026-10-08");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.parts_url, "https://californiaairtools.com/maintenance-troubleshooting-guide");
  assert.match(product.recommendation_reasoning, /two exact-model owners.*few years.*years.*anecdotal.*service life remains unverified/i);
  assert.equal(product.warranty.warranty_length, "12 months parts and labor.");
  assert.match(product.warranty.warranty_coverage, /original retail purchaser.*authorized dealer/i);
  assert.match(product.warranty.warranty_exclusions, /normal wear.*unauthorized repair/i);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00WM1VPKE?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-08",
  }]);
});
