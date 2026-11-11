import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("shared database cards measure product-record discovery by source surface", async () => {
  const [card, home, products, database, categories] = await Promise.all([
    text("src/components/DatabaseProductCard.tsx"),
    text("src/app/page.tsx"),
    text("src/app/products/page.tsx"),
    text("src/app/database/page.tsx"),
    text("src/app/categories/[slug]/page.tsx"),
  ]);

  assert.match(card, /recordPlacement: string/);
  assert.match(card, /data-internal-placement=\{`\$\{recordPlacement\}-image`\}/);
  assert.match(card, /data-internal-placement=\{`\$\{recordPlacement\}-details`\}/);
  assert.match(home, /recordPlacement="home-featured-record"/);
  assert.match(products, /recordPlacement="products-grid-record"/);
  assert.match(database, /recordPlacement="database-grid-record"/);
  assert.match(categories, /recordPlacement="legacy-tools-category-record"/);
});

test("category comparisons measure clicks into individual product records", async () => {
  const category = await text("src/app/database/category/[category]/page.tsx");

  assert.match(category, /data-internal-placement="database-category-record"/);
  assert.match(category, /href=\{`\/database\/\$\{product\.slug\}`\}/);
});

test("category comparison destinations attribute clicks to the exact product record", async () => {
  const category = await text("src/app/database/category/[category]/page.tsx");

  assert.match(category, /data-affiliate-product=\{productSlug\}/);
  assert.match(category, /productSlug=\{product\.slug\}/);
});

test("database landing page measures its primary research-path choices", async () => {
  const database = await text("src/app/database/page.tsx");

  assert.match(database, /data-internal-placement="database-cost-per-year"/);
  assert.match(database, /data-internal-placement="database-repair-or-replace"/);
  assert.match(database, /data-internal-placement="database-category-comparison"/);
});
