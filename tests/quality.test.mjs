import assert from "node:assert/strict";
import test from "node:test";

import { findEditorialQualityIssues } from "../src/lib/quality.mjs";

test("rejects monetization and trust regressions", () => {
  const text = [
    "tag=everlastin09f-20",
    "We tested this product for six months.",
    "After testing several options, I picked this one.",
    "Join 10,000+ readers.",
    "Byline should be a plausible human name.",
    "BIFL means Big In France.",
    "const price = product.price;",
    "const rating = product.rating;",
    `"@type": "ProductReview"`,
    "Our expert guide to durable products.",
    "Every product is tested, vetted, and built to last.",
  ].join("\n");

  assert.deepEqual(findEditorialQualityIssues(text), [
    "stale Amazon Associates tag",
    "unsupported hands-on testing claim",
    "unsupported hands-on testing claim",
    "unsupported audience-size claim",
    "fabricated author instruction",
    "corrupted BIFL definition",
    "unverified product price display",
    "unverified product rating display",
    "invalid ProductReview schema type",
    "unsupported expertise claim",
    "unsupported universal testing claim",
  ]);
});

test("accepts evidence-based editorial language", () => {
  const text = [
    "tag=everlastin08f-20",
    "We compared materials, warranties, and long-term owner reports.",
    "Byline must be exactly Everlasting Goods Editorial Team.",
    "BIFL means Buy It For Life.",
  ].join("\n");

  assert.deepEqual(findEditorialQualityIssues(text), []);
});
