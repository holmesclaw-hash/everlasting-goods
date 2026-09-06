import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("Delta Essa research stays preserved while the image-blocked route remains quarantined", async () => {
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
  assert.doesNotMatch(sitemap, /articles\/best-faucet-brands-that-actually-last/);
});

test("image-blocked Delta Essa route is not configured as a restored commercial guide", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  assert.doesNotMatch(page, /FAUCET_GUIDE_SLUG/);
  assert.doesNotMatch(page, /asin: "B012I44K8S"/);
  assert.doesNotMatch(page, /View exact Delta Essa 9113-AR-DST on Amazon/);
  assert.match(page, /robots: \{ index: false, follow: true \}/);
  assert.match(page, /Legacy guide under evidence review/);
});

test("image-blocked Delta Essa guide is absent from discovery and policy requires a photo", async () => {
  const page = await text("src/app/articles/[slug]/page.tsx");
  const hub = await text("src/app/blog/page.tsx");
  const policy = await text("ops/editorial-photo-policy.md");

  assert.doesNotMatch(page, /visualMode: "text-only"/);
  assert.doesNotMatch(hub, /best-faucet-brands-that-actually-last/);
  assert.doesNotMatch(hub, /Text-first evidence review/);
  assert.match(policy, /block publication/i);
  assert.doesNotMatch(policy, /must not block publication/i);
  assert.match(policy, /Never scrape retailer or Amazon imagery/i);
});
