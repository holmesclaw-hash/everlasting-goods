import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

async function text(path) {
  return readFile(new URL(`../${path}`, import.meta.url), "utf8");
}

test("both decision tools measure one consent-gated completion without collecting entered values", async () => {
  const [costPerYear, repairOrReplace] = await Promise.all([
    text("src/components/CostPerYearCalculator.tsx"),
    text("src/components/RepairOrReplaceTool.tsx"),
  ]);

  for (const source of [costPerYear, repairOrReplace]) {
    assert.match(source, /trackDecisionToolCompletion/);
    assert.match(source, /shouldTrackAffiliateClicks/);
    assert.match(source, /useRef\(false\)/);
    assert.match(source, /everlasting-goods-consent/);
  }

  assert.match(costPerYear, /"cost_per_year"/);
  assert.match(costPerYear, /"cost_per_year_available"/);
  assert.match(repairOrReplace, /"repair_or_replace"/);
  assert.match(repairOrReplace, /"comparison_available"/);
  assert.match(repairOrReplace, /product/);

  for (const sensitiveValue of ["symptom", "quote", "replacement", "years", "price", "maintenance"]) {
    const eventCallPattern = new RegExp(`trackDecisionToolCompletion\\([^)]*${sensitiveValue}`, "s");
    assert.doesNotMatch(costPerYear, eventCallPattern);
    assert.doesNotMatch(repairOrReplace, eventCallPattern);
  }
});