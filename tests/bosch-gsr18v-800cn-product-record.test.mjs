import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "bosch-gsr18v-800cn";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Bosch GSR18V-800CN record preserves exact-model support evidence without claiming longevity", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Bosch");
  assert.equal(product.model, "GSR18V-800CN");
  assert.equal(product.sku, "06019K6010");
  assert.equal(product.category, "drill-drivers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-09-14");

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.boschtools.com/us/en/products/gsr18v-800cn-06019K6010",
    "https://ocsmedia.boschtools.com/binary/manualsmedia/o256028v2_2610070413_GSR18V800C_202308.pdf",
    "https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-800cn-3601JK6010",
    "https://www.boschtools.com/us/en/service/product-warranty",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);
  assert.ok(
    product.sources.every((source) => source.source_type !== "owner-report"),
    "no owner report should be attributed until exact-model duration is independently verified",
  );

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /GSR18V-800CN.*bare tool.*565.*all-metal chuck/i);
  assert.match(fields.warranty.display_value, /5-year limited warranty.*June 1, 2023/i);
  assert.match(fields.repair_manual.display_value, /operating.*safety manual.*not an owner-repair manual/i);
  assert.match(fields.parts_availability.display_value, /exact tool number 3601JK6010.*parts catalog/i);
  assert.match(fields.serviceability.display_value, /Bosch.*authorized service/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);

  assert.equal(product.affiliate_links.length, 1);
  const destination = new URL(product.affiliate_links[0].url);
  assert.equal(destination.hostname, "www.amazon.com");
  assert.equal(destination.pathname, "/dp/B0CRMB2TPF");
  assert.equal(destination.searchParams.get("tag"), "everlastin08f-20");
  assert.equal(product.affiliate_links[0].exact_model, true);
  assert.equal(product.affiliate_links[0].verified_date, "2026-09-14");
});
