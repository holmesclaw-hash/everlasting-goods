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

test("the Grizzly G0899 record preserves the current revision, parts snapshot, owner limits, and exact destination", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Grizzly");
  assert.equal(product.model, "G0899");
  assert.equal(product.sku, "G0899");
  assert.equal(product.category, "table-saws");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-11-26");
  assert.match(product.variant_notes, /V4\.02\.26.*manufactured since 02\/26.*manufacture date.*service parts/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    "https://www.grizzly.com/products/grizzly-10-2-hp-115v-230v-cabinet-saw/g0899",
    "https://cdn0.grizzly.com/manuals/g0899_m.pdf",
    "https://www.grizzly.com/products/g0899/parts",
    "https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty",
    "https://support.grizzly.com/hc/en-us/articles/4405505042839-How-can-I-purchase-parts",
    "https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item",
    "https://www.reddit.com/r/woodworking/comments/rdhckn/awful_experience_with_grizzly/",
    "https://www.reddit.com/r/woodworking/comments/1w68e2p/tablesaw_recommendations/",
    "https://www.reddit.com/r/woodworking/comments/1qm4thj/major_upgrade_for_me_today_new_cabinet_saw/o1n8a0p/",
    "https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0899&format=json",
    "https://www.amazon.com/dp/B08B6G2L6P",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /G0899.*2 HP.*115V\/230V.*16 A\/8 A.*4,000 RPM.*31-1\/2.*3-1\/8.*2-1\/8/i);
  assert.match(fields.parts_availability.display_value, /316.*180.*add-to-cart.*134.*replacement.*2.*without.*replacement.*motor.*arbor.*switch.*fence.*trunnion/i);
  assert.equal(fields.parts_availability.verified_date, "2026-11-26");
  assert.match(fields.repair_manual.display_value, /V4\.02\.26.*owner-service manual.*maintenance.*alignment.*belt replacement.*wiring.*parts/i);
  assert.match(fields.serviceability.display_value, /weekly.*monthly.*6.?12.?month.*belt replacement.*factory repair/i);
  assert.match(fields.warranty.display_value, /1-year.*original purchaser.*proof of purchase.*misuse.*maintenance/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.evidence_tier, "T4");
  assert.equal(fields.street_price.display_value, "Not yet verified");

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.repair_manual_available, 1);
  assert.equal(product.repairability.serviceability, "user-serviceable");
  assert.equal(product.image_url, null);
  assert.match(product.recommendation_reasoning, /about five years.*great.*launch-period.*twisted fence.*blade.?guard.*dust.*not representative.*service life.*recommendation remain unverified/i);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B08B6G2L6P?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-11-26",
  }]);
});
