import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0899";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Grizzly G0899 record preserves exact-model durability, repair, owner, and destination evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0899");
  assert.equal(product.sku, "G0899");
  assert.equal(product.category, "table-saws");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.last_reviewed_date, "2026-09-11");

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.grizzly.com/products/grizzly-10-2-hp-115v-230v-cabinet-saw/g0899",
    "https://cdn0.grizzly.com/manuals/g0899_m.pdf",
    "https://www.grizzly.com/products/g0899/parts",
    "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty",
    "https://www.reddit.com/r/woodworking/comments/rdhckn/awful_experience_with_grizzly/",
    "https://www.reddit.com/r/woodworking/comments/1w68e2p/tablesaw_recommendations/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0899.*10-inch.*2 HP.*115V\/230V/i);
  assert.match(fields.warranty.display_value, /1-year limited warranty/i);
  assert.match(fields.repair_manual.display_value, /maintenance.*service.*parts/i);
  assert.match(fields.parts_availability.display_value, /exact-model.*parts/i);
  assert.match(fields.serviceability.display_value, /alignment.*belt replacement/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 1);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.image_url, null);

  assert.equal(product.affiliate_links.length, 1);
  const destination = new URL(product.affiliate_links[0].url);
  assert.equal(destination.hostname, "www.amazon.com");
  assert.equal(destination.pathname, "/dp/B08B6G2L6P");
  assert.equal(destination.searchParams.get("tag"), "everlastin08f-20");
  assert.equal(product.affiliate_links[0].exact_model, true);
  assert.equal(product.affiliate_links[0].verified_date, "2026-09-11");
});
