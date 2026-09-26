import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "bosch-1617evspk";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Bosch 1617EVSPK record separates owner maintenance, parts support, and conflicting owner evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-09-26");
  assert.match(product.variant_notes, /fixed.*plunge.*06016176A1.*3601F75710/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.boschtools.com/us/en/products/1617evspk-0601617577",
    "https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/1617evspk-3601F75710",
    "https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf",
    "https://www.boschtools.com/us/en/service/product-warranty/",
    "https://www.garagejournal.com/forum/threads/bosch-1617-router-users-beware.327633/",
    "https://festoolownersgroup.com/threads/bosch-1617evspk-combo-router-kit.69166/",
    "https://www.amazon.com/dp/B00005RHPD",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /2\.25 HP.*8,000.*25,000 RPM.*fixed.*plunge/i);
  assert.match(fields.parts_availability.display_value, /3601F75710.*official spare-parts catalog.*individual.*availability/i);
  assert.match(fields.repair_manual.display_value, /operating.*maintenance manual.*not an owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /cleaning.*ventilation.*bit.*collet.*authorized service/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.match(product.recommendation_reasoning, /13 years.*trouble-free.*switch.*plunge-base.*two years.*anecdotal.*remain unverified/i);

  assert.deepEqual(product.warranty, {
    warranty_length: "1-year limited warranty.",
    warranty_coverage: "Defects in material or workmanship for the original purchaser of Bosch corded portable and benchtop power tools.",
    warranty_exclusions: "Misuse, careless handling, unauthorized misrepair, and accessory items are excluded; current Bosch terms and claim requirements apply.",
    source_url: "https://www.boschtools.com/us/en/service/product-warranty/",
    verified_date: "2026-09-26",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00005RHPD?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-26",
  }]);
});
