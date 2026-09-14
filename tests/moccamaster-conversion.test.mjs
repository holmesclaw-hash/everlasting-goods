import assert from "node:assert/strict";
import { access, readFile } from "node:fs/promises";
import test from "node:test";

import { articleImageEvidence } from "../src/content/article-image-evidence.mjs";

const slug = "is-a-moccamaster-buy-it-for-life";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("the Moccamaster evidence review is photo-gated, discoverable, and indexable", async () => {
  const [page, data, registry, sitemap] = await Promise.all([
    text("src/app/articles/[slug]/page.tsx"),
    text("src/lib/data.ts"),
    text("src/content/restored-guides.ts"),
    text("src/app/sitemap.ts"),
  ]);
  const evidence = articleImageEvidence[slug];

  assert.ok(evidence, "Moccamaster publication needs exact-model image evidence");
  assert.equal(evidence.exact_product_model, "Technivorm Moccamaster K741.64B");
  assert.equal(evidence.rights_basis, "open-license");
  assert.equal(evidence.license, "CC BY-SA 4.0");
  assert.equal(evidence.license_url, "https://creativecommons.org/licenses/by-sa/4.0");
  assert.equal(evidence.source_url, "https://commons.wikimedia.org/wiki/File:Technivorm_Moccamaster_K741.64B.jpg");
  assert.match(evidence.attribution, /Aaaatu/);
  assert.match(evidence.alt, /K741\.64B/);
  await access(new URL(`../public${evidence.image}`, import.meta.url));

  assert.match(page, /is-a-moccamaster-buy-it-for-life/);
  assert.match(page, /asin: "B093DXS54M"/);
  assert.match(data, /moccamasterK741Content/);
  assert.match(data, /slug: "is-a-moccamaster-buy-it-for-life"/);
  assert.match(registry, /is-a-moccamaster-buy-it-for-life/);
  assert.match(sitemap, /is-a-moccamaster-buy-it-for-life/);
});

test("the Moccamaster review separates historical owner evidence from the current commercial model", async () => {
  const content = await text("src/content/moccamaster-k741.mjs");

  assert.match(content, /K741\.64B/);
  assert.match(content, /KBGV Select/);
  assert.match(content, /not evidence that a current KBGV Select will last the same length of time/i);
  assert.match(content, /us\.moccamaster\.com\/products\/kbgv/);
  assert.match(content, /collections\/kbgv-select-coffee-brewer-parts/);
  assert.match(content, /1500009429481-Can-I-get-my-Moccamaster-repaired/);
  assert.match(content, /1500012391061-What-warranty-does-my-Moccamaster-coffee-brewer-come-with/);
  assert.match(content, /commons\.wikimedia\.org\/wiki\/File:Technivorm_Moccamaster_K741\.64B\.jpg/);
  assert.match(content, /reddit\.com\/r\/BuyItForLife\/comments\/1nvw5m5/);
  assert.match(content, /bestreviews\.com\/kitchen\/coffee-accessories/);
  assert.match(content, /No hands-on or ownership claim/i);
  assert.doesNotMatch(content, /\$\d|\b4\.[0-9]\s*(?:stars|rating)|\bin stock\b/i);
});
