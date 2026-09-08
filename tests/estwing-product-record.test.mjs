import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

const slug = "estwing-b3-3lb";
const articleSlug = "best-estwing-hammers-that-last-a-lifetime";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

async function record() {
  const database = JSON.parse(await text("src/generated/database.json"));
  return database.products.find((product) => product.slug === slug);
}

test("the Estwing guide is connected to an exact-model structured record", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");

  assert.match(page, new RegExp(`databaseSlug: "${slug}"`));
  assert.match(page, /Review repairability record/);
  assert.match(page, /href=\{`\/database\/\$\{config\.databaseSlug\}`\}/);
  assert.match(page, new RegExp(articleSlug));
});

test("the Estwing B3-3LB record preserves manufacturer, owner, photo, and exact-destination evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Estwing");
  assert.equal(product.model, "B3-3LB");
  assert.equal(product.sku, "B3-3LB");
  assert.equal(product.category, "hammers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.last_reviewed_date, "2026-09-08");

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.estwing.com/product/drilling-hammer/",
    "https://www.estwing.com/resources/warranty/",
    "https://www.garagejournal.com/forum/threads/estwing-sledgehammer.522660/",
    "https://www.practicalmachinist.com/forum/threads/ot-estwing-hammers-worth-the-extra.145239/",
    "https://commons.wikimedia.org/wiki/File:Estwing_3-lb._drilling_hammer.jpg",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /3-lb.*11-inch.*one.?piece/i);
  assert.match(fields.warranty.display_value, /not a lifetime warranty/i);
  assert.match(fields.parts_availability.display_value, /cannot repair, re-grip, or refurbish/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "none");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "non-serviceable");
  assert.equal(product.image_url, "/images/products/estwing-b3-3lb-drilling-hammer.jpg");
  assert.equal(product.image_source_url, "https://commons.wikimedia.org/wiki/File:Estwing_3-lb._drilling_hammer.jpg");
  assert.equal(product.image_license_url, "https://creativecommons.org/licenses/by-sa/3.0");
  assert.match(product.image_license_basis, /exact model/i);
  assert.match(product.image_attribution, /J\.C\. Fields/);
  assert.match(product.image_alt, /B3-3LB/i);
  await access(new URL(`../public${product.image_url}`, import.meta.url));

  assert.equal(product.affiliate_links.length, 1);
  const destination = new URL(product.affiliate_links[0].url);
  assert.equal(destination.hostname, "www.amazon.com");
  assert.equal(destination.pathname, "/dp/B00002N5NI");
  assert.equal(destination.searchParams.get("tag"), "everlastin08f-20");
  assert.equal(product.affiliate_links[0].exact_model, true);
  assert.equal(product.affiliate_links[0].verified_date, "2026-09-08");
});
