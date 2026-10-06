import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

const slug = "victorinox-fibrox-5-2063-20";
const articleSlug = "best-kitchen-knives-that-last-a-lifetime";
const productUrl = "https://www.victorinox.com/en-US/p/5.2063.20";
const sharpeningUrl = "https://www.victorinox.com/en-US/Cutlery/Information/How-to-Sharpen-Your-Kitchen-Knife/cms/how-to-sharpen-your-kitchen-knife/";
const warrantyUrl = "https://www.victorinox.com/en-US/Cutlery-Warranties/cms/service-cutlery-warranties/";
const ownerUrl = "https://barbecuefaq.com/victorinox-knives-review/";
const imageSourceUrl = "https://commons.wikimedia.org/wiki/File:Victorinox_Fibrox_5.2063.20_chef%27s_knife.jpg";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

async function record() {
  const database = JSON.parse(await text("src/generated/database.json"));
  return database.products.find((product) => product.slug === slug);
}

test("the restored Victorinox guide is connected to its exact-model structured record", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");

  assert.match(page, new RegExp(`databaseSlug: "${slug}"`));
  assert.match(page, /Review repairability record/);
  assert.match(page, /href=\{`\/database\/\$\{config\.databaseSlug\}`\}/);
  assert.match(page, new RegExp(articleSlug));
});

test("the Victorinox Fibrox record preserves exact identity, edge maintenance, warranty, photo, and destination evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Victorinox");
  assert.equal(product.model, "Fibrox Chef’s Knife Extra Wide, 8 in");
  assert.equal(product.sku, "5.2063.20");
  assert.equal(product.category, "chef-knives");
  assert.equal(product.category_group, "kitchen");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-06");
  assert.match(product.variant_notes, /5\.2063\.20.*black.*8-inch.*B008M5U1C2.*other.*not transferred/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    sharpeningUrl,
    warrantyUrl,
    ownerUrl,
    imageSourceUrl,
    "https://www.amazon.com/dp/B008M5U1C2",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /8-inch.*Swiss-made.*non-forged.*straight edge.*black.*TPE/i);
  assert.match(fields.warranty.display_value, /lifetime.*material or manufacturer defects.*normal use.*proof of purchase.*authorised/i);
  assert.match(fields.parts_availability.display_value, /no model-specific replacement blade or handle/i);
  assert.match(fields.repair_manual.display_value, /sharpening and honing guidance.*maintenance.*not.*structural repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*honing.*sharpening.*professional sharpening/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /Victorinox documents.*renewable plain edge.*honing.*lifetime coverage.*15-plus years.*does not establish.*expected service life.*repair-versus-replace/i);

  assert.equal(product.repairability.parts_availability, "none");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, null);
  assert.equal(product.repairability.serviceability, "user-serviceable");

  assert.equal(product.image_url, "/images/products/victorinox-fibrox-5-2063-20.jpg");
  assert.equal(product.image_source_url, imageSourceUrl);
  assert.equal(product.image_license_url, "https://creativecommons.org/licenses/by-sa/4.0");
  assert.match(product.image_license_basis, /exact model.*Victorinox Fibrox 5\.2063\.20.*does not independently establish.*commercial destination/i);
  assert.match(product.image_attribution, /Francis Flinch/);
  assert.match(product.image_alt, /Victorinox Fibrox Chef’s Knife Extra Wide, 8 in.*5\.2063\.20.*black.*TPE/i);
  await access(new URL(`../public${product.image_url}`, import.meta.url));

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B008M5U1C2?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-06",
  }]);
});
