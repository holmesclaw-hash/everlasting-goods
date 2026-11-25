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

test("the DWE7491RS record preserves current Type 20 support, revision boundaries, and qualified-repair limits", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.last_reviewed_date, "2026-11-25");
  assert.match(product.variant_notes, /Type 20.*current.*Types 10 and 11.*live.*Types 1, 2, and 3.*discontinued/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.dewalt.com/en-us/product/dwe7491rs/10-jobsite-table-saw-and-rolling-stand",
    "https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_20",
    "https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/20/Instruction_Manual/EN/NA810782_DWE7491_NA.318547.pdf",
    "https://www.dewalt.com/en-us/support/warranty",
    "https://www.reddit.com/r/Dewalt/comments/1ilj1dt/do_not_purchase_the_dwe7491_table_saw/",
    "https://www.amazon.com/dp/B00F2CGXGG",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /15 A.*10-inch.*4,800 RPM.*32-1\/2.*3-1\/8.*2-1\/4/i);
  assert.match(fields.parts_availability.display_value, /Type 20.*208.*206 purchasable.*armature.*field.*switch.*fence.*rail.*12.*zero stock.*in-stock status/i);
  assert.equal(fields.parts_availability.verified_date, "2026-11-25");
  assert.match(fields.repair_manual.display_value, /Type 20.*operating and maintenance manual.*not an owner-repair manual/i);
  assert.match(fields.serviceability.display_value, /fence.*rail lock.*dust.*height-adjustment screw.*qualified service/i);
  assert.equal(fields.serviceability.evidence_tier, "T2");
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.match(fields.warranty.display_value, /3-year.*1-year free service.*90-day.*original end-user.*authorized.?seller/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(
    product.repairability.parts_url,
    "https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_20",
  );
  assert.match(product.recommendation_reasoning, /close to seven years.*fence drift.*not representative.*service life.*recommendation remain unverified/i);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B00F2CGXGG?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-11-25",
  }]);
});
