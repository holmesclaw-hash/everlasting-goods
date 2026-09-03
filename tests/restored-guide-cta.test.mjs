import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

import { affiliateClickEvent } from "../src/lib/analytics.mjs";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("affiliate click events identify the CTA placement", () => {
  assert.deepEqual(
    affiliateClickEvent(
      "https://www.amazon.com/dp/B008M5U1C2?tag=everlastin08f-20",
      "View exact Victorinox Fibrox 8-inch on Amazon",
      "/articles/best-kitchen-knives-that-last-a-lifetime",
      "decision-end"
    ),
    {
      eventName: "affiliate_click",
      parameters: {
        affiliate_host: "www.amazon.com",
        affiliate_path: "/dp/B008M5U1C2",
        link_text: "View exact Victorinox Fibrox 8-inch on Amazon",
        page_path: "/articles/best-kitchen-knives-that-last-a-lifetime",
        link_placement: "decision-end",
      },
    }
  );
});

test("restored guides offer a disclosed, measured exact-model destination before and after the evidence review", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");

  assert.match(page, /function ExactModelDestination/);
  assert.match(page, /data-affiliate-placement=\{placement\}/);
  assert.match(page, /placement="decision-start"/);
  assert.match(page, /placement="decision-end"/);
  assert.match(page, /asin: "B002A8JO1Q"/);
  assert.match(page, /asin: "B00006JSUB"/);
  assert.match(page, /asin: "B008M5U1C2"/);
  assert.match(page, /amazonLink\(config\.asin\)/);

  const disclosureUses = page.match(/<AffiliateDisclosure \/>/g) ?? [];
  assert.equal(disclosureUses.length, 1, "the shared CTA component should own the nearby disclosure");

  const ctaUses = page.match(/<ExactModelDestination/g) ?? [];
  assert.equal(ctaUses.length, 2, "each restored guide should render start and end CTAs");
});

test("the delegated click tracker sends the CTA placement", async () => {
  const tracker = await text("src/components/AffiliateClickTracker.tsx");
  assert.match(tracker, /anchor\.dataset\.affiliatePlacement/);
});
