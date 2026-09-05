import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("restored Delta Essa guide separates manufacturer facts, support, warranty, and owner reports", async () => {
  const content = await text("src/content/delta-essa-faucet.mjs");
  const data = await text("src/lib/data.ts");
  const sitemap = await text("src/app/sitemap.ts");

  assert.match(content, /We did not perform a hands-on or long-term test/);
  assert.match(content, /deltafaucet\.com\/kitchen\/product\/9113-AR-DST\.html/);
  assert.match(content, /media\.deltafaucet\.com\/PartsDiagram\/DPD-K-9113-DST%20Rev%20G\.pdf/);
  assert.match(content, /media\.deltafaucet\.com\/MandI\/106557%20Rev%20H\.pdf/);
  assert.match(content, /individual owner reports, not controlled lifespan data/i);
  assert.match(content, /RP73000/);
  assert.match(content, /RP80522/);
  assert.match(content, /original consumer purchaser owns the home/i);
  assert.match(content, /not transferable/i);
  assert.match(content, /leak/i);
  assert.match(data, /content:\s*deltaEssaFaucetContent,\s*updatedAt: "2026-09-05"/);
  assert.match(data, /article\.updatedAt \?\? CONTENT_LAST_REVIEWED/);
  assert.match(data, /slug: "best-faucet-brands-that-actually-last"[\s\S]*?image: "text-only:delta-essa-9113-ar-dst"/);
  assert.match(sitemap, /articles\/best-faucet-brands-that-actually-last/);
});

test("restored Delta Essa guide uses a disclosed exact-model Amazon destination without merchant claims", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  const disclosureIndex = page.indexOf("<AffiliateDisclosure");
  const destinationIndex = page.indexOf("amazonLink(config.asin)");

  assert.match(page, /FAUCET_GUIDE_SLUG/);
  assert.match(page, /asin: "B012I44K8S"/);
  assert.match(page, /View exact Delta Essa 9113-AR-DST on Amazon/);
  assert.ok(disclosureIndex >= 0, "restored guide must render the affiliate disclosure");
  assert.ok(destinationIndex > disclosureIndex, "disclosure must precede the exact-model destination");
  assert.match(page, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(page, /Price and availability are shown only by the merchant/);
});

test("restored guide supports an explicit text-first hero when product imagery lacks reusable rights", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  const hub = await text("src/app/blog/page.tsx");
  const policy = await text("ops/editorial-photo-policy.md");

  assert.match(page, /visualMode: "text-only"/);
  assert.match(page, /config\.visualMode === "image"/);
  assert.match(page, /No product image is shown/);
  assert.match(hub, /guide\.visualMode === "image"/);
  assert.match(hub, /Text-first evidence review/);
  assert.match(policy, /text-first/i);
  assert.match(policy, /must not block publication/i);
  assert.match(policy, /Never scrape retailer or Amazon imagery/i);
});
