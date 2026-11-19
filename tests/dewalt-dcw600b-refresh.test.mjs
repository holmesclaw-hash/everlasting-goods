import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dcw600b";
const productUrl = "https://www.dewalt.com/en-us/product/dcw600b/20v-max-xr-brushless-cordless-compact-router-tool-only";
const partsUrl = "https://www.toolservicenet.com/en/Dewalt/WOODWORKING/ROUTERS/p/DCW600B-CA_1";
const manualUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Instruction_Manual/EN/NA115327_DCW600_JUL22.pdf";
const diagramUrl = "https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Exploded_Diagram/EN/EA025823.gif";
const ownerUrl = "https://yo.asmbly.org/t/compact-router-broken-replacement/15448";
const amazonUrl = "https://www.amazon.com/dp/B07KSRTDML";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the DEWALT DCW600B record exposes current Type 1 service evidence without overstating durability", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-11-19");

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [productUrl, partsUrl, manualUrl, diagramUrl, ownerUrl, amazonUrl]) {
    assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);
  }

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /DCW600B.*20V MAX.*XR.*brushless.*tool only/i);
  assert.match(fields.parts_availability.display_value, /Partial.*Type 1.*46.*in-stock.*2026-11-19.*not guaranteed/is);
  assert.equal(fields.parts_availability.verified_date, "2026-11-19");
  assert.equal(fields.parts_availability.source_url, partsUrl);
  assert.match(fields.repair_manual.display_value, /operating.*maintenance.*not.*component-level repair manual/is);
  assert.equal(fields.repair_manual.source_url, manualUrl);
  assert.match(fields.serviceability.display_value, /owner.*bit.*collet.*base.*internal.*authorized service/is);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.equal(fields.street_price.verified_date, "2026-11-19");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.repairability.verified_date, "2026-11-19");

  assert.match(product.recommendation_reasoning, /Type 1.*46.*shared-shop.*more than five years.*seized spindle.*anecdote.*remain unverified/is);
  assert.deepEqual(product.warranty, {
    warranty_length: "3-year limited warranty; 1 year free service; 90-day satisfaction guarantee",
    warranty_coverage: "The exact DCW600B product page publishes DEWALT's 3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee program.",
    warranty_exclusions: "Eligibility, exclusions, claim requirements, and current terms must be confirmed with DEWALT for the purchaser and use case.",
    source_url: productUrl,
    verified_date: "2026-11-19",
  });

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B07KSRTDML?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-11-19",
  }]);
});
