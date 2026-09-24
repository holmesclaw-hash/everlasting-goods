import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "bosch-pr20evs";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Bosch PR20EVS record preserves exact support and mixed owner evidence without claiming lifespan", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Bosch");
  assert.equal(product.model, "PR20EVS");
  assert.equal(product.sku, "060160A71A");
  assert.equal(product.category, "routers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-09-24");
  assert.match(product.variant_notes, /standalone fixed-base.*PR20EVSPK.*PR20EVSNK/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.boschtools.com/us/en/products/pr20evs-060160A71A",
    "https://ocsmedia.boschtools.com/binary/manualsmedia/o18973v2_2610021461_0612_PR1020E.pdf",
    "https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/pr20evs-3601F0A710",
    "https://www.boschtools.com/us/en/service/replacement-parts",
    "https://www.boschtools.com/us/en/service/product-warranty",
    "https://www.aconcordcarpenter.com/bosch-colt-router.html",
    "https://www.lumberjocks.com/threads/bosch-colt-pr20evs-vs-gkf125cek.315259/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /corded.*fixed-base.*1\.0 HP.*16,000.*35,000 RPM/i);
  assert.match(fields.parts_availability.display_value, /partial.*exact.*3601F0A710.*temporarily unavailable/i);
  assert.match(fields.repair_manual.display_value, /operating.*maintenance manual.*not.*owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*brush inspection.*authorized service/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /five years.*hundreds of cuts.*several years.*depth.*anecdotal.*recommendation/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B01M0J08MF?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-24",
  }]);
});
