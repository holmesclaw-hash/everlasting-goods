import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-xfd14z";
const productUrl = "https://makitatools.com/products/details/XFD14Z";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf";
const breakdownUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf";
const partsListUrl = "https://cdn.makitatools.com/apps/PriceManagement/upload/Nov%202026%20Parts%20Price%20List_2026_11_16_0956AM.xlsx";
const serviceUrl = "https://www.makitatools.com/service/service-centers";
const warrantyUrl = "https://www.makitatools.com/service/warranty";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita XFD14Z record preserves tool-only, parts-chain, and owner-evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "XFD14Z");
  assert.equal(product.sku, "XFD14Z");
  assert.equal(product.category, "drill-drivers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-11-21");
  assert.match(product.variant_notes, /XFD14Z.*tool-only.*battery.*charger.*not included.*XFD14T.*kit.*XPH14.*hammer/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    breakdownUrl,
    partsListUrl,
    serviceUrl,
    warrantyUrl,
    "https://www.reddit.com/r/Tools/comments/1adxfhh/makita_drills_xfd16_ddf489_vs_xfd14_ddf486_vs",
    "https://www.reddit.com/r/Makita/comments/12wids0/xgt_df001g_bit_the_dust",
    "https://www.reddit.com/r/Makita/comments/1reavmq/should_i_buy_a_used_makita_dhp486_in_2026",
    "https://www.amazon.com/dp/B093QS3VJR",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /XFD14Z.*tool-only.*brushless.*1\/2-inch.*1,250.*0-550.*0-2,100 RPM.*7-inch/i);
  assert.match(fields.parts_availability.display_value, /Partial.*November 2026.*22 of 23.*breakdown.*6.*discontinued.*4.*alternate.*2.*no alternate.*chuck.*absent/i);
  assert.equal(fields.parts_availability.verified_date, "2026-11-21");
  assert.match(fields.repair_manual.display_value, /instruction manual.*not.*internal repair manual/i);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*Authorized or Factory Service Centers.*replacement parts/i);
  assert.match(fields.warranty.display_value, /3-year.*lithium-ion tool.*terms.*exclusions/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-11-21");
  assert.match(product.recommendation_reasoning, /XFD14.*gear slipping.*about one year.*workplace.*abused.*no problem.*no duration.*DDF486.*electronics.*four years.*regional sibling.*anecdotes.*service life.*failure rate.*repair economics.*remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsListUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-11-21");
  assert.equal(product.image_url, null);

  assert.equal(product.warranty.warranty_length, "3-year limited warranty for Makita lithium-ion tools");
  assert.equal(product.warranty.source_url, warrantyUrl);
  assert.equal(product.warranty.verified_date, "2026-11-21");

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B093QS3VJR?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-11-21",
  }]);
});
