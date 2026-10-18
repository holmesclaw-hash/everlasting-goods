import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("database record pages expose one measured exact-model destination early on mobile and in the desktop sidebar", async () => {
  const page = await text("src/app/database/[slug]/page.tsx");
  const mobileCtaIndex = page.indexOf('placement="database-record-mobile"');
  const evidenceFieldsIndex = page.indexOf(">Evidence fields</h2>");

  assert.match(page, /function DatabaseAffiliateDestination/);
  assert.match(page, /data-affiliate-placement=\{placement\}/);
  assert.ok(mobileCtaIndex >= 0, "record page must render the mobile exact-model destination");
  assert.ok(evidenceFieldsIndex > mobileCtaIndex, "mobile destination must precede the evidence fields");
  assert.match(page, /className="[^"]*lg:hidden[^"]*"/);
  assert.match(page, /placement="database-record-sidebar"/);
  assert.match(page, /className="[^"]*hidden[^"]*lg:block[^"]*"/);
});

test("the shared database-record destination keeps disclosure and merchant-only price language adjacent to the link", async () => {
  const page = await text("src/app/database/[slug]/page.tsx");
  const componentStart = page.indexOf("function DatabaseAffiliateDestination");
  const componentEnd = page.indexOf("export function generateStaticParams");
  const component = page.slice(componentStart, componentEnd);

  assert.ok(componentStart >= 0 && componentEnd > componentStart);
  assert.ok(component.indexOf("<AffiliateDisclosure />") < component.indexOf("<a"));
  assert.match(component, /rel="sponsored nofollow noopener noreferrer"/);
  assert.match(component, /View exact model on Amazon/);
  assert.match(component, /Price and availability are shown only by the merchant/);
});
