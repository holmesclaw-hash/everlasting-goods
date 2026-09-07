import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function source(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("every verified-product affiliate CTA declares a stable placement", async () => {
  const [productsPage, card, categoryPage, recordPage, tracker] = await Promise.all([
    source("src/app/products/page.tsx"),
    source("src/components/DatabaseProductCard.tsx"),
    source("src/app/database/category/[category]/page.tsx"),
    source("src/app/database/[slug]/page.tsx"),
    source("src/components/AffiliateClickTracker.tsx"),
  ]);

  assert.match(productsPage, /affiliatePlacement="products-grid"/);
  assert.match(card, /data-affiliate-placement=\{affiliatePlacement\}/);
  assert.match(categoryPage, /data-affiliate-placement="database-category-comparison"/);
  assert.match(recordPage, /data-affiliate-placement="database-record-sidebar"/);
  assert.match(tracker, /anchor\.dataset\.affiliatePlacement/);
});
