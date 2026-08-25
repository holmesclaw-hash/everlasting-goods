import assert from "node:assert/strict";
import test from "node:test";

import {
  calculateCostPerYear,
  evidenceLabel,
  groupProductsByCategory,
  repairOrReplaceDecision,
} from "../src/lib/database-utils.mjs";

const sample = [
  { slug: "a", category: "routers", brand: "A", model: "1" },
  { slug: "b", category: "drill-drivers", brand: "B", model: "2" },
  { slug: "c", category: "routers", brand: "C", model: "3" },
];

test("database products group deterministically by category", () => {
  assert.deepEqual(Object.keys(groupProductsByCategory(sample)), ["drill-drivers", "routers"]);
  assert.equal(groupProductsByCategory(sample).routers.length, 2);
});

test("cost per year is computed only from declared inputs", () => {
  assert.equal(calculateCostPerYear({ price: 500, serviceLifeYears: 10, annualMaintenance: 20 }), 70);
  assert.equal(calculateCostPerYear({ price: null, serviceLifeYears: 10, annualMaintenance: 20 }), null);
  assert.equal(calculateCostPerYear({ price: 500, serviceLifeYears: null, annualMaintenance: 20 }), null);
});

test("repair tool refuses to invent a decision when evidence is incomplete", () => {
  assert.deepEqual(
    repairOrReplaceDecision({ repairQuote: 120, replacementPrice: null, expectedServiceLifeYears: null }),
    { status: "insufficient-evidence", message: "Replacement economics are not yet verified for this product." },
  );
});

test("repair tool returns a transparent threshold comparison when inputs are complete", () => {
  const result = repairOrReplaceDecision({ repairQuote: 120, replacementPrice: 600, expectedServiceLifeYears: 10 });
  assert.equal(result.status, "comparison");
  assert.equal(result.repairShareOfReplacement, 0.2);
  assert.equal(result.replacementCostPerYear, 60);
});

test("evidence tier labels are public-facing and T4 is explicit", () => {
  assert.equal(evidenceLabel("T1"), "T1 — First-party");
  assert.equal(evidenceLabel("T2"), "T2 — Manufacturer documentation");
  assert.equal(evidenceLabel("T3"), "T3 — Corroborated owner reports");
  assert.equal(evidenceLabel("T4"), "T4 — Not yet verified");
});
