import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("legacy article pages stay quarantined except audited restored guides", async () => {
  const source = await text("src/app/articles/[slug]/page.tsx");
  assert.match(source, /Legacy guide under evidence review/);
  assert.match(source, /RESTORED_GUIDE_SLUG/);
  assert.match(source, /renderArticleHtml/);
  assert.match(source, /index:\s*true/);
  assert.doesNotMatch(source, /normalizeAmazonAffiliateUrl/);
});

test("the restored safety-razor body is manufacturer-sourced and noncommercial", async () => {
  const source = await text("src/content/safety-razors.mjs");
  assert.match(source, /We did not perform a long-term hands-on test/);
  assert.match(source, /edwinjagger\.co\.uk/);
  assert.match(source, /merkur-razors\.com/);
  assert.match(source, /hensonshaving\.com/);
  assert.match(source, /muehle-shaving\.com/);
  assert.doesNotMatch(source, /amazon\.com/);
  assert.doesNotMatch(source, /href=["']https:\/\/www\.amazon\.com\/s/);
});

test("public discovery surfaces use generated database records instead of legacy articles", async () => {
  const home = await text("src/app/page.tsx");
  const products = await text("src/app/products/page.tsx");
  assert.match(home, /generated\/database\.json/);
  assert.doesNotMatch(home, /ArticleCard/);
  assert.match(products, /generated\/database\.json/);
  assert.doesNotMatch(products, /@\/lib\/data/);
});

test("sitemap publishes database records and only audited restored guides", async () => {
  const source = await text("src/app/sitemap.ts");
  assert.match(source, /database\/\$\{product\.slug\}/);
  assert.match(source, /articles\/best-cast-iron-skillets-that-last-forever/);
  assert.match(source, /articles\/best-safety-razors-that-last-a-lifetime/);
  assert.doesNotMatch(source, /articles\.map/);
  for (const route of ["/contact", "/privacy", "/terms"]) {
    assert.ok(source.includes(route), `${route} must be included in the sitemap`);
  }
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
