import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function source(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

const expectedRecordLinks = new Map([
  ["moccamaster-kbgv-select-53948", "is-a-moccamaster-buy-it-for-life"],
  ["estwing-b3-3lb", "best-estwing-hammers-that-last-a-lifetime"],
  ["victorinox-fibrox-5-2063-20", "best-kitchen-knives-that-last-a-lifetime"],
  ["lodge-l10sk3", "best-cast-iron-skillets-that-last-forever"],
  ["merkur-34c", "best-safety-razors-that-last-a-lifetime"],
]);

test("every restored guide declares its matching database record", async () => {
  const registry = await source("src/content/restored-guides.ts");

  for (const [databaseSlug, articleSlug] of expectedRecordLinks) {
    assert.match(
      registry,
      new RegExp(`slug: "${articleSlug}"[\\s\\S]*?databaseSlug: "${databaseSlug}"`),
      `${articleSlug} must declare database record ${databaseSlug}`,
    );
  }
});

test("verified database records link to their evidence-reviewed guide", async () => {
  const page = await source("src/app/database/[slug]/page.tsx");

  assert.match(page, /import \{ getRestoredGuideByDatabaseSlug \} from "@\/content\/restored-guides"/);
  assert.match(page, /getRestoredGuideByDatabaseSlug\(product\.slug\)/);
  assert.match(page, /href=\{`\/articles\/\$\{evidenceGuide\.slug\}`\}/);
  assert.match(page, /Read the evidence-reviewed guide/);
  assert.match(page, /data-internal-placement="database-record-evidence-guide"/);
});

test("verified guide links surface on shared product cards and category comparisons", async () => {
  const [registry, card, categoryPage] = await Promise.all([
    source("src/content/restored-guides.ts"),
    source("src/components/DatabaseProductCard.tsx"),
    source("src/app/database/category/[category]/page.tsx"),
  ]);

  assert.match(registry, /export function getRestoredGuideByDatabaseSlug/);

  assert.match(card, /getRestoredGuideByDatabaseSlug\(product\.slug\)/);
  assert.match(card, /data-internal-placement="database-card-evidence-guide"/);
  assert.match(card, /Read evidence-reviewed guide/);

  assert.match(categoryPage, /getRestoredGuideByDatabaseSlug\(product\.slug\)/);
  assert.match(categoryPage, /data-internal-placement="database-category-evidence-guide"/);
  assert.match(categoryPage, /Read evidence-reviewed guide/);
});
