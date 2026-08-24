import assert from "node:assert/strict";
import test from "node:test";

import {
  affiliateClickEvent,
  isAmazonAffiliateUrl,
  trackAffiliateClick,
} from "../src/lib/analytics.mjs";

test("recognizes Amazon affiliate destinations without accepting lookalikes", () => {
  assert.equal(
    isAmazonAffiliateUrl("https://www.amazon.com/dp/B00006JSUA?tag=everlastin08f-20"),
    true
  );
  assert.equal(isAmazonAffiliateUrl("https://amazon.com.example.test/dp/item"), false);
  assert.equal(isAmazonAffiliateUrl("https://example.com/product"), false);
});

test("creates a consistent GA4 affiliate click event", () => {
  assert.deepEqual(
    affiliateClickEvent(
      "https://www.amazon.com/dp/B00006JSUA?tag=everlastin08f-20",
      "Check Price on Amazon",
      "/products"
    ),
    {
      eventName: "affiliate_click",
      parameters: {
        affiliate_host: "www.amazon.com",
        affiliate_path: "/dp/B00006JSUA",
        link_text: "Check Price on Amazon",
        page_path: "/products",
      },
    }
  );
});

test("dispatches the affiliate event through the supplied GA4 function", () => {
  const calls = [];
  const gtag = (...args) => calls.push(args);

  trackAffiliateClick(
    gtag,
    "https://www.amazon.com/dp/B00006JSUA?tag=everlastin08f-20",
    "Check Price on Amazon",
    "/products"
  );

  assert.deepEqual(calls, [[
    "event",
    "affiliate_click",
    {
      affiliate_host: "www.amazon.com",
      affiliate_path: "/dp/B00006JSUA",
      link_text: "Check Price on Amazon",
      page_path: "/products",
    },
  ]]);
});
