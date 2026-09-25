import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "bosch-gkf125cen";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Bosch GKF125CEN record preserves package, service, and owner-evidence limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Bosch");
  assert.equal(product.model, "GKF125CEN");
  assert.equal(product.sku, "0601628010");
  assert.equal(product.category, "routers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-09-24");
  assert.match(product.variant_notes, /standalone fixed-base.*GKF125CEK.*GKF125CEPK/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.boschtools.com/us/en/products/gkf125cen-0601628010",
    "https://ocsmedia.boschtools.com/binary/manualsmedia/o200941v2_2610052572_0918_GKF125CE.pdf",
    "https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gkf125cen-3601F28110",
    "https://www.boschtools.com/us/en/service/replacement-parts",
    "https://www.boschtools.com/us/en/service/product-warranty",
    "https://www.reddit.com/r/BeginnerWoodWorking/comments/1oucjav/router_choice/",
    "https://www.reddit.com/r/Tools/comments/gwrtmo/bosch_resale_value/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /corded.*fixed-base.*1\.25 HP.*16,000.*35,000 RPM/i);
  assert.match(fields.parts_availability.display_value, /partial.*3601F28110.*temporarily unavailable/i);
  assert.match(fields.repair_manual.display_value, /operating.*maintenance manual.*not.*owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*collet.*brush inspection.*authorized service/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /three years.*lightly used.*anecdotal.*recommendation/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B01AX4A95S?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-24",
  }]);
});
