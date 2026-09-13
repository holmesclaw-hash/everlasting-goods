import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "grizzly-g0771z";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Grizzly G0771Z record preserves exact-model construction, repair, owner, and destination evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0771Z");
  assert.equal(product.sku, "G0771Z");
  assert.equal(product.category, "table-saws");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.last_reviewed_date, "2026-09-12");

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.grizzly.com/products/grizzly-10-2-hp-120v-hybrid-table-saw-w-t-shaped-fence/g0771z",
    "https://cdn0.grizzly.com/manuals/g0771z_m.pdf",
    "https://cdn0.grizzly.com/partslists/g0771z_pl.pdf",
    "https://www.grizzly.com/products/g0771z/parts",
    "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty",
    "https://www.reddit.com/r/woodworking/comments/16qco9f/table_saw_lifting_mechanism_problems/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);
  assert.ok(
    !sourceUrls.has(
      "https://www.reddit.com/r/woodworking/comments/10ub8xc/dewalt_jobsite_or_grizzly_hybrid_table_saw/",
    ),
    "the G0962A40 owner follow-up must not be attributed to the G0771Z",
  );

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0771Z.*10-inch.*2 HP.*120V\/240V.*cast-iron/i);
  assert.match(fields.warranty.display_value, /1-year limited warranty/i);
  assert.match(fields.repair_manual.display_value, /model-specific.*adjustment.*parts/i);
  assert.match(fields.parts_availability.display_value, /exact-model.*revision-specific/i);
  assert.match(fields.serviceability.display_value, /insert adjustment.*replacement parts/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 1);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.image_url, null);

  assert.equal(product.affiliate_links.length, 1);
  const destination = new URL(product.affiliate_links[0].url);
  assert.equal(destination.hostname, "www.amazon.com");
  assert.equal(destination.pathname, "/dp/B07K7SZPBR");
  assert.equal(destination.searchParams.get("tag"), "everlastin08f-20");
  assert.equal(product.affiliate_links[0].exact_model, true);
  assert.equal(product.affiliate_links[0].verified_date, "2026-09-12");
});
