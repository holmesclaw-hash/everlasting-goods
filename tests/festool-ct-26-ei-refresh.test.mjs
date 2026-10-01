import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "festool-ct-26-ei-hepa";
const productUrl = "https://www.festoolusa.com/products/dust-extractors/workshop-dust-extractors/577871---ct-26-ei-hepa-us";
const manualUrl = "https://media.cdn.festool.io/productmedia/Images/attachment/9f0a0bce-9848-11f0-8a66-005056b3ad01.pdf";
const partsUrl = "https://www.festoolusa.com/service/repair-service/spare-parts";
const warrantyUrl = "https://www.festoolusa.com/service/warranty-all-inclusive/service-terms-and-conditions";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Festool CT 26 EI HEPA record uses current exact documentation and conservative service-life limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-10-01");
  assert.match(product.variant_notes, /577871.*United States.*CT 26 EI HEPA.*not.*CT 26 E/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    warrantyUrl,
    "https://www.festoolusa.com/-/media/tts/fcp/festool-usa/downloads/press-releases/festool_2025_springlaunch_press-release.pdf",
    "https://festoolownersgroup.com/threads/help-me-decide-new-ct-26-ei-or-new-ct-midi-i.77345/",
    "https://www.amazon.com/dp/B0DYK9VDC1",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);
  assert.equal(sourceUrls.has("https://www.festoolusa.com/service/downloads"), false);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /577871.*CT 26 EI HEPA.*Bluetooth/i);
  assert.match(fields.parts_availability.display_value, /partial.*10 years.*discontinuation.*exact.*orderability.*not verified/i);
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /filter bag.*main filter.*fill-level sensors.*internal repairs.*qualified/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.match(fields.warranty.display_value, /3-year.*authorized[- ]dealer.*30 days/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-10-01");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.match(product.recommendation_reasoning, /spring 2025.*short-term.*multi-year.*expected service life.*unverified/i);

  assert.deepEqual(product.warranty, {
    warranty_length: "3-year Warranty all-inclusive coverage after timely registration.",
    warranty_coverage: "Eligible new tools bought from an authorized dealer receive Festool's published three-year coverage and service benefits, subject to current terms.",
    warranty_exclusions: "Registration within 30 days and proof of purchase are required; consumables, misuse, improper use, unauthorized modifications, and published exclusions are not covered.",
    source_url: warrantyUrl,
    verified_date: "2026-10-01",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0DYK9VDC1?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-01",
  }]);
});
