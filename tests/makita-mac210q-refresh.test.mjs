import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-mac210q";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/MAC/79423a15-98e1-4185-b52b-d513cfbf30ec_MAC100Q_IM.pdf";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita MAC210Q record separates owner maintenance from repair support", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-09-21");
  assert.match(product.variant_notes, /120V.*2-gallon.*one.*coupler/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.makitatools.com/products/details/MAC210Q",
    manualUrl,
    "https://cdn.makitatools.com/apps/cms/doc/prod/MAC/e873ff0c-05fb-4bd9-91b6-d0a120917ccb_MAC210Q_PB_Breakdown_MAC210Q_05-20.pdf",
    "https://www.makita.ca/data/upload/parts_breakdown/MAC210Q%20-%20JUN2025.pdf",
    "https://www.makitatools.com/service/warranty",
    "https://www.reddit.com/r/Makita/comments/17deniq/choosing_between_compressors",
    "https://www.amazon.com/dp/B08GYFBQV1",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.parts_availability.display_value, /partial.*parts breakdown.*current orderability.*not verified/i);
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /tank draining.*air-filter cleaning.*inspection.*repairs.*authorized service/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, "https://www.makita.ca/data/upload/parts_breakdown/MAC210Q%20-%20JUN2025.pdf");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.match(product.recommendation_reasoning, /3,500 framing nails.*renewed.*about one year.*expected service life.*unverified/i);

  assert.deepEqual(product.warranty, {
    warranty_length: "1-year limited warranty.",
    warranty_coverage: "Defects in workmanship and materials for Makita products; Makita may repair or replace after inspection.",
    warranty_exclusions: "Repairs made or attempted by others, normal wear and tear, abuse, misuse, improper maintenance or operation, and alterations are excluded; current Makita terms apply.",
    source_url: "https://www.makitatools.com/service/warranty",
    verified_date: "2026-09-21",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B084GYHQFY?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-21",
  }]);
});
