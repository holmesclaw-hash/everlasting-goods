import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

import {
  latestCategoryReviewDate,
  latestGuideReviewDate,
  latestReviewDate,
} from "../src/lib/sitemap-freshness.mjs";

async function generatedProducts() {
  const text = await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8");
  return JSON.parse(text).products;
}

test("database discovery pages inherit the newest review date in their product scope", async () => {
  const products = await generatedProducts();

  assert.equal(latestReviewDate(products), "2026-10-25");
  assert.equal(latestCategoryReviewDate(products, "drill-drivers"), "2026-10-25");
  assert.equal(latestCategoryReviewDate(products, "drill-presses"), "2026-10-16");
  assert.equal(latestCategoryReviewDate(products, "chef-knives"), "2026-10-06");
  assert.equal(latestCategoryReviewDate(products, "missing-category"), null);
});

test("guide discovery freshness inherits the newest reviewed guide date", () => {
  const guides = [
    { slug: "older-guide", reviewedAt: "2026-09-08" },
    { slug: "newest-guide", reviewedAt: "2026-10-15" },
    { slug: "undated-guide" },
  ];

  assert.equal(latestGuideReviewDate(guides), "2026-10-15");
  assert.equal(latestGuideReviewDate([]), null);
});

test("the sitemap uses content-derived freshness for commercial discovery routes", async () => {
  const sitemap = await readFile(new URL("../src/app/sitemap.ts", import.meta.url), "utf8");

  assert.match(sitemap, /latestReviewDate\(database\.products\)/);
  assert.match(sitemap, /lastModified: databaseReviewed/);
  assert.match(sitemap, /latestCategoryReviewDate\(database\.products, category\)/);
  assert.doesNotMatch(sitemap, /database\/category\/\$\{category\}[^\n]*lastModified: reviewed/);
  assert.match(sitemap, /latestGuideReviewDate\(restoredGuides\)/);
  assert.match(sitemap, /restoredGuides\.map\(\(guide\) =>/);
  assert.doesNotMatch(sitemap, /articles\/best-kitchen-knives-that-last-a-lifetime[^\n]*new Date\("2026-08-31"\)/);
});
