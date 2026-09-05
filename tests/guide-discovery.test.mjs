import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

const restoredGuideSlugs = [
  "best-cast-iron-skillets-that-last-forever",
  "best-estwing-hammers-that-last-a-lifetime",
  "best-faucet-brands-that-actually-last",
  "best-kitchen-knives-that-last-a-lifetime",
  "best-safety-razors-that-last-a-lifetime",
];

test("the guide hub is an indexable discovery page for only restored guides", async () => {
  const hub = await text("src/app/blog/page.tsx");

  assert.match(hub, /title: "Durable Product Guides"/);
  assert.match(hub, /canonical: "https:\/\/everlasting-goods\.com\/blog"/);
  assert.match(hub, /robots: \{ index: true, follow: true \}/);
  assert.match(hub, /articleImageEvidence/);
  assert.match(hub, /Image/);
  assert.match(hub, /text-only/);
  assert.doesNotMatch(hub, /amazon\.com|amazonLink|amazonSearchLink/);

  for (const slug of restoredGuideSlugs) {
    assert.ok(hub.includes(slug), `guide hub must link ${slug}`);
  }
});

test("the homepage and sitemap expose the restored-guide hub without replacing the database focus", async () => {
  const [home, sitemap] = await Promise.all([
    text("src/app/page.tsx"),
    text("src/app/sitemap.ts"),
  ]);

  assert.match(home, /generated\/database\.json/);
  assert.match(home, /href="\/blog"/);
  assert.match(home, /Evidence-reviewed guides/);
  assert.match(sitemap, /\$\{baseUrl\}\/blog/);
});
