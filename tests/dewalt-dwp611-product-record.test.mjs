import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dwp611";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the DEWALT DWP611 record separates exact-model support and owner evidence from unverified lifespan", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "DEWALT");
  assert.equal(product.model, "DWP611");
  assert.equal(product.sku, "DWP611");
  assert.equal(product.category, "routers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-09-16");
  assert.match(product.variant_notes, /fixed-base.*Type 1.*DWP611PK.*plunge base/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router",
    "https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf",
    "https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611",
    "https://www.dewalt.com/en-us/support/warranty",
    "https://www.reddit.com/r/XCarve/comments/1gfuiml/best_spindlerouter_for_original_xcarve/",
    "https://www.reddit.com/r/Tools/comments/4clk9r/dewalt_dwp611_router_problems/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /corded.*fixed-base.*router.*1\/4/i);
  assert.match(fields.parts_availability.display_value, /partial.*type 1.*parts catalog/i);
  assert.match(fields.repair_manual.display_value, /operating.*safety.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*qualified repair/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /five years.*eighteen months.*anecdotes.*recommendation/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0048EFUV8?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-16",
  }]);
});
