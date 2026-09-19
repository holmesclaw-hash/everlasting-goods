import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "bosch-4100xc-10";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Bosch 4100XC-10 record distinguishes owner maintenance from repair documentation", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-09-19");
  assert.match(product.variant_notes, /3601L13015.*GTA47W/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.boschtools.com/us/en/products/4100xc-10-0601B13016",
    "https://www.boschtools.com/ca/en/products/4100xc-10-0601B13016",
    "https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf",
    "https://www.boschtools.com/us/en/service/product-warranty/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.parts_availability.display_value, /3601L13015.*official spare-parts catalog.*individual availability/i);
  assert.match(fields.repair_manual.display_value, /operating.*maintenance manual.*not an owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /blade replacement.*alignment.*dust removal.*lubrication/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.match(product.recommendation_reasoning, /2 to 3 years.*still runs and cuts.*stand collapsed.*tubing.*representative.*remain unverified/i);

  assert.deepEqual(product.warranty, {
    warranty_length: "1-year limited warranty.",
    warranty_coverage: "Defects in material or workmanship for the original purchaser of Bosch corded portable and benchtop power tools.",
    warranty_exclusions: "Misuse, careless handling, unauthorized misrepair, and accessory items are excluded; current Bosch terms and claim requirements apply.",
    source_url: "https://www.boschtools.com/us/en/service/product-warranty/",
    verified_date: "2026-09-19",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0851KL858?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-19",
  }]);
});
