import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dcd800b";
const productUrl = "https://www.dewalt.com/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only";
const manualUrl = "https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QUCA/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf";
const partsUrl = "https://www.toolservicenet.com/en/p/DCD800B";
const warrantyUrl = "https://support.dewalt.com/hc/en-us/articles/8159827713293-USA-CAN-DeWalt-Warranty";

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
  assert.equal(product.last_reviewed_date, "2026-10-09");
  assert.match(product.variant_notes, /DCD800B.*tool-only.*DCD800.*belt hook.*battery.*charger.*sold separately.*DCD805.*hammer/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    "https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams",
    "https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool",
    warrantyUrl,
    "https://support.dewalt.com/hc/en-us/articles/360056765252-Where-can-my-product-be-repaired-under-warranty",
    "https://www.reddit.com/r/Dewalt/comments/1gtj46k/ntd_i_finally_got_a_dcd800",
    "https://www.reddit.com/r/Dewalt/comments/1kp2tha/my_brand_new_drill_and_driver",
    "https://www.reddit.com/r/Dewalt/comments/1cfmgcn/dcd800",
    "https://www.reddit.com/r/Dewalt/comments/1i0ti8r/will_the_dcd800_drill_be_upgraded_like_the_1007",
    "https://www.amazon.com/dp/B09ZQ4VTXK",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /DCD800B.*tool-only.*brushless.*1\/2-inch.*0-650.*0-2,000 RPM.*6\.37-inch/i);
  assert.match(fields.parts_availability.display_value, /partial.*Type 1.*ServiceNet.*motor.*switch.*transmission.*chuck.*orderable.*stock.*volatile/i);
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not.*owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /user maintenance.*air-vent cleaning.*repairs.*factory or authorized service/i);
  assert.match(fields.warranty.display_value, /3-year.*1-year free service.*90-day.*current.*terms/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /couple of years.*daily.*cabinet.*millwork.*intermittent.*just over two years.*chuck.*anecdotal.*expected service life.*failure rate.*repair economics.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);

  assert.deepEqual(product.warranty, {
    warranty_length: "3-year limited warranty; 1-year free service; 90-day money-back guarantee.",
    warranty_coverage: "Faulty materials or workmanship for the original end-user purchaser; first-year free service includes maintenance and replacement of worn parts caused by normal use.",
    warranty_exclusions: "Normal wear, tool abuse, accessories, unauthorized repair damage, and unauthorized-seller limitations apply; proof of purchase may be required.",
    source_url: warrantyUrl,
    verified_date: "2026-10-09",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B09ZQ4VTXK?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-09",
  }]);
});
