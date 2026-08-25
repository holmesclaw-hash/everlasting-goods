import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import path from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

const routes = [
  ["src/app/page.tsx", "https://everlasting-goods.com/"],
  ["src/app/products/page.tsx", "https://everlasting-goods.com/products"],
];

test("primary commercial routes declare their own canonical URLs", async () => {
  for (const [relativePath, canonical] of routes) {
    const source = await readFile(path.join(repoRoot, relativePath), "utf8");
    assert.ok(source.includes("alternates"), `${relativePath} must declare metadata alternates`);
    assert.ok(source.includes(`canonical: \"${canonical}\"`), `${relativePath} must declare ${canonical}`);
  }
});
