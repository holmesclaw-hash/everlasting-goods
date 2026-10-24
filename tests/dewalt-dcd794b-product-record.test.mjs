import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dcd794b";
const productUrl = "https://www.dewalt.com/en-us/product/dcd794b/atomic-20v-max-brushless-cordless-12-drilldriver-tool-only";
const manualUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Instruction_Manual/EN/NA597019_DCD794_DCD799_NA_NBC.pdf";
const serviceNetUrl = "https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-COMPACT-DRILL-DRIVER-BARE/p/DCD794B_1";
const diagramUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Exploded_Diagram/EN/DCD794_B_C1_D1_T1.svg";
const sparePartsPolicyUrl = "https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool";
const repairUrl = "https://support.dewalt.com/hc/en-us/articles/360056765252-Where-can-my-product-be-repaired-under-warranty";
const manualsPolicyUrl = "https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams";
const warrantyUrl = "https://www.dewalt.com/en-us/support/warranty";
const ownerUrl = "https://www.reddit.com/r/Dewalt/comments/1uzcdvm/in_love_with_the_dcd794_3_month_review/";
const recallsUrl = "https://www.dewalt.com/en-us/support/safety-notices-and-recalls";
const recallApiUrl = "https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD794";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the DEWALT DCD794B record preserves exact package and Type 1 evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "DEWALT");
  assert.equal(product.model, "DCD794");
  assert.equal(product.sku, "DCD794B");
  assert.equal(product.category, "drill-drivers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-24");
  assert.match(product.variant_notes, /DCD794B.*20V MAX.*brushless.*1\/2-inch.*tool-only/is);
  assert.match(product.variant_notes, /belt hook.*battery.*charger.*sold separately/is);
  assert.match(product.variant_notes, /Type 1/is);
  assert.match(product.variant_notes, /DCD794D1|DCD794D2/is);
  assert.match(product.variant_notes, /DCD799.*hammer/is);
  assert.match(product.variant_notes, /DCD800.*DCD805/is);
  assert.match(product.variant_notes, /regional.*combo kit/is);

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
    ownerUrl,
    recallsUrl,
    recallApiUrl,
  ]) assert.ok(sourceUrls.has(url), `missing source ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /DCD794B.*ATOMIC.*20V MAX.*brushless.*1\/2-inch.*compact.*tool-only/is);
  assert.match(fields.parts_availability.display_value, /Partial.*Type 1.*chuck.*clamshell.*transmission.*motor.*selector/is);
  assert.match(fields.parts_availability.display_value, /snapshot.*not.*future stock/is);
  assert.match(fields.repair_manual.display_value, /no comprehensive internal repair manual/is);
  assert.match(fields.repair_manual.display_value, /owner manual.*operation.*maintenance.*troubleshooting/is);
  assert.match(fields.serviceability.display_value, /service network.*clean.*compressed air.*mild soap/is);
  assert.match(fields.warranty.display_value, /three-year.*limited.*one-year.*free service.*90-day/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /July 17, 2026.*two to three months.*continuous.*use/is);
  assert.match(product.recommendation_reasoning, /about one year.*home maintenance/is);
  assert.match(product.recommendation_reasoning, /anecdotal.*representative.*service life.*failure rate/is);
  assert.match(product.recommendation_reasoning, /recall.*empty.*(?:not|neither).*safety clearance/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, serviceNetUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-24");

  assert.equal(product.warranty.warranty_length, "3-year limited warranty; 1-year free service; 90-day money-back guarantee");
  assert.equal(product.warranty.verified_date, "2026-10-24");

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
    url: "https://www.amazon.com/dp/B0BY1QMH24?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-24",
  }]);
});
