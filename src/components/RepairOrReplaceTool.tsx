"use client";

import { useMemo, useState } from "react";

import { repairOrReplaceDecision } from "@/lib/database-utils.mjs";

interface ProductOption { slug: string; label: string }

export default function RepairOrReplaceTool({ products }: { products: ProductOption[] }) {
  const [product, setProduct] = useState(products[0]?.slug ?? "");
  const [symptom, setSymptom] = useState("");
  const [quote, setQuote] = useState("");
  const [replacement, setReplacement] = useState("");
  const [years, setYears] = useState("");
  const result = useMemo(() => repairOrReplaceDecision({
    repairQuote: quote === "" ? 0 : Number(quote),
    replacementPrice: replacement === "" ? null : Number(replacement),
    expectedServiceLifeYears: years === "" ? null : Number(years),
  }), [quote, replacement, years]);

  return (
    <div className="rounded-2xl border border-cream-200 bg-white p-6 md:p-8">
      <div className="grid gap-5 md:grid-cols-2">
        <label className="text-sm font-semibold text-charcoal">Product<select value={product} onChange={(event) => setProduct(event.target.value)} className="mt-2 w-full rounded-xl border border-cream-200 px-4 py-3 font-normal">{products.map((item) => <option key={item.slug} value={item.slug}>{item.label}</option>)}</select></label>
        <label className="text-sm font-semibold text-charcoal">Symptom<input value={symptom} onChange={(event) => setSymptom(event.target.value)} placeholder="Describe what failed" className="mt-2 w-full rounded-xl border border-cream-200 px-4 py-3 font-normal" /></label>
        <label className="text-sm font-semibold text-charcoal">Repair quote<input value={quote} onChange={(event) => setQuote(event.target.value)} inputMode="decimal" placeholder="120" className="mt-2 w-full rounded-xl border border-cream-200 px-4 py-3 font-normal" /></label>
        <label className="text-sm font-semibold text-charcoal">Verified replacement price<input value={replacement} onChange={(event) => setReplacement(event.target.value)} inputMode="decimal" placeholder="600" className="mt-2 w-full rounded-xl border border-cream-200 px-4 py-3 font-normal" /></label>
        <label className="text-sm font-semibold text-charcoal">Expected replacement life (years)<input value={years} onChange={(event) => setYears(event.target.value)} inputMode="decimal" placeholder="10" className="mt-2 w-full rounded-xl border border-cream-200 px-4 py-3 font-normal" /></label>
      </div>
      <div className="mt-8 rounded-2xl bg-cream-100 p-6">
        <p className="text-sm font-semibold uppercase tracking-wider text-charcoal/45">Evidence-aware output</p>
        {result.status === "insufficient-evidence" ? <p className="mt-3 text-lg font-semibold text-charcoal">{result.message}</p> : <div className="mt-3 space-y-2 text-charcoal"><p>Repair quote is <strong>{Math.round((result.repairShareOfReplacement ?? 0) * 100)}%</strong> of replacement price.</p><p>Replacement scenario costs <strong>{result.replacementCostPerYear == null ? "not available" : `$${result.replacementCostPerYear.toFixed(2)}`}</strong> per year before maintenance.</p><p className="text-sm text-charcoal/55">This is a comparison, not a recommendation. Known failure-point evidence and remaining-life evidence are not yet verified.</p></div>}
        {symptom && <p className="mt-4 text-xs text-charcoal/45">Symptom entered: {symptom}. It is not stored or treated as evidence.</p>}
      </div>
    </div>
  );
}
