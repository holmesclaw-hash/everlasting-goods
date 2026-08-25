export function buildWeeklyDigest({ periodEnding, products, freshnessQueue, changes, exceptions, traffic, revenue }) {
  const t1 = products.filter((product) => product.evidence_tier === "T1").length;
  const t2 = products.filter((product) => product.evidence_tier === "T2").length;
  const stale = freshnessQueue.filter((field) => field.is_stale).length;
  const lines = [
    `# Everlasting Goods Weekly Digest — ${periodEnding}`,
    "",
    "## Changes made",
    ...(changes.length ? changes.map((change) => `- ${change}`) : ["- No changes recorded."]),
    "",
    "## Evidence status",
    `- T1 records: **${t1}**`,
    `- T2 records: **${t2}**`,
    `- Stale fields: **${stale}**`,
    "",
    "## Requires Daniel",
    ...(exceptions.length ? exceptions.map((exception) => `- ${exception}`) : ["- No critical exception recorded."]),
    "",
    "## Measurement",
    `- Traffic: ${traffic ?? "Not connected"}`,
    `- Revenue: ${revenue ?? "Not connected"}`,
    "",
    "## Evidence",
    "- Database: `data/everlasting.db`",
    "- Generated records: `src/generated/database.json`",
    "- Audit: `ops/audit/phase-1-audit-report.md`",
  ];
  return `${lines.join("\n")}\n`;
}
