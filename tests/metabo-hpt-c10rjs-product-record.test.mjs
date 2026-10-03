import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "metabo-hpt-c10rjs";
const productUrl = "https://metabo-hpt.com/products/product/c10rjs-10-jobsite-table-saw-w-fold-roll-stand-metabo-hpt";
const manualUrl = "https://www.metabo-hpt.com/docs/default-source/product-owners-manuals/c10rj(s)-instruction-manual-071320.pdf?sfvrsn=4a65d267_1";
const partsListUrl = "https://www.metabo-hpt.com/docs/default-source/product-parts-lists/c10rjs_e3_bd.pdf?sfvrsn=5c64e2db_1";
const partsUrl = "https://www.metabo-hpt.com/support/parts";
const serviceUrl = "https://www.metabo-hpt.com/support/tool-repair-service";
const warrantyUrl = "https://www.metabo-hpt.com/support/warranty-information/metabo-hpt-tool-warranty";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Metabo HPT C10RJS record preserves package, parts, and repair boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Metabo HPT");
  assert.equal(product.model, "C10RJS");
  assert.equal(product.sku, "C10RJS");
  assert.equal(product.category, "table-saws");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-03");
  assert.match(product.variant_notes, /C10RJS.*C10RJ\(S\).*C10RJSM.*717709027831.*C10RJ.*HiKOKI/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    manualUrl,
    partsListUrl,
    partsUrl,
    serviceUrl,
    warrantyUrl,
    "https://www.reddit.com/r/Tools/comments/1prvy6b/how_do_i_even_fix_this_there_isnt_even_a_parts/",
    "https://www.amazon.com/dp/B086YHDYPW",
    "https://www.acmetools.com/metabo-hpt-10in-jobsite-table-saw-with-fold-roll-stand-c10rjsm/717709027831.html",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /120V.*15A.*10-inch.*fold-and-roll stand.*35-inch/i);
  assert.match(fields.parts_availability.display_value, /partial.*exploded parts list.*switch.*motor.*carbon brushes.*orderability remains unverified/i);
  assert.match(fields.repair_manual.display_value, /owner's manual.*maintenance.*adjustments.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /shop-serviceable.*owner cleaning.*fastener.*guard.*authorized repair/i);
  assert.match(fields.warranty.display_value, /two-year/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /owner report.*no ownership duration.*expected service life.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B086YHDYPW?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-03",
  }]);
});
