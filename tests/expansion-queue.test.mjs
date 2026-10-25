import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const queueUrl = new URL("../ops/record-expansion-queue.json", import.meta.url);

test("record expansion queue reaches the 100-record planning target without publishing unverified candidates", async () => {
  const queue = JSON.parse(await readFile(queueUrl, "utf8"));
  assert.equal(queue.current_published_records, 49);
  assert.equal(queue.target_total_records, 100);
  assert.equal(queue.candidate_count, 56);
  assert.equal(queue.candidates.length, 56);
  assert.ok(queue.current_published_records + queue.candidates.length >= queue.target_total_records);
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "DCD794B"),
    false,
    "published DCD794B must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "DCD801B"),
    false,
    "published DCD801B must leave the research queue",
  );
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
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "DCS7485B"),
    false,
    "published DCS7485B must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "CNS175-TGP236"),
    false,
    "published CNS175-TGP236 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "JSS-120A60"),
    false,
    "published JSS-120A60 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "C10RJS"),
    false,
    "published C10RJS must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "XCV22PTU"),
    false,
    "published XCV22PTU must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "XCV24ZX"),
    false,
    "published XCV24ZX must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "MAC5200"),
    false,
    "published MAC5200 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "LS0816F"),
    false,
    "published LS0816F must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "LS1219L"),
    false,
    "published LS1219L must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "G0860"),
    false,
    "published G0860 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "G0785"),
    false,
    "published G0785 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "G0548ZP"),
    false,
    "published G0548ZP must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "G0940"),
    false,
    "published G0940 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "G0453Z"),
    false,
    "published G0453Z must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "G1021Z"),
    false,
    "published G1021Z must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "G0946"),
    false,
    "published G0946 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "G0925"),
    false,
    "published G0925 must leave the research queue",
  );
  assert.equal(
    queue.candidates.some((candidate) => candidate.sku === "KP0800K"),
    false,
    "published KP0800K must leave the research queue",
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

  const grizzlyT31739 = queue.candidates.find(
    (candidate) => candidate.brand === "Grizzly" && candidate.sku === "T31739",
  );
  assert.ok(grizzlyT31739, "T31739 must remain queued after its safe publication stop");
  for (const url of [
    "https://cdn0.grizzly.com/specsheets/t31739_ds.pdf",
    "https://cdn0.grizzly.com/manuals/t31739_m.pdf",
    "https://cdn0.grizzly.com/partslists/t31739_pl.pdf",
    "https://www.grizzly.com/products/t31739/parts",
  ]) {
    assert.ok(grizzlyT31739.evidence_urls.includes(url), `T31739 must retain ${url}`);
  }
  assert.match(grizzlyT31739.next_gate, /exact Amazon Associates destination/i);
  assert.match(grizzlyT31739.next_gate, /long-duration owner evidence/i);
  assert.match(grizzlyT31739.next_gate, /lawful exact-model photograph/i);

  const grizzlyG0787 = queue.candidates.find(
    (candidate) => candidate.brand === "Grizzly" && candidate.sku === "G0787",
  );
  assert.ok(grizzlyG0787, "G0787 must remain queued after its safe publication stop");
  for (const url of [
    "https://cdn0.grizzly.com/specsheets/g0787_ds.pdf",
    "https://cdn2.grizzly.com/manuals/g0787_m.pdf",
    "https://cdn0.grizzly.com/partslists/g0787_pl.pdf",
    "https://www.grizzly.com/products/g0787/parts",
  ]) {
    assert.ok(grizzlyG0787.evidence_urls.includes(url), `G0787 must retain ${url}`);
  }
  assert.match(grizzlyG0787.next_gate, /exact Amazon Associates destination/i);
  assert.match(grizzlyG0787.next_gate, /current individual-part orderability/i);
  assert.match(grizzlyG0787.next_gate, /long-duration owner evidence/i);
  assert.match(grizzlyG0787.next_gate, /lawful exact-model photograph/i);

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
