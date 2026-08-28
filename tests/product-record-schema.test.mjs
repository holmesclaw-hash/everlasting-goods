import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const recordPageSource = await readFile(
  new URL("../src/app/database/[slug]/page.tsx", import.meta.url),
  "utf8",
);

test("unrated manufacturer records publish Product schema without claiming a Review", () => {
  assert.match(recordPageSource, /"@type": "Product"/);
  assert.doesNotMatch(recordPageSource, /"@type": "Review"/);
  assert.doesNotMatch(recordPageSource, /reviewBody:/);
});
