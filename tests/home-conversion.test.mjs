import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

import { selectImageVerifiedProducts } from "../src/lib/database-utils.mjs";

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
  assert.match(card, /data-affiliate-product=\{product\.slug\}/);
  assert.match(card, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(card, /View \{product\.brand\} \{product\.model\} on Amazon/);
  assert.match(card, /Price and availability are shown only by the merchant/);
});

test("homepage featured records prioritize only products with complete exact-photo provenance", async () => {
  const home = await source("src/app/page.tsx");
  const database = JSON.parse(await source("src/generated/database.json"));
  const featured = selectImageVerifiedProducts(database.products, 6);

  assert.match(home, /selectImageVerifiedProducts\(database\.products, 6\)/);
  assert.match(home, /Image-verified product records/);
  assert.match(home, /complete exact-model photo provenance/);

  assert.equal(featured.length, 4);
  assert.deepEqual(featured.map((product) => product.slug), [
    "victorinox-fibrox-5-2063-20",
    "estwing-b3-3lb",
    "merkur-34c",
    "lodge-l10sk3",
  ]);

  for (const product of featured) {
    assert.ok(product.image_url);
    assert.ok(product.image_source_url);
    assert.ok(product.image_license_basis);
    assert.ok(product.image_license_url);
    assert.ok(product.image_attribution);
    assert.ok(product.image_alt);
  }
});

test("homepage measures its primary research-path choices", async () => {
  const home = await source("src/app/page.tsx");

  assert.match(home, /data-internal-placement="home-hero-database"/);
  assert.match(home, /data-internal-placement="home-hero-methodology"/);
  assert.match(home, /data-internal-placement="home-all-records"/);
  assert.match(home, /data-internal-placement="home-category-comparison"/);
  assert.match(home, /data-internal-placement="home-guide-hub"/);
});
