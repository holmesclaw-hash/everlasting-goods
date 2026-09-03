import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

import { articleImageEvidence } from "../src/content/article-image-evidence.mjs";

const slug = "best-kitchen-knives-that-last-a-lifetime";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("restored Victorinox guide has a lawful exact-product photo", async () => {
  const evidence = articleImageEvidence[slug];
  assert.ok(evidence, `${slug} needs image evidence`);
  assert.equal(evidence.exact_product_model, "Victorinox Fibrox 5.2063.20 Chef’s Knife Extra Wide, 8 in");
  assert.equal(evidence.rights_basis, "open-license");
  assert.equal(evidence.license, "CC BY-SA 4.0");
  assert.equal(evidence.license_url, "https://creativecommons.org/licenses/by-sa/4.0");
  assert.equal(evidence.source_url, "https://commons.wikimedia.org/wiki/File:Victorinox_Fibrox_5.2063.20_chef%27s_knife.jpg");
  assert.match(evidence.attribution, /Francis Flinch/);
  assert.match(evidence.alt, /Victorinox Fibrox 5\.2063\.20/i);
  await access(new URL(`../public${evidence.image}`, import.meta.url));
});

test("restored Victorinox guide separates current specifications, owner evidence, and limitations", async () => {
  const content = await text("src/content/victorinox-fibrox.mjs");
  const data = await text("src/lib/data.ts");
  const sitemap = await text("src/app/sitemap.ts");

  assert.match(content, /We did not perform a hands-on or long-term test/);
  assert.match(content, /victorinox\.com\/en-US\/Products\/Cutlery/);
  assert.match(content, /victorinox\.com\/en-US\/Cutlery-Warranties/);
  assert.match(content, /victorinox\.com\/en-US\/Cutlery\/Information\/How-to-Sharpen/);
  assert.match(content, /barbecuefaq\.com\/victorinox-knives-review/);
  assert.match(content, /individual owner report, not controlled lifespan data/i);
  assert.match(content, /not modularly repairable/i);
  assert.match(data, /content:\s*victorinoxFibroxContent,\s*updatedAt: "2026-08-31"/);
  assert.match(data, /slug: "best-kitchen-knives-that-last-a-lifetime"[\s\S]*?image: "\/images\/articles\/victorinox-fibrox-5-2063-20\.jpg"/);
  assert.match(sitemap, /articles\/best-kitchen-knives-that-last-a-lifetime/);
});

test("restored Victorinox guide discloses before its verified exact-model destination", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  const disclosureIndex = page.indexOf("<AffiliateDisclosure");
  const destinationIndex = page.indexOf("amazonLink(config.asin)");

  assert.match(page, /VICTORINOX_GUIDE_SLUG/);
  assert.match(page, /asin: "B008M5U1C2"/);
  assert.ok(disclosureIndex >= 0, "restored guide must render the affiliate disclosure");
  assert.ok(destinationIndex > disclosureIndex, "disclosure must precede the exact-model destination");
  assert.match(page, /View exact Victorinox Fibrox 8-inch on Amazon/);
  assert.match(page, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(page, /Price and availability are shown only by the merchant/);
});
