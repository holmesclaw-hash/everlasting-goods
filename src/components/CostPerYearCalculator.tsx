"use client";

import { useMemo, useState } from "react";

import { calculateCostPerYear } from "@/lib/database-utils.mjs";

export default function CostPerYearCalculator() {
  const [price, setPrice] = useState("");
  const [years, setYears] = useState("");
  const [maintenance, setMaintenance] = useState("0");
  const result = useMemo(() => calculateCostPerYear({
    price: price === "" ? null : Number(price),
    serviceLifeYears: years === "" ? null : Number(years),
    annualMaintenance: maintenance === "" ? 0 : Number(maintenance),
  }), [price, years, maintenance]);

  return (
    <div className="rounded-2xl border border-cream-200 bg-white p-6 md:p-8">
      <div className="grid gap-5 md:grid-cols-3">
        <label className="text-sm font-semibold text-charcoal">Purchase price<input value={price} onChange={(event) => setPrice(event.target.value)} inputMode="decimal" placeholder="500" className="mt-2 w-full rounded-xl border border-cream-200 px-4 py-3 font-normal" /></label>
        <label className="text-sm font-semibold text-charcoal">Expected service life (years)<input value={years} onChange={(event) => setYears(event.target.value)} inputMode="decimal" placeholder="10" className="mt-2 w-full rounded-xl border border-cream-200 px-4 py-3 font-normal" /></label>
        <label className="text-sm font-semibold text-charcoal">Annual maintenance<input value={maintenance} onChange={(event) => setMaintenance(event.target.value)} inputMode="decimal" placeholder="0" className="mt-2 w-full rounded-xl border border-cream-200 px-4 py-3 font-normal" /></label>
      </div>
      <div className="mt-8 rounded-2xl bg-cream-100 p-6">
        <p className="text-sm font-semibold uppercase tracking-wider text-charcoal/45">Computed cost per year</p>
        <p className="mt-2 font-serif text-4xl font-bold text-charcoal">{result == null ? "Enter verified inputs" : `$${result.toFixed(2)}`}</p>
        <p className="mt-3 text-sm text-charcoal/55">Formula: (purchase price ÷ expected service life) + annual maintenance. User-entered values are not added to the evidence database.</p>
      </div>
    </div>
  );
}
