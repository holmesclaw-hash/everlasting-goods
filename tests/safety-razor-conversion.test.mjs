import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("restored safety-razor guide discloses before its verified exact-model destination", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  const disclosureIndex = page.indexOf("<AffiliateDisclosure");
  const destinationIndex = page.indexOf('amazonLink("B002A8JO1Q")');

  assert.match(page, /import AffiliateDisclosure from "@\/components\/AffiliateDisclosure"/);
  assert.ok(disclosureIndex >= 0, "restored guide must render the affiliate disclosure");
  assert.ok(destinationIndex > disclosureIndex, "disclosure must precede the exact-model destination");
  assert.match(page, /View exact MERKUR 34C on Amazon/);
  assert.match(page, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(page, /Price and availability are shown only by the merchant/);
});

test("restored safety-razor guide separates manufacturer facts from dated owner reports", async () => {
  const content = await text("src/content/safety-razors.mjs");
  const data = await text("src/lib/data.ts");

  assert.match(content, /Long-Term Owner Evidence and Its Limits/);
  assert.match(content, /Started wet shaving 8 years ago with a 34C and still revisit it frequently/);
  assert.match(content, /Been my daily driver for 5 years/);
  assert.match(content, /individual owner reports, not controlled durability testing/);
  assert.match(content, /original-34c-thursdays\.656755/);
  assert.match(content, /merkur-34c\.612135/);
  assert.match(data, /content:\s*safetyRazorContent,\s*updatedAt: "2026-08-29"/);
});
