import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

import { articleImageEvidence } from "../src/content/article-image-evidence.mjs";

const restoredSlug = "best-safety-razors-that-last-a-lifetime";

test("every publishable article has an exact-product photo with recorded rights", async () => {
  const evidence = articleImageEvidence[restoredSlug];
  assert.ok(evidence, `${restoredSlug} needs image evidence`);
  assert.equal(evidence.exact_product_model, "MERKUR 34C");
  assert.equal(evidence.rights_basis, "open-license");
  assert.equal(evidence.license, "CC BY-SA 3.0");
  assert.equal(evidence.license_url, "https://creativecommons.org/licenses/by-sa/3.0");
  assert.equal(evidence.source_url, "https://commons.wikimedia.org/wiki/File:Merkur_heavy_duty_safety_razor.jpg");
  assert.match(evidence.attribution, /Hustvedt/);
  assert.match(evidence.alt, /MERKUR 34C/);
  assert.match(evidence.image, /^\/images\/articles\//);
  await access(new URL(`../public${evidence.image}`, import.meta.url));
});

test("the restored guide renders its documented exact-product image and attribution", async () => {
  const page = await readFile(new URL("../src/app/articles/[slug]/page.tsx", import.meta.url), "utf8");
  const content = await readFile(new URL("../src/content/safety-razors.mjs", import.meta.url), "utf8");
  assert.match(page, /articleImageEvidence/);
  assert.match(page, /imageEvidence\.attribution/);
  assert.match(content, /MERKUR 34C/);
});

test("operator policy blocks articles without lawful exact-product photos", async () => {
  const policy = await readFile(new URL("../ops/editorial-photo-policy.md", import.meta.url), "utf8");
  assert.match(policy, /every new article must include at least one genuine photo of an exact product/i);
  assert.match(policy, /block publication/i);
  assert.match(policy, /Never scrape retailer or Amazon imagery/i);
});
