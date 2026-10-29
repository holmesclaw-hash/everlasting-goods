import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

const slug = "merkur-34c";
const productUrl = "https://shopmerkur.com/products/merkur-double-edge-safety-razor-straight-cut-extra-thick-handle-chrome";
const partsUrl = "https://shopmerkur.com/products/merkur-34c-top-plate-with-long-screw-in-chrome-finish-mk-90004";
const bladeGuideUrl = "https://www.merkur-razors.com/wp-content/uploads/2024/07/safety-razor-two-piece-blade-replacement.pdf";
const careUrl = "https://www.merkur-razors.com/care-for-shaving-tools/?lang=en";
const serviceUrl = "https://www.merkur-razors.com/customer-service/?lang=en";
const ownerEightYearUrl = "https://www.badgerandblade.com/forum/threads/original-34c-thursdays.656755/";
const ownerFiveYearUrl = "https://www.badgerandblade.com/forum/threads/merkur-34c.612135/";
const imageSourceUrl = "https://commons.wikimedia.org/wiki/File:Merkur_heavy_duty_safety_razor.jpg";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

async function record() {
  const database = JSON.parse(await text("src/generated/database.json"));
  return database.products.find((product) => product.slug === slug);
}

test("the MERKUR 34C record preserves current configuration, partial repair, revision, and lifespan boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "MERKUR");
  assert.equal(product.model, "34C");
  assert.equal(product.sku, "MK-34001");
  assert.equal(product.category, "safety-razors");
  assert.equal(product.category_group, "personal-care");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-14");
  assert.match(product.variant_notes, /current.*bright-chrome.*MK-34001.*two-piece/is);
  assert.match(product.variant_notes, /photograph.*2008.*historical.*revision/is);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    partsUrl,
    bladeGuideUrl,
    careUrl,
    serviceUrl,
    ownerEightYearUrl,
    ownerFiveYearUrl,
    imageSourceUrl,
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /MK-34001.*78-gram.*two-piece.*closed-comb.*brass handle.*zinc.*chrome/is);
  assert.match(fields.parts_availability.display_value, /Partial.*MK-90004.*top plate.*34C.*base plate.*handle.*not.*verified/is);
  assert.match(fields.repair_manual.display_value, /blade-change.*care.*not.*comprehensive.*repair manual/is);
  assert.match(fields.serviceability.display_value, /standard double-edge blade.*clean.*dry.*top plate.*service.?request/is);
  assert.match(fields.warranty.display_value, /No product-specific.*warranty.*verified.*statutory.*defect.*purchase channel/is);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.annual_maintenance_cost.evidence_tier, "T4");
  assert.equal(fields.annual_maintenance_cost.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /eight years.*five years.*anecdotal.*production.?revision.*expected service life.*repair-versus-replace.*not yet verified/is);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, bladeGuideUrl);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.repairability.verified_date, "2026-10-14");

  assert.equal(product.warranty.warranty_length, "No product-specific term verified");
  assert.equal(product.warranty.verified_date, "2026-10-14");

  assert.equal(product.expected_service_life_years, null);
  assert.equal(product.street_price_cents, null);
  assert.equal(product.annual_maintenance_cost_cents, null);
  assert.equal(product.image_url, "/images/products/merkur-34c-safety-razor.jpg");
  assert.equal(product.image_source_url, imageSourceUrl);
  assert.equal(product.image_license_basis, "Open-license exact model photograph; historical 2008 configuration, not proof of the current production revision");
  assert.equal(product.image_license_url, "https://creativecommons.org/licenses/by-sa/3.0");
  assert.match(product.image_attribution, /Hustvedt/);
  assert.match(product.image_alt, /MERKUR 34C.*two-piece.*safety razor/i);
  await access(new URL(`../public${product.image_url}`, import.meta.url));

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B002A8JO1Q?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-29",
  }]);
});

test("the restored safety-razor guide links to the MERKUR 34C record and carries the current review date", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  const data = await text("src/lib/data.ts");
  const registry = await text("src/content/restored-guides.ts");
  assert.match(page, /\[RESTORED_GUIDE_SLUG\]:\s*\{[\s\S]*?databaseSlug:\s*"merkur-34c"/);
  assert.match(page, /\[RESTORED_GUIDE_SLUG\]:\s*\{[\s\S]*?reviewedAt:\s*"2026-10-14"/);
  assert.match(data, /content:\s*safetyRazorContent,\s*updatedAt:\s*"2026-10-14"/);
  assert.match(registry, /best-safety-razors-that-last-a-lifetime[\s\S]*?reviewedAt:\s*"2026-10-14"/);
});
