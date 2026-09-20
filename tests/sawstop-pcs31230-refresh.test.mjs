import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "sawstop-pcs31230-tgp236";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the SawStop PCS31230-TGP236 record documents maintainability without overstating repair support", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-09-20");
  assert.match(product.variant_notes, /PCS31230.*3 HP.*230V.*TGP236.*36-inch/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.sawstop.com/product/professional-cabinet-saw-pcs31230-tgp236",
    "https://www.sawstop.com/wp-content/uploads/2021/10/Owners-Manual_Feb-2024.pdf",
    "https://www.sawstop.com/support/warranty-information/",
    "https://www.sawstop.com/product/pcs-double-pulley-assembly",
    "https://www.sawstop.com/product/main-power-cable-pcs31230-pcs175-and-230v-cns",
    "https://lumberjocks.com/threads/my-thoughts-on-the-sawstop-professional-table-saw.323061/page-2",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.parts_availability.display_value, /partial.*exploded parts lists.*replacement components/i);
  assert.match(fields.repair_manual.display_value, /owner.*operating.*maintenance manual.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /brake cartridge.*alignment.*belt tension.*lubrication/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.match(product.recommendation_reasoning, /several years.*PCS.*anecdote.*expected service life.*recommendation.*unverified/i);

  assert.deepEqual(product.warranty, {
    warranty_length: "2 years new; 1 year refurbished.",
    warranty_coverage: "Defects in material or workmanship for the original retail purchaser of a Professional Cabinet Saw purchased from an authorized SawStop distributor.",
    warranty_exclusions: "Misuse, abuse, negligence, accidents, normal wear and tear, unauthorized repair or alteration, and lack of maintenance are excluded; current SawStop terms apply.",
    source_url: "https://www.sawstop.com/support/warranty-information/",
    verified_date: "2026-09-20",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B009C7NGTE?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-20",
  }]);
});
