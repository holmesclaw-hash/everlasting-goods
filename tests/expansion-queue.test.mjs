import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const queueUrl = new URL("../ops/record-expansion-queue.json", import.meta.url);

test("record expansion queue reaches the 100-record planning target without publishing unverified candidates", async () => {
  const queue = JSON.parse(await readFile(queueUrl, "utf8"));
  assert.equal(queue.current_published_records, 25);
  assert.equal(queue.target_total_records, 100);
  assert.equal(queue.candidates.length, 76);
  assert.ok(queue.current_published_records + queue.candidates.length >= queue.target_total_records);
  assert.equal(
    queue.candidates.some((candidate) => candidate.model === "GSR18V-800CN"),
    false,
    "published GSR18V-800CN must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.model === "DWP611"),
    false,
    "published DWP611 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.model === "RF1101"),
    false,
    "published RF1101 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.model === "PR20EVS"),
    false,
    "published PR20EVS must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "XCV11Z"),
    false,
    "published XCV11Z must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "0601628010"),
    false,
    "published GKF125CEN must leave the research queue",
  );

  const festoolOf1400 = queue.candidates.find(
    (candidate) => candidate.brand === "Festool" && candidate.sku === "576213",
  );
  assert.ok(festoolOf1400, "historical Festool 576213 must remain a separate candidate");
  assert.ok(
    festoolOf1400.evidence_urls.includes(
      "https://media.cdn.festool.io/productmedia/Images/attachment/ebae769d-53e1-11ef-8a53-005056b3ad01.pdf",
    ),
    "Festool 576213 candidate must retain the official OF 1400 manual",
  );
  assert.match(festoolOf1400.next_gate, /578951/);
  assert.match(festoolOf1400.next_gate, /B09WDWTKB2/);
  assert.match(festoolOf1400.next_gate, /exact commercial destination/i);

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
