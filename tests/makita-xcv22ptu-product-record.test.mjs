import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const slug = "makita-xcv22ptu";
const productUrl = "https://www.makitatools.com/products/details/XCV22PTU";
const toolOnlyUrl = "https://makitatools.com/products/details/XCV22ZU";
const manualUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/XCV/327ba01a-87b8-469b-b38e-6be962ae4f80_XCV22,XCV25_IM.pdf";
const partsUrl = "https://cdn.makitatools.com/apps/cms/doc/prod/XCV/0334bc58-3f68-4102-9b70-b4ea1c4be548_XCV22_PB_Breakdown_XCV22PTU,ZU_03-22.pdf";
const warrantyUrl = "https://www.makitatools.com/service/warranty";
const serviceUrl = "https://www.makitatools.com/service/service-centers";

async function record() {
  const database = JSON.parse(
    await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8"),
  );
  return database.products.find((product) => product.slug === slug);
}

test("the Makita XCV22PTU record preserves kit, parts, service, and evidence boundaries", async () => {
  const product = await record();
  assert.ok(product, `${slug} must be generated from SQLite`);
  assert.equal(product.brand, "Makita");
  assert.equal(product.model, "XCV22PTU");
  assert.equal(product.sku, "XCV22PTU");
  assert.equal(product.category, "dust-extractors");
  assert.equal(product.evidence_tier, "T2");
  assert.equal(product.recommendation, "not-yet-verified");
  assert.equal(product.last_reviewed_date, "2026-10-04");
  assert.match(product.variant_notes, /XCV22PTU.*kit.*XCV22ZU.*tool-only.*discontinued.*XCV25.*XCV21.*not transferred/i);

  const sourceUrls = new Set(product.sources.map((source) => source.url));
  for (const url of [
    productUrl,
    toolOnlyUrl,
    manualUrl,
    partsUrl,
    warrantyUrl,
    serviceUrl,
    "https://makitatools.com/company/press-releases/2022/makita-expands-dust-extraction-system-with-new-hepa-dry-vaccum",
    "https://www.amazon.com/dp/B0B52D7QP4",
    "https://acmetools.com/makita-36v-18v-x2-lxt-21-gallon-hepa-dry-dust-extractor-vacuum-kit-aws-xcv22ptu/088381898867.html",
  ]) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);

  const fields = Object.fromEntries(product.fields.map((field) => [field.name, field]));
  assert.match(fields.identity.display_value, /36V.*18V X2.*2.1-gallon.*dry.*XCV22ZU.*two.*5.0Ah.*DC18RD.*AWS/i);
  assert.match(fields.parts_availability.display_value, /partial.*XCV22.*parts breakdown.*motor.*rotor.*stator.*controller.*filters.*internal.*orderability.*not verified/i);
  assert.match(fields.repair_manual.display_value, /owner.*filter.*tank.*troubleshooting.*not.*repair manual/i);
  assert.match(fields.serviceability.display_value, /owner.*filters.*tank.*internal.*authorized service/i);
  assert.match(fields.warranty.display_value, /three-year.*tool.*batter(?:y|ies).*charger/i);
  assert.equal(fields.expected_service_life.evidence_tier, "T4");
  assert.equal(fields.expected_service_life.display_value, "Not yet verified");
  assert.equal(fields.street_price.display_value, "Not yet verified");
  assert.match(product.recommendation_reasoning, /introduced.*2022.*no qualifying.*owner.*duration.*expected service life.*recommendation remain unverified/i);

  assert.equal(product.repairability.parts_availability, "partial");
  assert.equal(product.repairability.parts_url, partsUrl);
  assert.equal(product.repairability.repair_manual_available, 0);
  assert.equal(product.repairability.repair_manual_url, manualUrl);
  assert.equal(product.repairability.serviceability, "shop-serviceable");
  assert.equal(product.image_url, null);
  assert.equal(product.image_source_url, null);

  assert.deepEqual(product.affiliate_links, [{
    program_name: "Amazon Associates",
    url: "https://www.amazon.com/dp/B0B52D7QP4?tag=everlastin08f-20",
    exact_model: true,
    verified_date: "2026-10-04",
  }]);
});
