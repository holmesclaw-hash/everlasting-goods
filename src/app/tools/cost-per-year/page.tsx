import type { Metadata } from "next";
import Link from "next/link";

import CostPerYearCalculator from "@/components/CostPerYearCalculator";

export const metadata: Metadata = {
  title: "Cost Per Year Calculator",
  description: "Compare durable products using transparent purchase-price, service-life, and annual-maintenance inputs.",
  alternates: { canonical: "https://everlasting-goods.com/tools/cost-per-year" },
};

export default function CostPerYearPage() {
  return (
    <section className="mx-auto max-w-5xl px-4 py-16 sm:px-6 lg:px-8">
      <Link href="/database" className="text-sm font-semibold text-forest-600 hover:underline">← Repairability database</Link>
      <p className="mt-8 text-sm font-semibold uppercase tracking-[0.2em] text-brown-accent">Interactive tool</p>
      <h1 className="mt-3 font-serif text-4xl font-bold text-charcoal md:text-5xl">Cost per year</h1>
      <p className="mt-5 max-w-3xl text-lg leading-relaxed text-charcoal/60">Use your own verified price and service-life assumptions. Database records leave this blank until evidence exists; this calculator keeps your scenario separate from published facts.</p>
      <div className="mt-10"><CostPerYearCalculator /></div>
    </section>
  );
}
