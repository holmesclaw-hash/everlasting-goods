import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dcd793b";
const productUrl = "https://www.dewalt.com/en-us/product/dcd793b/20v-max-brushless-cordless-12-drilldriver-tool-only";
const manualUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCD793B/1/Instruction_Manual/EN/DCD793-DCD798_NA.pdf";
const serviceNetUrl = "https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V//p/DCD793B_1";
const diagramUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCD793B/1/Exploded_Diagram/EN/E21151.svg";
const sparePartsPolicyUrl = "https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool";
const repairUrl = "https://support.dewalt.com/hc/en-us/articles/360056765252-Where-can-my-product-be-repaired-under-warranty";
const manualsPolicyUrl = "https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams";
const warrantyUrl = "https://www.dewalt.com/en-us/support/warranty";
const handsOnUrl = "https://www.techgearlab.com/reviews/tools/drill/dewalt-20v-max-brushless-1-2-in-cordless-compact-drill-driver-dcd793b";
const recallsUrl = "https://www.dewalt.com/en-us/support/safety-notices-and-recalls";
const recallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD793";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the DEWALT DCD793B record preserves exact package, Type 1 parts, and evidence-duration boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "DEWALT");
  assert.equal(product.model, "DCD793");
  assert.equal(product.sku, "DCD793B");
  assert.equal(product.category, "drill-drivers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-26");
  assert.match(product.variant_notes, /DCD793B.*20V MAX.*brushless.*1\/2-inch.*tool-only/is);
  assert.match(product.variant_notes, /drill\/driver.*belt hook.*battery.*charger.*sold separately/is);
  assert.match(product.variant_notes, /Type 1/is);
  assert.match(product.variant_notes, /DCD793D1.*kit/is);
  assert.match(product.variant_notes, /DCD798.*hammer drill/is);
  assert.match(product.variant_notes, /DCD794.*ATOMIC/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    serviceNetUrl,
    diagramUrl,
    sparePartsPolicyUrl,
    repairUrl,
    manualsPolicyUrl,
    warrantyUrl,
    handsOnUrl,
    recallsUrl,
    recallApiUrl,
  ]) assert.ok(sourceUrls.has(url), `missing source ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /DCD793B.*20V MAX.*brushless.*1\/2-inch.*tool-only/is);
  assert.match(fields.identity.display_value, /6\.38.*404 UWO.*1,650 RPM.*ratcheting chuck.*LED/is);
  assert.match(fields.parts_availability.display_value, /Partial.*October 26, 2026.*Type 1.*13.*purchasable/is);
  assert.match(fields.parts_availability.display_value, /clamshell.*motor.*switch.*selector.*transmission/is);
  assert.match(fields.parts_availability.display_value, /dated snapshot.*future stock/is);
  assert.match(fields.repair_manual.display_value, /no comprehensive internal repair manual/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*operation.*maintenance.*cleaning/is);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*service center/is);
  assert.match(fields.serviceability.display_value, /dry air.*once a week.*water and mild soap/is);
  assert.match(fields.warranty.display_value, /three-year.*limited.*one-year.*free service.*90-day/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");

  assert.match(product.recommendation_reasoning, /August 4, 2025.*hands-on.*tests/is);
  assert.match(product.recommendation_reasoning, /not.*ownership-duration.*repair-history.*evidence/is);
  assert.match(product.recommendation_reasoning, /no credible long-duration exact-model owner report.*accepted/is);
  assert.match(product.recommendation_reasoning, /recall.*empty.*(?:not|neither).*safety clearance/is);
  assert.match(product.recommendation_reasoning, /service life.*failure rate.*repair economics.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, serviceNetUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-26");

  assert.equal(product.warranty.warranty_length, "3-year limited warranty; 1-year free service; 90-day money-back guarantee");
  assert.equal(product.warranty.verified_date, "2026-10-26");

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
    url: "https://www.amazon.com/dp/B0BY13XZXT?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-26",
  }]);
});
