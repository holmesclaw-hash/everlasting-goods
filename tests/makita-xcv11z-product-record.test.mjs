import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-xcv11z";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita XCV11Z record separates owner maintenance from internal repair and preserves conflicting owner evidence", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "XCV11Z");
  assert.equal(product.sku, "XCV11Z");
  assert.equal(product.category, "dust-extractors");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-09-24");
  assert.match(product.variant_notes, /tool-only.*battery.*charger.*XCV11T.*not transferred/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.makitatools.com/products/details/XCV11Z",
    "https://cdn.makitatools.com/apps/cms/doc/prod/XCV/db17dbf5-e6dc-42f4-bed4-ee2ed457e129_XCV11_IM_885666A942_C6977.pdf",
    "https://cdn.makitatools.com/apps/cms/doc/prod/XCV/45b60f26-d035-407f-959f-112510220571_XCV11_PB_Breakdown_XCV11Z_01-19.pdf",
    "https://www.makitatools.com/service/warranty",
    "https://www.makitatools.com/service/service-centers",
    "https://www.reddit.com/r/Makita/comments/1jhmkwv/bought_the_xcv11z_wetdry_vac_returned_it_less/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /18V.*brushless.*2-gallon.*wet\/dry.*tool-only/i);
  assert.match(fields.parts_availability.display_value, /partial.*parts breakdown.*part numbers.*orderability.*not verified/i);
  assert.match(fields.repair_manual.display_value, /operating.*maintenance.*not.*owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /owner.*tank.*filter.*internal repair.*authorized service/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /six years.*returned.*poor suction.*anecdotal.*recommendation/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B07M8JTDNS?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-24",
  }]);
});
