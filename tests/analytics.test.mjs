import assert from "node:assert/strict";
import test from "node:test";

import {
  affiliateClickEvent,
  classifyReferral,
  internalLinkClickEvent,
  isAmazonAffiliateUrl,
  referralVisitEvent,
  trackAffiliateClick,
  trackInternalLinkClick,
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

test("creates and dispatches a stable internal-link click event", () => {
  assert.deepEqual(
    internalLinkClickEvent(
      "/articles/best-estwing-hammers-that-last-a-lifetime",
      "Read evidence-reviewed guide →",
      "/database/estwing-b3-3lb",
      "database-record-evidence-guide"
    ),
    {
      eventName: "internal_link_click",
      parameters: {
        link_text: "Read evidence-reviewed guide →",
        link_placement: "database-record-evidence-guide",
        page_path: "/database/estwing-b3-3lb",
        target_path: "/articles/best-estwing-hammers-that-last-a-lifetime",
      },
    }
  );

  const calls = [];
  trackInternalLinkClick(
    (...args) => calls.push(args),
    "/articles/best-estwing-hammers-that-last-a-lifetime",
    "Read evidence-reviewed guide →",
    "/database/estwing-b3-3lb",
    "database-record-evidence-guide"
  );

  assert.deepEqual(calls, [[
    "event",
    "internal_link_click",
    {
      link_text: "Read evidence-reviewed guide →",
      link_placement: "database-record-evidence-guide",
      page_path: "/database/estwing-b3-3lb",
      target_path: "/articles/best-estwing-hammers-that-last-a-lifetime",
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
