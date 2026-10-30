import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function source(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("homepage featured records expose disclosed, measurable exact-model destinations", async () => {
  const [home, card] = await Promise.all([
    source("src/app/page.tsx"),
    source("src/components/DatabaseProductCard.tsx"),
  ]);
  const disclosureIndex = home.indexOf("<AffiliateDisclosure");
  const featuredCardsIndex = home.indexOf("<DatabaseProductCard");

  assert.match(home, /import AffiliateDisclosure from "@\/components\/AffiliateDisclosure"/);
  assert.ok(disclosureIndex >= 0, "homepage must render the affiliate disclosure");
  assert.ok(featuredCardsIndex > disclosureIndex, "disclosure must precede featured affiliate cards");
  assert.match(home, /affiliatePlacement="home-featured"/);
  assert.match(card, /data-affiliate-placement=\{affiliatePlacement\}/);
  assert.match(card, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(card, /View exact model on Amazon/);
  assert.match(card, /Price and availability are shown only by the merchant/);
});
