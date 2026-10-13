import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "moccamaster-kbgv-select-53948";
const productUrl = "https://us.moccamaster.com/products/kbgv";
const manualUrl = "https://support.moccamaster.com/hc/en-us/article_attachments/1500014339002";
const partsUrl = "https://us.moccamaster.com/collections/kbgv-select-coffee-brewer-parts";
const repairUrl = "https://support.moccamaster.com/hc/en-us/articles/1500009429481-Can-I-get-my-Moccamaster-repaired";
const warrantyUrl = "https://support.moccamaster.com/hc/en-us/articles/1500012391061-What-is-the-warranty-on-my-Moccamaster-brewer";
const historicalOwnerUrl = "https://commons.wikimedia.org/wiki/File:Technivorm_Moccamaster_K741.64B.jpg";
const fiveYearOwnerUrl = "https://www.reddit.com/r/BuyItForLife/comments/1356i6h/five_years_with_a_moccamaster/";
const commercialCorroborationUrl = "https://device.report/technivorm-moccamaster/53948";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Moccamaster KBGV Select 53948 record preserves current-model, repair, and lifespan boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Moccamaster");
  assert.equal(product.model, "KBGV Select");
  assert.equal(product.sku, "53948");
  assert.equal(product.category, "drip-coffee-makers");
  assert.equal(product.category_group, "kitchen");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-13");
  assert.match(product.variant_notes, /KBGV Select.*Matte Black.*53948.*40-ounce.*glass carafe/is);
  assert.match(product.variant_notes, /K741\.64B.*historical.*not.*same model/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    repairUrl,
    warrantyUrl,
    historicalOwnerUrl,
    fiveYearOwnerUrl,
    commercialCorroborationUrl,
  ]) assert.ok(sourceUrls.has(url), `missing source ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /53948.*KBGV Select.*matte black.*40-ounce.*glass[- ]carafe.*half.*full/is);
  assert.match(fields.parts_availability.display_value, /Partial.*carafe.*brew basket.*lids.*outlet arm.*switch.*older brewers.*not.*every internal component/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*cleaning.*descaling.*troubleshooting.*no user-serviceable parts.*not.*internal repair manual/is);
  assert.match(fields.serviceability.display_value, /replace.*external.*internal.*factory repair.*no user-serviceable/is);
  assert.match(fields.warranty.display_value, /five-year.*original purchaser.*carafe.*parts.*excluded/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /external parts.*factory repair.*five-year.*warranty.*historical models.*expected service life.*repair economics.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-13");

  assert.equal(product.warranty.warranty_length, "5 years limited warranty");
  assert.equal(product.warranty.verified_date, "2026-10-13");

  assert.equal(product.expected_service_life_years, null);
  assert.equal(product.street_price_cents, null);
  assert.equal(product.annual_maintenance_cost_cents, null);
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);
  assert.equal(product.image_license_basis, null);
  assert.equal(product.image_license_url, null);
  assert.equal(product.image_attribution, null);
  assert.equal(product.image_alt, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B093DXS54M?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-13",
  }]);
});

test("the restored Moccamaster guide links to the structured repairability record", async () => {
  const page = await readFile(new URL("../src/app/articles/[slug]/page.tsx", import.meta.url), "utf8");
  assert.match(page, /\[MOCCAMASTER_GUIDE_SLUG\]:\s*\{[\s\S]*?databaseSlug:\s*"moccamaster-kbgv-select-53948"/);
});
