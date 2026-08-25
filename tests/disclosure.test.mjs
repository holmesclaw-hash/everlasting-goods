import assert from "node:assert/strict";
import { readFile, readdir } from "node:fs/promises";
import path from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const appRoot = path.join(repoRoot, "src", "app");
const disclosurePath = path.join(repoRoot, "src", "components", "AffiliateDisclosure.tsx");
const requiredStatement = "As an Amazon Associate I earn from qualifying purchases.";

async function pageFiles(directory) {
  const files = [];
  for (const entry of await readdir(directory, { withFileTypes: true })) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) files.push(...await pageFiles(entryPath));
    if (entry.isFile() && entry.name === "page.tsx") files.push(entryPath);
  }
  return files;
}

test("commercial product routes disclose before links or publish no affiliate destinations", async () => {
  const disclosureSource = await readFile(disclosurePath, "utf8").catch(() => "");
  assert.ok(disclosureSource.includes(requiredStatement), "reusable disclosure must contain the required Amazon statement");

  const productRoutes = [];
  for (const pagePath of await pageFiles(appRoot)) {
    const source = await readFile(pagePath, "utf8");
    if (source.includes("import ProductCard")) productRoutes.push([pagePath, source]);
  }

  if (productRoutes.length === 0) {
    const generated = JSON.parse(await readFile(path.join(repoRoot, "src", "generated", "database.json"), "utf8"));
    const affiliateLinks = generated.products.flatMap((product) => product.affiliate_links);
    assert.deepEqual(affiliateLinks, [], "routes without the disclosure component must publish no affiliate destinations");
    return;
  }

  for (const [pagePath, source] of productRoutes) {
    const disclosureIndex = source.indexOf("<AffiliateDisclosure");
    const firstProductCardIndex = source.indexOf("<ProductCard");
    assert.ok(
      source.includes('import AffiliateDisclosure from "@/components/AffiliateDisclosure";') &&
        disclosureIndex >= 0 &&
        disclosureIndex < firstProductCardIndex,
      `${path.relative(repoRoot, pagePath)} must render AffiliateDisclosure before ProductCard`
    );
  }
});
