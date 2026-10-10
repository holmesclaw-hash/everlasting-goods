import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0860";
const productUrl = "https://www.grizzly.com/products/grizzly-1-1-2-hp-portable-cyclone-dust-collector/g0860";
const manualUrl = "https://cdn0.grizzly.com/manuals/g0860_m.pdf";
const partsUrl = "https://www.grizzly.com/products/g0860/parts";
const partsListUrl = "https://cdn0.grizzly.com/partslists/g0860_pl.pdf";
const warrantyUrl = "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty";
const repairUrl = "https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item";
const positiveOwnerUrl = "https://www.finewoodworking.com/2021/01/12/tool-review-grizzly-g0860-dust-collector";
const negativeOwnerUrl = "https://www.lumberjocks.com/threads/dc-question.309661/";

async function record() {
  const generated = JSON.parse(await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"));
  return generated.products.find((product) => product.slug === slug);
}

test("the Grizzly G0860 record preserves exact configuration, repair, and evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0860");
  assert.equal(product.sku, "G0860");
  assert.equal(product.category, "dust-collectors");
  assert.equal(product.category_group, "tools-shop");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-10");
  assert.match(product.variant_notes, /G0860.*1-1\/2 HP.*110V.*single-phase.*20-gallon.*G0861.*2 HP.*220V.*G0862.*3 HP.*220V.*not transferred/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsUrl,
    partsListUrl,
    warrantyUrl,
    repairUrl,
    positiveOwnerUrl,
    negativeOwnerUrl,
  ]) {
    assert.ok(sourceUrls.has(url), `missing source ${url}`);
  }

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-10");

  assert.equal(product.warranty.warranty_length, "1 year limited warranty");
  assert.equal(product.warranty.source_url, warrantyUrl);
  assert.equal(product.warranty.verified_date, "2026-10-10");

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0860.*portable.*cyclone.*110V.*single-phase/is);
  assert.match(fields.parts_availability.display_value, /exact-model.*parts.*filter.*availability.*not guaranteed/is);
  assert.match(fields.repair_manual.display_value, /maintenance.*troubleshooting.*wiring.*parts.*does not provide.*internal repair/is);
  assert.match(fields.serviceability.display_value, /owner.*filter.*bag.*electrical.*qualified/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /mixed.*anecdotal.*roughly one year.*expected service life.*failure rate.*repair economics.*not yet verified/is);

  assert.equal(product.expected_service_life_years, null);
  assert.equal(product.street_price_cents, null);
  assert.equal(product.annual_maintenance_cost_cents, null);
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);
  assert.equal(product.image_license_basis, null);
  assert.equal(product.image_license_url, null);
  assert.equal(product.image_attribution, null);
  assert.equal(product.image_alt, null);

  assert.equal(product.affiliate_links.length, 1);
  assert.equal(product.affiliate_links[0].program_name, "Amazon Associates");
  assert.equal(product.affiliate_links[0].url, "https://www.amazon.com/dp/B07K1YTJZD?tag=everlastin08f-20");
  assert.equal(product.affiliate_links[0].exact_model, true);
  assert.equal(product.affiliate_links[0].verified_date, "2026-10-10");
});
