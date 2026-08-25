import assert from "node:assert/strict";
import test from "node:test";

import {
  affiliateClickEvent,
  classifyReferral,
  isAmazonAffiliateUrl,
  referralVisitEvent,
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

test("classifies LLM, organic, direct, and other referrals without guessing", () => {
  assert.equal(classifyReferral("https://chatgpt.com/c/abc"), "llm");
  assert.equal(classifyReferral("https://perplexity.ai/search/test"), "llm");
  assert.equal(classifyReferral("https://www.google.com/search?q=repairability"), "organic");
  assert.equal(classifyReferral(""), "direct");
  assert.equal(classifyReferral("https://example.com/link"), "referral");
});

test("builds a referral visit event with source class and host", () => {
  assert.deepEqual(referralVisitEvent("https://claude.ai/chat/123", "/database/test"), {
    eventName: "referral_visit",
    parameters: {
      referral_class: "llm",
      referral_host: "claude.ai",
      page_path: "/database/test",
    },
  });
});
