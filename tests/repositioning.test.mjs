import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("legacy article pages are quarantined without claims or affiliate links", async () => {
  const source = await text("src/app/articles/[slug]/page.tsx");
  assert.match(source, /Legacy guide under evidence review/);
  assert.match(source, /index:\s*false/);
  assert.doesNotMatch(source, /renderArticleHtml/);
  assert.doesNotMatch(source, /normalizeAmazonAffiliateUrl/);
});

test("public discovery surfaces use generated database records instead of legacy articles", async () => {
  const home = await text("src/app/page.tsx");
  const products = await text("src/app/products/page.tsx");
  assert.match(home, /generated\/database\.json/);
  assert.doesNotMatch(home, /ArticleCard/);
  assert.match(products, /generated\/database\.json/);
  assert.doesNotMatch(products, /@\/lib\/data/);
});

test("sitemap publishes database records and excludes quarantined legacy articles", async () => {
  const source = await text("src/app/sitemap.ts");
  assert.match(source, /database\/\$\{product\.slug\}/);
  assert.doesNotMatch(source, /articles\.map/);
});

test("legacy source author fields use the transparent editorial identity", async () => {
  const source = await text("src/lib/data.ts");
  const authors = Array.from(source.matchAll(/author:\s*"([^"]+)"/g), ([, author]) => author);
  assert.ok(authors.length >= 54);
  assert.deepEqual(new Set(authors), new Set(["Everlasting Goods Editorial Team"]));
});

test("database record, category, and decision-tool routes exist", async () => {
  await Promise.all([
    text("src/app/database/page.tsx"),
    text("src/app/database/[slug]/page.tsx"),
    text("src/app/database/category/[category]/page.tsx"),
    text("src/app/tools/cost-per-year/page.tsx"),
    text("src/app/tools/repair-or-replace/page.tsx"),
  ]);
});

test("the shared layout registers consent-gated referral measurement", async () => {
  const source = await text("src/app/layout.tsx");
  assert.match(source, /ReferralTracker/);
});
