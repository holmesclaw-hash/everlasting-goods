import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-vc4210l";
const productUrl = "https://www.makitatools.com/products/details/VC4210L";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/VC4/5fb7ef75-dbeb-446e-a746-1b5dd0569c35_VC4210L_IM.pdf";
const partsUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/VC4/1b731b99-245e-4fac-a87c-5aa08ecda139_VC4210L_US_en-US.pdf";
const partsPriceUrl = "https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx";
const warrantyUrl = "https://www.makitatools.com/service/warranty";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita VC4210L record preserves exact-model, parts, maintenance, and evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "VC4210L");
  assert.equal(product.sku, "VC4210L");
  assert.equal(product.category, "dust-extractors");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-11-24");
  assert.match(product.variant_notes, /United States.*corded.*120 V.*11-gallon.*AWS.*WUT02U.*sold separately/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    partsPriceUrl,
    warrantyUrl,
    "https://www.amazon.com/dp/B07ZMN75V2",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /VC4210L.*120 V.*11-gallon.*12 A.*148 CFM.*92 in.*60 dB.*AWS-capable/i);
  assert.match(fields.parts_availability.display_value, /Partial.*October 2026.*38.*not marked discontinued.*motor.*PCBA.*switch.*power cord.*container.*wheels/i);
  assert.match(fields.parts_availability.raw_value, /list-price file.*does not prove live stock.*checkout.*production revision.*future supply/i);
  assert.equal(fields.parts_availability.verified_date, "2026-11-24");
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not.*internal repair manual/i);
  assert.match(fields.serviceability.display_value, /filter.*bag.*cooling-air.*gasket.*floater.*annual.*qualified/i);
  assert.match(fields.warranty.display_value, /1-year.*general-product.*original purchase.*authorized service.*normal wear.*misuse.*alteration/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-11-24");
  assert.match(product.recommendation_reasoning, /38.*none is marked discontinued.*motor.*PCBA.*power cord/i);
  assert.match(product.recommendation_reasoning, /no qualifying exact-model owner report.*ownership duration.*repair history/i);
  assert.match(product.recommendation_reasoning, /expected service life.*failure rate.*maintenance cost.*repair economics.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-11-24");
  assert.equal(product.image_url, null);

  assert.deepEqual(product.warranty, {
    warranty_length: "1-year general product limited warranty.",
    warranty_coverage: "Makita states that its general products are covered against defects in workmanship and materials for one year from original purchase, with inspection and repair or replacement through a Makita Factory or Authorized Service Center.",
    warranty_exclusions: "The published limitations exclude accessories and cases involving attempted third-party repair, normal wear and tear, abuse, misuse, improper maintenance or operation, or alterations.",
    source_url: warrantyUrl,
    verified_date: "2026-11-24",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B07ZMN75V2?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-11-24",
  }]);
});
