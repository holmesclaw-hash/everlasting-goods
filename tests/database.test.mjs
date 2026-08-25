import assert from "node:assert/strict";
import { createHash } from "node:crypto";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function loadGeneratedDatabase() {
  const text = await readFile(new URL("../src/generated/database.json", import.meta.url), "utf8");
  return JSON.parse(text);
}

test("generated database is synchronized to the tracked SQLite source", async () => {
  const generated = await loadGeneratedDatabase();
  const database = await readFile(new URL("../data/everlasting.db", import.meta.url));
  const digest = createHash("sha256").update(database).digest("hex");
  assert.equal(generated.database_sha256, digest);
  assert.equal(generated.schema_version, 1);
});

test("database generation is deterministic for a fixed migration", async () => {
  const generated = await loadGeneratedDatabase();
  assert.equal(generated.generated_at, "2026-08-25T00:00:00.000Z");
});

test("category one contains at least fifteen publishable T1 or T2 tool records", async () => {
  const generated = await loadGeneratedDatabase();
  const publishable = generated.products.filter((product) =>
    ["T1", "T2"].includes(product.evidence_tier)
    && product.category_group === "tools-shop"
  );
  assert.ok(publishable.length >= 15, `expected >=15 publishable tool records, found ${publishable.length}`);

  for (const product of publishable) {
    assert.ok(product.brand);
    assert.ok(product.model);
    assert.ok(product.slug);
    assert.ok(product.last_reviewed_date);
    assert.ok(product.sources.length >= 1, `${product.slug} needs a source`);
    for (const source of product.sources) {
      assert.match(source.url, /^https:\/\//);
      assert.match(source.retrieved_date, /^\d{4}-\d{2}-\d{2}$/);
    }
  }
});

test("published fields declare evidence and freshness instead of plausible guesses", async () => {
  const generated = await loadGeneratedDatabase();
  for (const product of generated.products) {
    for (const field of product.fields) {
      assert.ok(["T1", "T2", "T3", "T4"].includes(field.evidence_tier));
      assert.match(field.verified_date, /^\d{4}-\d{2}-\d{2}$/);
      assert.ok(Number.isInteger(field.reverify_days) && field.reverify_days > 0);
      if (field.evidence_tier === "T4") {
        assert.equal(field.display_value, "Not yet verified");
      } else {
        assert.ok(field.source_url, `${product.slug}.${field.name} needs a source URL`);
      }
    }
  }
});

test("affiliate destinations are exact-model Amazon links for every published record", async () => {
  const generated = await loadGeneratedDatabase();
  const expectedAsins = {
    "california-air-tools-8010": "B00WM1VPKE",
    "makita-mac210q": "B084GYHQFY",
    "bosch-gsr18v-535fcb15": "B07Z5QNBVS",
    "dewalt-dcd800b": "B09ZQ4VTXK",
    "dewalt-dcd800d1e1": "B00EOOZT5E",
    "makita-xfd14z": "B093QS3VJR",
    "milwaukee-2904-20": "B0BB854SJ8",
    "fein-turbo-i": "B00K69ILFQ",
    "festool-ct-26-ei-hepa": "B0DYK9VDC1",
    "makita-vc4210l": "B07ZMN75V2",
    "bosch-1617evspk": "B00005RHPD",
    "dewalt-dcw600b": "B07KSRTDML",
    "makita-rt0701c": "B00E7D3V4S",
    "bosch-4100xc-10": "B0851KL858",
    "dewalt-dwe7491rs": "B00F2CGXGG",
    "sawstop-pcs31230-tgp236": "B009C7NGTE",
  };

  assert.equal(generated.products.length, Object.keys(expectedAsins).length);
  for (const product of generated.products) {
    assert.equal(product.affiliate_links.length, 1, `${product.slug} needs one verified destination`);
    const [link] = product.affiliate_links;
    assert.equal(link.program_name, "Amazon Associates");
    assert.equal(link.exact_model, true);
    assert.equal(link.verified_date, "2026-08-25");
    const parsed = new URL(link.url);
    assert.equal(parsed.hostname, "www.amazon.com");
    assert.equal(parsed.pathname, `/dp/${expectedAsins[product.slug]}`);
    assert.equal(parsed.searchParams.get("tag"), "everlastin08f-20");
    assert.equal(parsed.searchParams.has("k"), false);
  }
});

test("manufacturer research is reconciled to exact manuals and parts catalogs", async () => {
  const generated = await loadGeneratedDatabase();
  const expected = {
    "dewalt-dcd800b": ["https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA043446_DCD800_DCD805_NA.pdf", "https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif"],
    "milwaukee-2904-20": ["https://documents.milwaukeetool.com/58-14-9998d1.pdf", "https://documents.milwaukeetool.com/54-24-2990R.pdf"],
    "makita-xfd14z": ["https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf", "https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf"],
    "bosch-gsr18v-535fcb15": ["https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf", "https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110"],
    "bosch-4100xc-10": ["https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf", "https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/4100xc-10-3601L13015"],
    "makita-rt0701c": ["https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf", "https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf"],
  };
  for (const [slug, urls] of Object.entries(expected)) {
    const product = generated.products.find((item) => item.slug === slug);
    assert.ok(product, `${slug} must exist`);
    const sourceUrls = new Set(product.sources.map((source) => source.url));
    for (const url of urls) assert.ok(sourceUrls.has(url), `${slug} missing ${url}`);
  }
});
