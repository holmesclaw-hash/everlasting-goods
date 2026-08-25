import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const queueUrl = new URL("../ops/record-expansion-queue.json", import.meta.url);

test("record expansion queue reaches the 100-record planning target without publishing unverified candidates", async () => {
  const queue = JSON.parse(await readFile(queueUrl, "utf8"));
  assert.equal(queue.current_published_records, 16);
  assert.equal(queue.target_total_records, 100);
  assert.equal(queue.candidates.length, 84);
  assert.equal(queue.current_published_records + queue.candidates.length, queue.target_total_records);

  const identities = new Set();
  for (const candidate of queue.candidates) {
    assert.equal(candidate.status, "research-candidate");
    assert.equal(candidate.publish_ready, false);
    assert.ok(candidate.brand);
    assert.ok(candidate.model);
    assert.ok(candidate.sku);
    assert.ok(candidate.category);
    assert.match(candidate.official_product_url, /^https:\/\//);
    assert.ok(candidate.evidence_urls.length >= 1);
    for (const url of candidate.evidence_urls) assert.match(url, /^https:\/\//);
    const identity = `${candidate.brand.toLowerCase()}::${candidate.sku.toLowerCase()}`;
    assert.equal(identities.has(identity), false, `duplicate candidate ${identity}`);
    identities.add(identity);
  }
});
