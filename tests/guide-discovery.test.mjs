import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

const restoredGuideSlugs = [
  "best-cast-iron-skillets-that-last-forever",
  "best-estwing-hammers-that-last-a-lifetime",
  "best-kitchen-knives-that-last-a-lifetime",
  "best-safety-razors-that-last-a-lifetime",
];

test("the guide hub is an indexable discovery page for only restored guides", async () => {
  const [hub, guideRegistry] = await Promise.all([
    text("src/app/blog/page.tsx"),
    text("src/content/restored-guides.ts"),
  ]);

  assert.match(hub, /title: "Durable Product Guides"/);
  assert.match(hub, /canonical: "https:\/\/everlasting-goods\.com\/blog"/);
  assert.match(hub, /robots: \{ index: true, follow: true \}/);
  assert.match(hub, /restoredGuides/);
  assert.match(guideRegistry, /articleImageEvidence/);
  assert.match(guideRegistry, /\.filter\(\(guide\) => articleImageEvidence\[guide\.slug\]\)/);
  assert.match(hub, /Image/);
  assert.doesNotMatch(hub, /text-only/);
  assert.doesNotMatch(hub, /best-faucet-brands-that-actually-last/);

  for (const slug of restoredGuideSlugs) {
    assert.ok(guideRegistry.includes(slug), `guide registry must include ${slug}`);
  }
});

test("the guide hub exposes disclosed, measured exact-model destinations from the restored-guide registry", async () => {
  const [hub, guideRegistry] = await Promise.all([
    text("src/app/blog/page.tsx"),
    text("src/content/restored-guides.ts"),
  ]);
  const disclosureIndex = hub.indexOf("<AffiliateDisclosure");
  const guideCardsIndex = hub.indexOf("restoredGuides.map");

  assert.match(hub, /import AffiliateDisclosure from "@\/components\/AffiliateDisclosure"/);
  assert.match(hub, /import \{ amazonLink \} from "@\/lib\/affiliate\.mjs"/);
  assert.ok(disclosureIndex >= 0, "guide hub must render the affiliate disclosure");
  assert.ok(guideCardsIndex > disclosureIndex, "disclosure must precede guide-card affiliate destinations");
  assert.match(hub, /href=\{amazonLink\(guide\.asin\)\}/);
  assert.match(hub, /data-affiliate-placement="guide-hub-card"/);
  assert.match(hub, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(hub, /\{guide\.destinationLabel\}/);
  assert.match(hub, /Destination verified \{guide\.destinationVerifiedAt\}/);
  assert.match(hub, /Price and availability are shown only by the merchant/);

  assert.equal(guideRegistry.match(/asin: "B[A-Z0-9]{9}"/g)?.length, 5);
  assert.equal(guideRegistry.match(/destinationVerifiedAt: "2026-10-29"/g)?.length, 5);
  assert.equal(guideRegistry.match(/destinationLabel:/g)?.length, 5);
});

test("the homepage and sitemap expose the restored-guide hub without replacing the database focus", async () => {
  const [home, sitemap] = await Promise.all([
    text("src/app/page.tsx"),
    text("src/app/sitemap.ts"),
  ]);

  assert.match(home, /generated\/database\.json/);
  assert.match(home, /restoredGuideCount/);
  assert.match(home, /\{restoredGuideCount\} restored guides are ready to read/);
  assert.doesNotMatch(home, /Three restored guides are ready to read/);
  assert.match(home, /href="\/blog"/);
  assert.match(home, /Evidence-reviewed guides/);
  assert.match(sitemap, /\$\{baseUrl\}\/blog/);
});
