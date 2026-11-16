import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

import { selectToolProducts } from "../src/lib/database-utils.mjs";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("the legacy tools category excludes non-tool product records", async () => {
  const generated = JSON.parse(await text("src/generated/database.json"));
  const categoryPage = await text("src/app/categories/[slug]/page.tsx");
  const tools = selectToolProducts(generated.products);

  assert.equal(generated.products.length, 52);
  assert.equal(tools.length, 48);
  assert.ok(generated.products.some((product) => product.category === "chef-knives"));
  assert.ok(generated.products.some((product) => product.category === "skillets"));
  assert.ok(tools.every((product) => product.category_group === "tools-shop"));
  assert.match(categoryPage, /toolDatabaseProducts/);
  assert.doesNotMatch(categoryPage, /slug === "tools" \? databaseProducts : \[\]/);
});

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
