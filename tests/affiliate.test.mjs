import assert from "node:assert/strict";
import test from "node:test";

import {
  AFFILIATE_TAG,
  normalizeArticleAffiliateLinks,
  normalizeAmazonAffiliateUrl,
} from "../src/lib/affiliate.mjs";

test("uses the approved Amazon Associates tag", () => {
  assert.equal(AFFILIATE_TAG, "everlastin08f-20");
});

test("preserves an exact product destination while replacing a stale tag", () => {
  const input = "https://www.amazon.com/dp/B00006JSUA?tag=everlastin09f-20&th=1";
  const actual = normalizeAmazonAffiliateUrl(input);

  assert.equal(
    actual,
    "https://www.amazon.com/dp/B00006JSUA?tag=everlastin08f-20&th=1"
  );
});

test("preserves an Amazon search query while adding the approved tag", () => {
  const input = "https://www.amazon.com/s?k=cast+iron+skillet";
  const actual = normalizeAmazonAffiliateUrl(input);

  assert.equal(
    actual,
    "https://www.amazon.com/s?k=cast+iron+skillet&tag=everlastin08f-20"
  );
});

test("does not rewrite non-Amazon destinations", () => {
  const input = "https://www.darntough.com/products/hiking-socks";
  assert.equal(normalizeAmazonAffiliateUrl(input), input);
});

test("does not treat lookalike hostnames as Amazon", () => {
  const input = "https://www.amazon.com.example.test/dp/B00006JSUA";
  assert.equal(normalizeAmazonAffiliateUrl(input), input);
});

test("qualifies article affiliate links as sponsored and preserves the product destination", () => {
  const input = `<a class="cta" href='https://www.amazon.com/dp/B00006JSUA?tag=everlastin09f-20' target='_blank' rel='nofollow noopener'>Check price</a>`;

  assert.equal(
    normalizeArticleAffiliateLinks(input),
    `<a class="cta" href='https://www.amazon.com/dp/B00006JSUA?tag=everlastin08f-20' target='_blank' rel='sponsored nofollow noopener noreferrer'>Check price</a>`
  );
});
