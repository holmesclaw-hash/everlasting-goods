import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-rf1101";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita RF1101 record limits repairability and longevity claims to exact-model evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "RF1101");
  assert.equal(product.sku, "RF1101");
  assert.equal(product.category, "routers");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-09-23");
  assert.match(product.variant_notes, /fixed-base package.*RF1101KIT2.*plunge base/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.makitatools.com/products/details/RF1101",
    "https://cdn.makitatools.com/apps/cms/doc/prod/RF1/71c406df-49e6-4f04-8ffa-2fe5cf660011_RF1101_IM.pdf",
    "https://cdn.makitatools.com/apps/cms/doc/prod/RF1/d592ab2b-3110-437b-b4b1-963239e0f331_RF1101_PB.pdf",
    "https://www.makitatools.com/service/warranty",
    "https://www.makitatools.com/service/service-centers",
    "https://mimf.com/phpbb/viewtopic.php?t=2845",
    "https://www.lumberjocks.com/threads/makita-router-question-rf1101-varible-speed.42433/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /corded.*fixed-base.*2-1\/4.*router/i);
  assert.match(fields.parts_availability.display_value, /partial.*parts breakdown.*orderability.*not verified/i);
  assert.match(fields.repair_manual.display_value, /operating.*carbon-brush replacement.*not.*full owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /user-serviceable.*carbon-brush replacement.*authorized service/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /several years.*seven years.*anecdotes.*recommendation/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00004YN3N?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-23",
  }]);
});
