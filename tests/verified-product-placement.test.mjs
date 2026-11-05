import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function source(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("every verified-product affiliate CTA declares a stable placement", async () => {
  const [productsPage, databasePage, card, categoryPage, recordPage, tracker] = await Promise.all([
    source("src/app/products/page.tsx"),
    source("src/app/database/page.tsx"),
    source("src/components/DatabaseProductCard.tsx"),
    source("src/app/database/category/[category]/page.tsx"),
    source("src/app/database/[slug]/page.tsx"),
    source("src/components/AffiliateClickTracker.tsx"),
  ]);

  assert.match(productsPage, /affiliatePlacement="products-grid"/);
  assert.match(databasePage, /affiliatePlacement="database-grid"/);
  assert.match(card, /data-affiliate-placement=\{affiliatePlacement\}/);
  assert.match(categoryPage, /data-affiliate-placement=\{placement\}/);
  assert.match(categoryPage, /placement="database-category-mobile"/);
  assert.match(categoryPage, /placement="database-category-comparison"/);
  assert.match(recordPage, /data-affiliate-placement=\{placement\}/);
  assert.match(recordPage, /placement="database-record-mobile"/);
  assert.match(recordPage, /placement="database-record-sidebar"/);
  assert.match(tracker, /anchor\.dataset\.affiliatePlacement/);
});

test("category comparisons expose the exact-model destination beside the product on mobile", async () => {
  const categoryPage = await source("src/app/database/category/[category]/page.tsx");

  const mobileDestinationIndex = categoryPage.indexOf('placement="database-category-mobile"');
  const desktopDestinationIndex = categoryPage.indexOf('placement="database-category-comparison"');

  assert.match(categoryPage, /function CategoryAffiliateDestination/);
  assert.match(categoryPage, /data-affiliate-placement=\{placement\}/);
  assert.ok(mobileDestinationIndex >= 0, "category comparison must render a mobile exact-model destination");
  assert.ok(desktopDestinationIndex > mobileDestinationIndex, "mobile destination must appear beside the product before the desktop-only destination column");
  assert.match(categoryPage, /className="[^"]*md:hidden[^"]*"/);
  assert.match(categoryPage, /className="[^"]*hidden[^"]*md:table-cell[^"]*"/);
});

test("verified-product destinations name the exact brand and model before sending a shopper to Amazon", async () => {
  const [card, categoryPage, recordPage] = await Promise.all([
    source("src/components/DatabaseProductCard.tsx"),
    source("src/app/database/category/[category]/page.tsx"),
    source("src/app/database/[slug]/page.tsx"),
  ]);

  assert.match(card, /View \{product\.brand\} \{product\.model\} on Amazon/);
  assert.match(categoryPage, /productLabel=\{`\$\{product\.brand\} \$\{product\.model\}`\}/);
  assert.match(categoryPage, /View \{productLabel\} on Amazon/);
  assert.match(recordPage, /productLabel=\{`\$\{product\.brand\} \$\{product\.model\}`\}/);
  assert.match(recordPage, /View \{productLabel\} on Amazon/);
});
