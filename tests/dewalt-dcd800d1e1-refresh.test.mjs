import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dcd800d1e1";
const productUrl = "https://www.dewalt.com/en-us/product/dcd800d1e1/20v-max-xr-brushless-cordless-12-drilldriver-kit";
const manualUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf";
const diagramUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the DEWALT DCD800D1E1 record separates the exact kit from a misleading retailer title", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-09-22");
  assert.match(product.variant_notes, /DCD800.*DCBP034.*DCB203.*DCB112.*bag.*belt hook/i);
  assert.match(product.variant_notes, /does not include an impact driver/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    "https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only",
    manualUrl,
    diagramUrl,
    "https://www.dewalt.com/en-us/support",
    "https://www.dewalt.com/en-us/support/warranty",
    "https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams?sort_by=votes",
    "https://www.reddit.com/r/Dewalt/comments/1cfmgcn/dcd800",
    "https://www.reddit.com/r/Dewalt/comments/1i0ti8r/will_the_dcd800_drill_be_upgraded_like_the_1007",
    "https://www.amazon.com/dp/B00EOOZT5E",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /DCD800D1E1.*drill\/driver kit.*two batteries.*charger/i);
  assert.match(fields.parts_availability.display_value, /partial.*Type 1.*exploded diagram.*orderability.*not verified/i);
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /air-vent cleaning.*repairs.*factory or authorized service/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, diagramUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.match(product.recommendation_reasoning, /months.*general carpentry.*chuck.*representative multi-year.*unverified/i);

  assert.deepEqual(product.warranty, {
    warranty_length: "3-year limited warranty; 1-year free service; 90-day money-back guarantee.",
    warranty_coverage: "Faulty materials or workmanship for the original end-user purchaser; first-year free service includes maintenance and replacement of worn parts caused by normal use.",
    warranty_exclusions: "Normal wear, tool abuse, accessories, unauthorized repair damage, and unauthorized-seller limitations apply; proof of purchase may be required.",
    source_url: "https://www.dewalt.com/en-us/support/warranty",
    verified_date: "2026-09-22",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00EOOZT5E?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-22",
  }]);
});
