import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

const slug = "lodge-l10sk3";
const articleSlug = "best-cast-iron-skillets-that-last-forever";
const productUrl = "https://www.lodgecastiron.com/products/round-cast-iron-classic-skillet?variant=51685752242548";
const warrantyUrl = "https://www.lodgecastiron.com/pages/lodge-promise";
const cleanUrl = "https://www.lodgecastiron.com/pages/how-to-clean";
const seasonUrl = "https://www.lodgecastiron.com/pages/how-to-season";
const imageSourceUrl = "https://commons.wikimedia.org/wiki/File:Lodge_skillet.jpg";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

async function record() {
  const database = JSON.parse(await text("src/generated/database.json"));
  return database.products.find((product) => product.slug === slug);
}

test("the restored Lodge guide is connected to its exact-model structured record", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");

  assert.match(page, new RegExp(`databaseSlug: "${slug}"`));
  assert.match(page, /Review repairability record/);
  assert.match(page, /href=\{`\/database\/\$\{config\.databaseSlug\}`\}/);
  assert.match(page, new RegExp(articleSlug));
});

test("the Lodge L10SK3 record preserves exact identity, maintenance, warranty, photo, and destination evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Lodge");
  assert.equal(product.model, "12-Inch Classic Cast Iron Skillet");
  assert.equal(product.sku, "L10SK3");
  assert.equal(product.category, "skillets");
  assert.equal(product.category_group, "kitchen");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-05");
  assert.match(product.variant_notes, /standalone.*12-inch.*10\.25-inch.*packages.*not transferred/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    warrantyUrl,
    cleanUrl,
    seasonUrl,
    imageSourceUrl,
    "https://www.centurylife.org/in-depth-product-review-lodge-12-inch-cast-iron-skillet-10sk-l10sk3ashh41b",
    "https://permies.com/t/21138/Lodge-good-skillet-brand",
    "https://www.reddit.com/r/BuyItForLife/comments/etysnu",
    "https://www.amazon.com/dp/B00006JSUB",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /12-inch.*seasoned.*cast-?iron.*USA/i);
  assert.match(fields.warranty.display_value, /limited lifetime.*cracks.*warping.*rust.*seasoning.*excluded/i);
  assert.match(fields.parts_availability.display_value, /no replaceable assemblies.*surface.*re-season/i);
  assert.match(fields.repair_manual.display_value, /official.*cleaning.*rust.*re-seasoning.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*cleaning.*rust.*seasoning.*structural/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /Lodge documents.*seasoning.*warranty.*owner.*12 years.*does not establish.*expected service life.*recommendation/i);

  assert.equal(product.repairability.parts_availability, "none");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, null);
  assert.equal(product.repairability.serviceability, "user-serviceable");

  assert.equal(product.image_url, "/images/products/lodge-l10sk3-12-inch-skillet.jpg");
  assert.equal(product.image_source_url, imageSourceUrl);
  assert.equal(product.image_license_url, "https://creativecommons.org/licenses/by-sa/3.0");
  assert.match(product.image_license_basis, /Lodge.*12-inch.*does not independently establish.*L10SK3/i);
  assert.match(product.image_attribution, /Jim Heaphy/);
  assert.match(product.image_alt, /Lodge 12-inch.*skillet/i);
  await access(new URL(`../public${product.image_url}`, import.meta.url));

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00006JSUB?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-05",
  }]);
});
