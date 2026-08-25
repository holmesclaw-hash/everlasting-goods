import type { Metadata } from "next";
import Link from "next/link";

import database from "@/generated/database.json";
import DatabaseProductCard from "@/components/DatabaseProductCard";

export const metadata: Metadata = {
  title: "Verified Product Records",
  description: "Evidence-tiered tool and shop-equipment records generated from the Everlasting Goods SQLite database.",
  alternates: { canonical: "https://everlasting-goods.com/products" },
};

export default function ProductsPage() {
  return (
    <>
      <section className="border-b border-cream-200 bg-white"><div className="mx-auto max-w-7xl px-4 py-14 sm:px-6 lg:px-8"><p className="text-sm font-semibold uppercase tracking-wider text-brown-accent">Database view</p><h1 className="mt-2 font-serif text-5xl font-bold text-charcoal">Verified product records</h1><p className="mt-4 max-w-3xl text-lg text-charcoal/60">No price, rating, affiliate destination, or product photo appears unless its identity and provenance are verified. Current records are manufacturer-documentation tier.</p><Link href="/database" className="mt-6 inline-block font-semibold text-forest-600 hover:underline">Open full database and comparisons →</Link></div></section>
      <section className="mx-auto max-w-7xl px-4 py-14 sm:px-6 lg:px-8"><div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">{database.products.map((product) => <DatabaseProductCard key={product.slug} product={product} />)}</div></section>
    </>
  );
}
