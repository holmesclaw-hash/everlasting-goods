import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

import { articleImageEvidence } from "../src/content/article-image-evidence.mjs";

const slug = "best-cast-iron-skillets-that-last-forever";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("restored cast-iron guide has a lawful exact-product photo", async () => {
  const evidence = articleImageEvidence[slug];
  assert.ok(evidence, `${slug} needs image evidence`);
  assert.equal(evidence.exact_product_model, "Lodge 12-inch cast-iron skillet");
  assert.equal(evidence.rights_basis, "open-license");
  assert.equal(evidence.license, "CC BY-SA 3.0");
  assert.equal(evidence.source_url, "https://commons.wikimedia.org/wiki/File:Lodge_skillet.jpg");
  assert.match(evidence.attribution, /Jim Heaphy/);
  assert.match(evidence.alt, /Lodge 12-inch/i);
  await access(new URL(`../public${evidence.image}`, import.meta.url));
});

test("restored cast-iron guide separates manufacturer facts, owner reports, and evidence limits", async () => {
  const content = await text("src/content/cast-iron-skillets.mjs");
  const data = await text("src/lib/data.ts");
  const sitemap = await text("src/app/sitemap.ts");

  assert.match(content, /We did not perform a hands-on or long-term test/);
  assert.match(content, /lodgecastiron\.com\/products\/round-cast-iron-classic-skillet/);
  assert.match(content, /lodgecastiron\.com\/pages\/lodge-promise/);
  assert.match(content, /lodgecastiron\.com\/pages\/how-to-clean/);
  assert.match(content, /centurylife\.org\/in-depth-product-review-lodge-12-inch-cast-iron-skillet/);
  assert.match(content, /permies\.com\/t\/21138\/Lodge-good-skillet-brand/);
  assert.match(content, /individual owner reports, not controlled lifespan data/i);
  assert.match(data, /content:\s*castIronSkilletContent,\s*updatedAt: "2026-08-30"/);
  assert.match(sitemap, /articles\/best-cast-iron-skillets-that-last-forever/);
});

test("restored cast-iron guide discloses before its verified exact-model destination", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  const disclosureIndex = page.indexOf("<AffiliateDisclosure");
  const destinationIndex = page.indexOf('amazonLink("B00006JSUB")');

  assert.match(page, /CAST_IRON_GUIDE_SLUG/);
  assert.ok(disclosureIndex >= 0, "restored guide must render the affiliate disclosure");
  assert.ok(destinationIndex > disclosureIndex, "disclosure must precede the exact-model destination");
  assert.match(page, /View exact Lodge L10SK3 on Amazon/);
  assert.match(page, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(page, /Price and availability are shown only by the merchant/);
});
