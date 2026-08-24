import assert from "node:assert/strict";
import test from "node:test";

import { newsletterSignupUrl } from "../src/lib/newsletter.mjs";

test("accepts a configured HTTPS newsletter provider endpoint", () => {
  assert.equal(
    newsletterSignupUrl("https://newsletter.example.com/forms/everlasting"),
    "https://newsletter.example.com/forms/everlasting"
  );
});

test("does not render a collection form without a safe provider endpoint", () => {
  assert.equal(newsletterSignupUrl(undefined), null);
  assert.equal(newsletterSignupUrl(""), null);
  assert.equal(newsletterSignupUrl("http://newsletter.example.com/form"), null);
  assert.equal(newsletterSignupUrl("javascript:alert(1)"), null);
});
