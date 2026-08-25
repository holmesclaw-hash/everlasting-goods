import assert from "node:assert/strict";
import test from "node:test";

import { buildWeeklyDigest } from "../src/lib/digest.mjs";

const input = {
  periodEnding: "2026-08-25",
  products: [{ evidence_tier: "T2" }, { evidence_tier: "T4" }],
  freshnessQueue: [{ is_stale: false }, { is_stale: true }],
  changes: ["Database generated from SQLite."],
  exceptions: ["T1 notes not supplied."],
  traffic: null,
  revenue: null,
};

test("weekly digest reports sourced counts and labels unavailable account data", () => {
  const digest = buildWeeklyDigest(input);
  assert.match(digest, /T2 records: \*\*1\*\*/);
  assert.match(digest, /Stale fields: \*\*1\*\*/);
  assert.match(digest, /Traffic: Not connected/);
  assert.match(digest, /Revenue: Not connected/);
  assert.doesNotMatch(digest, /\$0\.00/);
});

test("weekly digest carries exceptions instead of self-certifying", () => {
  const digest = buildWeeklyDigest(input);
  assert.match(digest, /T1 notes not supplied/);
  assert.match(digest, /Requires Daniel/);
});
