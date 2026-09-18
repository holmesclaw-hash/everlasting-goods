import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "dewalt-dwe7491rs";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the DWE7491RS record distinguishes current type-specific support from an owner-repair manual", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-09-18");
  assert.match(product.variant_notes, /Types 10 and 11.*live.*Types 1, 2, and 3.*discontinued/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.dewalt.com/en-us/product/dwe7491rs/10-jobsite-table-saw-and-rolling-stand",
    "https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11",
    "https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QU/DWE7491RS/11/Instruction_Manual/EN/N531890_DWE7491rs.pdf",
    "https://www.dewalt.com/en-us/support/warranty",
    "https://www.reddit.com/r/Dewalt/comments/1ilj1dt/do_not_purchase_the_dwe7491_table_saw/",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.parts_availability.display_value, /type-specific.*ServiceNet.*Types 10 and 11.*live/i);
  assert.match(fields.repair_manual.display_value, /operating and maintenance manual.*not an owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /fence alignment.*dust cleanup.*height-adjustment screw/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(
    product.repairability.parts_url,
    "https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11",
  );
  assert.match(product.recommendation_reasoning, /close to seven years.*fence drift.*service life.*recommendation remain unverified/i);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00F2CGXGG?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-09-18",
  }]);
});
