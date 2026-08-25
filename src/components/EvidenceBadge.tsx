const labels = {
  T1: "T1 — First-party",
  T2: "T2 — Manufacturer documentation",
  T3: "T3 — Corroborated owner reports",
  T4: "T4 — Not yet verified",
} as const;

export default function EvidenceBadge({ tier }: { tier: string }) {
  const verified = tier !== "T4";
  return (
    <span className={`inline-flex rounded-full px-2.5 py-1 text-xs font-semibold ${verified ? "bg-forest-500/10 text-forest-600" : "bg-cream-200 text-charcoal/55"}`}>
      {labels[tier as keyof typeof labels] ?? "Evidence tier unavailable"}
    </span>
  );
}
