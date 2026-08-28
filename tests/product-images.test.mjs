import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("product image fields are all-or-nothing exact-model provenance records", async () => {
  const database = JSON.parse(await text("src/generated/database.json"));
  for (const product of database.products) {
    const fields = ["image_url", "image_source_url", "image_license_basis", "image_license_url", "image_attribution", "image_alt"];
    for (const field of fields) assert.ok(field in product, `${product.slug} missing ${field}`);
    const values = fields.map((field) => product[field]);
    const populated = values.filter(Boolean).length;
    assert.ok(populated === 0 || populated === values.length, `${product.slug} has incomplete image provenance`);
    if (product.image_url) {
      assert.match(product.image_url, /^\/images\/products\//);
      assert.match(product.image_source_url, /^https:\/\//);
      assert.ok(product.image_license_basis.includes("exact model"));
      assert.match(product.image_license_url, /^https:\/\//);
      assert.ok(product.image_attribution);
      assert.match(product.image_alt, new RegExp(product.model.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"), "i"));
    }
  }
});

test("product cards render verified exact-product photos without replacing evidence links", async () => {
  const source = await text("src/components/DatabaseProductCard.tsx");
  assert.match(source, /import Image from "next\/image"/);
  assert.match(source, /product\.image_url/);
  assert.match(source, /product\.image_source_url/);
  assert.match(source, /View evidence/);
});

test("product record pages render the verified photo, attribution, and structured-data image", async () => {
  const source = await text("src/app/database/[slug]/page.tsx");
  assert.match(source, /import Image from "next\/image"/);
  assert.match(source, /product\.image_url/);
  assert.match(source, /product\.image_source_url/);
  assert.match(source, /image:\s*`https:\/\/everlasting-goods\.com\$\{product\.image_url\}`/);
  assert.match(source, /Photo source/);
});
