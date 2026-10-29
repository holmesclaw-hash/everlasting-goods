import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

import database from "../src/generated/database.json" with { type: "json" };

const restoredGuideRecords = [
  ["moccamaster-kbgv-select-53948", "B093DXS54M"],
  ["merkur-34c", "B002A8JO1Q"],
  ["lodge-l10sk3", "B00006JSUB"],
  ["estwing-b3-3lb", "B00002N5NI"],
  ["victorinox-fibrox-5-2063-20", "B008M5U1C2"],
];

test("restored guides show the current exact-destination verification date beside each CTA", async () => {
  const page = await readFile(new URL("../src/app/articles/[slug]/page.tsx", import.meta.url), "utf8");

  assert.match(page, /destinationVerifiedAt: "2026-10-29"/);
  assert.equal(
    page.match(/destinationVerifiedAt: "2026-10-29"/g)?.length,
    restoredGuideRecords.length,
    "each restored guide must carry the current exact-destination verification date",
  );
  assert.match(page, /Exact model destination verified \{config\.destinationVerifiedAt\}/);
});

test("restored-guide database records use the same current exact Amazon destination evidence", () => {
  for (const [slug, asin] of restoredGuideRecords) {
    const product = database.products.find((item) => item.slug === slug);
    assert.ok(product, `missing database record ${slug}`);
    assert.deepEqual(product.affiliate_links, [{
      program_name: "Amazon Associates",
      url: `https://www.amazon.com/dp/${asin}?tag=everlastin08f-20`,
      exact_model: true,
      verified_date: "2026-10-29",
    }]);
  }
});
