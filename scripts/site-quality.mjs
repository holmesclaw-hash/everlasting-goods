import { readFile, readdir } from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import { fileURLToPath } from "node:url";

import { findEditorialQualityIssues } from "../src/lib/quality.mjs";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const sourceRoots = ["src", "scripts"];
const checkedExtensions = new Set([".js", ".mjs", ".ts", ".tsx", ".py"]);

async function sourceFiles(relativeDirectory) {
  const absoluteDirectory = path.join(repoRoot, relativeDirectory);
  const entries = await readdir(absoluteDirectory, { withFileTypes: true });
  const files = [];

  for (const entry of entries) {
    const relativePath = path.join(relativeDirectory, entry.name);
    if (entry.isDirectory()) {
      files.push(...await sourceFiles(relativePath));
    } else if (checkedExtensions.has(path.extname(entry.name))) {
      files.push(relativePath);
    }
  }

  return files;
}

const failures = [];
for (const root of sourceRoots) {
  for (const relativePath of await sourceFiles(root)) {
    if (relativePath === path.join("src", "lib", "quality.mjs")) continue;
    const text = await readFile(path.join(repoRoot, relativePath), "utf8");
    for (const issue of findEditorialQualityIssues(text)) {
      failures.push(`${relativePath}: ${issue}`);
    }
  }
}

const adsText = await readFile(path.join(repoRoot, "public", "ads.txt"), "utf8");
const expectedAdsLine = "google.com, pub-6903539486133095, DIRECT, f08c47fec0942fa0";
if (!adsText.split(/\r?\n/).includes(expectedAdsLine)) {
  failures.push("public/ads.txt: approved Google publisher record is missing");
}

if (failures.length > 0) {
  console.error("Site quality gate failed:");
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}

console.log("Site quality gate passed: affiliate tag, editorial trust, newsletter, and ads.txt checks are clean.");
