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
  assert.equal(product.last_reviewed_date, "2026-09-16");

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://californiaairtools.com/product/california-air-tools-8010-ultra-quiet-1-0-hp-oil-free-lightweight-8-gallon-air-compressor",
    "https://californiaairtools.com/wp-content/uploads/2025/09/8010-Owners-Manual-EN-FR-2025-09-29.pdf",
    "https://californiaairtools.com/maintenance-troubleshooting-guide",
    "https://www.reddit.com/r/Tools/comments/iyaif5/california_air_compressors_any_good",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.parts_availability.display_value, /air filter.*90227.*service.*parts/i);
  assert.equal(fields.parts_availability.evidence_tier, "T2");
  assert.match(fields.serviceability.display_value, /user-serviceable.*routine maintenance.*troubleshooting.*authorized service/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.repairability.parts_url, "https://californiaairtools.com/maintenance-troubleshooting-guide");
  assert.match(product.recommendation_reasoning, /owner discussion is mixed.*service life remains unverified/i);
});
