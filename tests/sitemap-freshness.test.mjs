import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

import {
  latestCategoryReviewDate,
  latestReviewDate,
} from "../src/lib/sitemap-freshness.mjs";

async function generatedProducts() {
  const text = await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8");
  return JSON.parse(text).products;
}

test("database discovery pages inherit the newest review date in their product scope", async () => {
  const products = await generatedProducts();

  assert.equal(latestReviewDate(products), "2026-10-24");
  assert.equal(latestCategoryReviewDate(products, "drill-drivers"), "2026-10-24");
  assert.equal(latestCategoryReviewDate(products, "drill-presses"), "2026-10-16");
  assert.equal(latestCategoryReviewDate(products, "chef-knives"), "2026-10-06");
  assert.equal(latestCategoryReviewDate(products, "missing-category"), null);
});

test("the sitemap uses content-derived freshness for commercial discovery routes", async () => {
  const sitemap = await readFile(new URL("../src/app/sitemap.ts", import.meta.url), "utf8");

  assert.match(sitemap, /latestReviewDate\(database\.products\)/);
  assert.match(sitemap, /lastModified: databaseReviewed/);
  assert.match(sitemap, /latestCategoryReviewDate\(database\.products, category\)/);
  assert.doesNotMatch(sitemap, /database\/category\/\$\{category\}[^\n]*lastModified: reviewed/);
});
