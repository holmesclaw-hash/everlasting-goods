import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

import { articleImageEvidence } from "../src/content/article-image-evidence.mjs";

const slug = "best-estwing-hammers-that-last-a-lifetime";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("restored Estwing guide has a lawful exact-product-family photo", async () => {
  const evidence = articleImageEvidence[slug];
  assert.ok(evidence, `${slug} needs image evidence`);
  assert.equal(evidence.exact_product_model, "Estwing B3-3LB 3-lb drilling hammer family");
  assert.equal(evidence.rights_basis, "open-license");
  assert.equal(evidence.license, "CC BY-SA 3.0");
  assert.equal(evidence.license_url, "https://creativecommons.org/licenses/by-sa/3.0");
  assert.equal(evidence.source_url, "https://commons.wikimedia.org/wiki/File:Estwing_3-lb._drilling_hammer.jpg");
  assert.match(evidence.attribution, /J\.C\. Fields/);
  assert.match(evidence.alt, /Estwing 3-lb drilling hammer/i);
  await access(new URL(`../public${evidence.image}`, import.meta.url));
});

test("restored Estwing guide separates product facts, owner reports, warranty limits, and safety boundaries", async () => {
  const content = await text("src/content/estwing-drilling-hammer.mjs");
  const data = await text("src/lib/data.ts");
  const sitemap = await text("src/app/sitemap.ts");

  assert.match(content, /We did not perform a hands-on or long-term test/);
  assert.match(content, /estwing\.com\/product\/drilling-hammer/);
  assert.match(content, /estwing\.com\/resources\/warranty/);
  assert.match(content, /garagejournal\.com\/forum\/threads\/estwing-sledgehammer\.522660/);
  assert.match(content, /practicalmachinist\.com\/forum\/threads\/ot-estwing-hammers-worth-the-extra\.145239/);
  assert.match(content, /individual owner reports, not controlled lifespan data/i);
  assert.match(content, /not a lifetime warranty/i);
  assert.match(content, /cannot repair, re-grip, or refurbish/i);
  assert.match(content, /manufacturer’s stated uses/i);
  assert.match(data, /content:\s*estwingDrillingHammerContent,\s*updatedAt: "2026-09-04"/);
  assert.match(data, /slug: "best-estwing-hammers-that-last-a-lifetime"[\s\S]*?image: "\/images\/articles\/estwing-b3-3lb-drilling-hammer\.jpg"/);
  assert.match(sitemap, /articles\/best-estwing-hammers-that-last-a-lifetime/);
});

test("restored Estwing guide discloses before its verified exact-model destination", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  const disclosureIndex = page.indexOf("<AffiliateDisclosure");
  const destinationIndex = page.indexOf("amazonLink(config.asin)");

  assert.match(page, /ESTWING_GUIDE_SLUG/);
  assert.match(page, /asin: "B00002N5NI"/);
  assert.ok(disclosureIndex >= 0, "restored guide must render the affiliate disclosure");
  assert.ok(destinationIndex > disclosureIndex, "disclosure must precede the exact-model destination");
  assert.match(page, /View exact Estwing B3-3LB on Amazon/);
  assert.match(page, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(page, /Price and availability are shown only by the merchant/);
});
