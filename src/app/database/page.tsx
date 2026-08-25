import type { Metadata } from "next";
import Link from "next/link";

import DatabaseProductCard from "@/components/DatabaseProductCard";
import { databaseCategories, databaseProducts, formatCategory, getDatabaseProductsByCategory } from "@/lib/product-database";

export const metadata: Metadata = {
  title: "Repairability & Durability Database",
  description: "Manufacturer-sourced warranty, manual, parts-support, and evidence-tier data for long-lasting tools and shop equipment.",
  alternates: { canonical: "https://everlasting-goods.com/database" },
};

export default function DatabasePage() {
  return (
    <>
      <section className="bg-charcoal text-white">
        <div className="mx-auto max-w-5xl px-4 py-20 sm:px-6 lg:px-8">
          <p className="text-sm font-semibold uppercase tracking-[0.2em] text-forest-300">Repairability database</p>
          <h1 className="mt-4 font-serif text-4xl font-bold md:text-6xl">Facts first. Gaps shown.</h1>
          <p className="mt-6 max-w-3xl text-lg leading-relaxed text-white/70">
            {databaseProducts.length} tool and shop-equipment records generated from a tracked evidence database. T2 fields link to manufacturer documentation. Unknown service life, price, and repair economics remain explicitly unverified.
          </p>
          <div className="mt-8 flex flex-wrap gap-3">
            <Link href="/tools/cost-per-year" className="rounded-xl bg-forest-500 px-5 py-3 font-semibold text-white hover:bg-forest-600">Cost-per-year calculator</Link>
            <Link href="/tools/repair-or-replace" className="rounded-xl border border-white/20 bg-white/10 px-5 py-3 font-semibold text-white hover:bg-white/15">Repair-or-replace tool</Link>
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl space-y-16 px-4 py-16 sm:px-6 lg:px-8">
        {databaseCategories.map((category) => {
          const products = getDatabaseProductsByCategory(category);
          return (
            <div key={category}>
              <div className="mb-6 flex items-end justify-between border-b border-cream-200 pb-4">
                <div>
                  <h2 className="font-serif text-3xl font-bold text-charcoal">{formatCategory(category)}</h2>
                  <p className="mt-1 text-sm text-charcoal/50">{products.length} manufacturer-documented records</p>
                </div>
                <Link href={`/database/category/${category}`} className="text-sm font-semibold text-forest-600 hover:underline">Compare →</Link>
              </div>
              <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                {products.map((product) => <DatabaseProductCard key={product.slug} product={product} />)}
              </div>
            </div>
          );
        })}
      </section>
    </>
  );
}
