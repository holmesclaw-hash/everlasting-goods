import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dcd800b";
const productUrl = "https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-12-brushless-cordless-drilldriver-tool-only";
const manualUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf";
const partsUrl = "https://www.toolservicenet.com/en/p/DCD800B";
const diagramUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the DEWALT DCD800B record preserves the tool-only, service, parts, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "DEWALT");
  assert.equal(product.model, "DCD800");
  assert.equal(product.sku, "DCD800B");
  assert.equal(product.category, "drill-drivers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-11-20");
  assert.match(product.variant_notes, /DCD800B.*tool-only.*DCD800.*belt hook.*battery.*charger.*sold separately.*DCD805.*hammer/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    diagramUrl,
    "https://www.reddit.com/r/Dewalt/comments/1gtj46k/ntd_i_finally_got_a_dcd800",
    "https://www.reddit.com/r/Dewalt/comments/1kp2tha/my_brand_new_drill_and_driver",
    "https://www.reddit.com/r/Dewalt/comments/1cfmgcn/dcd800",
    "https://www.reddit.com/r/Dewalt/comments/1i0ti8r/will_the_dcd800_drill_be_upgraded_like_the_1007",
    "https://www.amazon.com/dp/B09ZQ4VTXK",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /DCD800B.*tool-only.*brushless.*1\/2-inch.*0-650.*0-2,000 RPM.*6\.37-inch/i);
  assert.match(fields.parts_availability.display_value, /partial.*Type 1.*26.*25.*purchasable.*motor.*switch.*transmission.*chuck.*stock metadata.*internally inconsistent/i);
  assert.equal(fields.parts_availability.verified_date, "2026-11-20");
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not.*owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /user maintenance.*air-vent cleaning.*repairs.*factory or authorized service/i);
  assert.match(fields.warranty.display_value, /3-year.*1-year free service.*90-day.*current.*terms/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-11-20");
  assert.match(product.recommendation_reasoning, /Type 1.*26.*25.*purchasable.*internally inconsistent.*couple of years.*daily.*cabinet.*millwork.*intermittent.*just over two years.*anecdotes.*expected service life.*failure rate.*repair economics.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);

  assert.deepEqual(product.warranty, {
    warranty_length: "3-year limited warranty; 1-year free service; 90-day money-back guarantee.",
    warranty_coverage: "The exact DCD800B product page publishes DEWALT's 3-year limited warranty, 1-year free service, and 90-day money-back guarantee program.",
    warranty_exclusions: "Eligibility, exclusions, proof requirements, and current claim terms must be confirmed with DEWALT for the purchaser and use case.",
    source_url: productUrl,
    verified_date: "2026-11-20",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B09ZQ4VTXK?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-11-20",
  }]);
});
