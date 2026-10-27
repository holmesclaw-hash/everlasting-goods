import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-xfd15zb";
const productUrl = "https://www.makitatools.com/products/details/XFD15ZB";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/XFD/cac6dead-d147-406d-ba4b-19ef50ba65e4_XFD15_IM_885850-949.pdf";
const breakdownUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/XFD/2ff76fd6-57f3-49ab-b2a7-56d05d27421e_XFD15_PB_Breakdown_XFD15RB,ZB_06-21.pdf";
const partsListUrl = "https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx";
const serviceUrl = "https://www.makitatools.com/service/service-centers";
const warrantyUrl = "https://www.makitatools.com/service/warranty";
const ownerUrl = "https://www.reddit.com/r/Makita/comments/1h4ud5v/advice_on_drill/";
const recallUrl = "https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=XFD15ZB";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Makita XFD15ZB record preserves tool-only, parts-list, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "XFD15");
  assert.equal(product.sku, "XFD15ZB");
  assert.equal(product.category, "drill-drivers");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-27");

  assert.match(product.variant_notes, /XFD15ZB.*18V LXT.*Sub-Compact.*brushless.*1\/2-inch.*tool-only/is);
  assert.match(product.variant_notes, /battery.*charger.*not included/is);
  assert.match(product.variant_notes, /XFD15SY1B.*kit/is);
  assert.match(product.variant_notes, /XFD15RB.*kit/is);
  assert.match(product.variant_notes, /XPH15ZB.*hammer/is);
  assert.match(product.variant_notes, /XFD16/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    breakdownUrl,
    partsListUrl,
    serviceUrl,
    warrantyUrl,
    ownerUrl,
    recallUrl,
    "https://www.amazon.com/dp/B09BXZTGR1",
  ]) assert.ok(sourceUrls.has(url), `missing source ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /XFD15ZB.*18V LXT.*Sub-Compact.*brushless.*1\/2-inch.*tool[- ]only/is);
  assert.match(fields.identity.display_value, /5-7\/8.*350 in\.lbs.*0-500.*0-1,700.*dual L\.E\.D/is);
  assert.match(fields.parts_availability.display_value, /Partial.*October 2026.*11.*XFD15/is);
  assert.match(fields.parts_availability.display_value, /gear.*housing.*rotor.*controller.*stator.*terminal/is);
  assert.match(fields.parts_availability.display_value, /does not.*on-hand stock.*future supply/is);
  assert.match(fields.repair_manual.display_value, /no comprehensive internal repair manual/is);
  assert.match(fields.repair_manual.display_value, /operation.*inspection.*maintenance/is);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*authorized.*factory/is);
  assert.match(fields.serviceability.display_value, /dry cloth.*light lens/is);
  assert.match(fields.warranty.display_value, /three-year.*limited.*lithium-ion tool/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");

  assert.match(product.recommendation_reasoning, /paired.*1\.5Ah.*highly recommend/is);
  assert.match(product.recommendation_reasoning, /does not identify.*XFD15ZB.*package.*or a kit/is);
  assert.match(product.recommendation_reasoning, /no purchase date.*ownership duration.*repair history/is);
  assert.match(product.recommendation_reasoning, /recall.*empty.*not.*safety clearance/is);
  assert.match(product.recommendation_reasoning, /service life.*failure rate.*repair economics.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsListUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-27");

  assert.equal(product.warranty.warranty_length, "3-year limited warranty for Makita lithium-ion tools");
  assert.equal(product.warranty.verified_date, "2026-10-27");

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
    url: "https://www.amazon.com/dp/B09BXZTGR1?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-27",
  }]);
});
