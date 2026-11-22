import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dwp611";
const productUrl = "https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router";
const manualUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf";
const partsUrl = "https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611";
const warrantyUrl = "https://www.dewalt.com/en-us/support/warranty";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the DEWALT DWP611 record preserves fixed-base, parts-snapshot, maintenance, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "DEWALT");
  assert.equal(product.model, "DWP611");
  assert.equal(product.sku, "DWP611");
  assert.equal(product.category, "routers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-11-22");
  assert.match(product.variant_notes, /DWP611.*fixed-base.*Type 1.*motor.*standard.*base.*wrench.*manual.*DWP611PK.*plunge base/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    warrantyUrl,
    "https://www.reddit.com/r/XCarve/comments/1gfuiml/best_spindlerouter_for_original_xcarve",
    "https://www.reddit.com/r/Tools/comments/4clk9r/dewalt_dwp611_router_problems",
    "https://www.reddit.com/r/CNC/comments/1ket792/dewalt_dwp611_help",
    "https://www.amazon.com/dp/B0048EFUV8",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /DWP611.*corded.*fixed-base.*1\.25 HP.*7-amp.*16,000.*27,000 RPM.*1\/4-inch collet/i);
  assert.match(fields.parts_availability.display_value, /Partial.*Type 1.*58.*57.*purchasable.*armature.*field.*brush.*switch.*collet.*two.*zero.*internally inconsistent/i);
  assert.equal(fields.parts_availability.verified_date, "2026-11-22");
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not.*owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*100 hours.*brush.*qualified.*service/i);
  assert.match(fields.warranty.display_value, /3-year.*1-year free service.*90-day.*original end-user.*authorized.?seller/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-11-22");
  assert.match(product.recommendation_reasoning, /58.*57.*purchasable.*two.*zero.*five years.*brush replacement.*four.*routers.*eight years.*hard oak.*variable-speed.*sparking.*eighteen months.*anecdotes.*service life.*failure rate.*repair economics.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-11-22");
  assert.equal(product.image_url, null);

  assert.deepEqual(product.warranty, {
    warranty_length: "3-year limited warranty; 1-year free service; 90-day money-back guarantee.",
    warranty_coverage: "For products stating this package, DEWALT covers defects due to faulty materials or workmanship for the original end-user purchaser and provides first-year maintenance plus replacement of worn parts caused by normal use.",
    warranty_exclusions: "Current terms exclude normal-wear failures from the three-year defect warranty, tool abuse, accessories, unauthorized repair damage, and in many cases products from unauthorized sellers; proof requirements and applicable law control.",
    source_url: warrantyUrl,
    verified_date: "2026-11-22",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0048EFUV8?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-11-22",
  }]);
});
