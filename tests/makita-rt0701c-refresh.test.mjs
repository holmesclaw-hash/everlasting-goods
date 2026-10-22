import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-rt0701c";
const productUrl = "https://www.makitatools.com/products/details/RT0701C";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf";
const breakdownUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf";
const partsPriceUrl = "https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx";
const serviceUrl = "https://www.makitatools.com/service/service-centers";
const warrantyUrl = "https://www.makitatools.com/service/warranty";
const ownerVideoUrl = "https://www.youtube.com/watch?v=29PIqz--MAM";
const recallUrl = "https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=RT0701C";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Makita RT0701C record documents maintainable components without promoting anecdote to lifespan evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "RT0701C");
  assert.equal(product.sku, "RT0701C");
  assert.equal(product.category, "routers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-22");
  assert.match(product.variant_notes, /RT0701C.*fixed-base.*trimmer base.*1\/4.*collet.*straight guide.*two.*wrenches.*not.*multi-base kit/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [productUrl, manualUrl, breakdownUrl, partsPriceUrl, serviceUrl, warrantyUrl, ownerVideoUrl, recallUrl]) {
    assert.ok(sourceUrls.has(url), `missing source ${url}`);
  }

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /RT0701C.*corded.*fixed-base.*6\.5A.*10,000.*30,000 RPM.*1\/4-inch/is);
  assert.match(fields.parts_availability.display_value, /Partial.*October 2026.*armature.*controller.*field.*switch.*cord.*carbon[- ]brush.*collet nut.*stock.*not guaranteed/is);
  assert.match(fields.repair_manual.display_value, /instruction manual.*carbon-brush replacement.*not.*component-level repair manual/is);
  assert.match(fields.serviceability.display_value, /owner.*carbon[- ]brush.*internal repair.*authorized or factory service/is);
  assert.match(fields.warranty.display_value, /(?:1|one)-year.*workmanship.*materials.*normal wear.*unauthorized repair.*abuse/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");

  assert.match(product.recommendation_reasoning, /exact-ASIN.*5-9 hour.*CNC.*six years.*1,500.*RT0700C.*sibling.*representative.*expected service life.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsPriceUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-22");

  assert.equal(product.warranty.warranty_length, "1-year general product limited warranty; 30-day return/replacement guarantee.");
  assert.equal(product.warranty.source_url, warrantyUrl);
  assert.equal(product.warranty.verified_date, "2026-10-22");

  assert.equal(product.expected_service_life_years, null);
  assert.equal(product.street_price_cents, null);
  assert.equal(product.annual_maintenance_cost_cents, null);
  assert.equal(product.image_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00E7D3V4S?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-22",
  }]);
});
