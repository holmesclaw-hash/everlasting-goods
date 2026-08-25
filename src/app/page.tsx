import type { Metadata } from "next";
import Link from "next/link";

import database from "@/generated/database.json";
import DatabaseProductCard from "@/components/DatabaseProductCard";
import { databaseCategories, formatCategory, getDatabaseProductsByCategory } from "@/lib/product-database";

export const metadata: Metadata = {
  title: "Repairability, Durability & True-Cost Database",
  description: "Evidence-tiered manufacturer documentation for tool warranties, manuals, parts support, serviceability, and visible data gaps.",
  alternates: { canonical: "https://everlasting-goods.com/" },
};

export default function HomePage() {
  const featured = database.products.slice(0, 6);
  return (
    <>
      <section className="bg-charcoal text-white">
        <div className="mx-auto max-w-7xl px-4 py-24 sm:px-6 md:py-32 lg:px-8">
          <p className="text-sm font-semibold uppercase tracking-[0.22em] text-forest-300">Repairability · durability · true cost</p>
          <h1 className="mt-5 max-w-4xl font-serif text-5xl font-bold leading-tight md:text-7xl">A product database that shows its receipts.</h1>
          <p className="mt-7 max-w-3xl text-xl leading-relaxed text-white/70">Manufacturer documents are T2. Shop experience will be T1 only when Daniel supplies it. Prices, service life, and failure points stay marked “not yet verified” until evidence exists.</p>
          <div className="mt-9 flex flex-wrap gap-3"><Link href="/database" className="rounded-xl bg-forest-500 px-6 py-3.5 font-semibold text-white hover:bg-forest-600">Open the database</Link><Link href="/methodology" className="rounded-xl border border-white/20 bg-white/10 px-6 py-3.5 font-semibold text-white hover:bg-white/15">See evidence rules</Link></div>
        </div>
      </section>
      <section className="border-b border-cream-200 bg-white"><div className="mx-auto grid max-w-7xl grid-cols-2 gap-6 px-4 py-7 text-center sm:px-6 md:grid-cols-4 lg:px-8"><div><p className="font-serif text-3xl font-bold text-forest-600">{database.products.length}</p><p className="text-xs text-charcoal/50">T2 tool records</p></div><div><p className="font-serif text-3xl font-bold text-forest-600">{databaseCategories.length}</p><p className="text-xs text-charcoal/50">Shop categories</p></div><div><p className="font-serif text-3xl font-bold text-forest-600">4</p><p className="text-xs text-charcoal/50">Evidence tiers</p></div><div><p className="font-serif text-3xl font-bold text-forest-600">0</p><p className="text-xs text-charcoal/50">Invented ratings</p></div></div></section>
      <section className="mx-auto max-w-7xl px-4 py-16 sm:px-6 lg:px-8"><div className="mb-8 flex items-end justify-between"><div><p className="text-sm font-semibold uppercase tracking-wider text-brown-accent">Category one</p><h2 className="mt-2 font-serif text-4xl font-bold text-charcoal">Tools & shop equipment</h2></div><Link href="/database" className="text-sm font-semibold text-forest-600 hover:underline">All records →</Link></div><div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">{featured.map((product) => <DatabaseProductCard key={product.slug} product={product} />)}</div></section>
      <section className="bg-white"><div className="mx-auto max-w-7xl px-4 py-16 sm:px-6 lg:px-8"><h2 className="font-serif text-3xl font-bold text-charcoal">Compare by category</h2><div className="mt-8 grid gap-5 sm:grid-cols-2 lg:grid-cols-3">{databaseCategories.map((category) => <Link key={category} href={`/database/category/${category}`} className="rounded-2xl border border-cream-200 bg-cream-100 p-6 hover:border-forest-500/40"><h3 className="font-serif text-xl font-bold text-charcoal">{formatCategory(category)}</h3><p className="mt-2 text-sm text-charcoal/55">{getDatabaseProductsByCategory(category).length} evidence records</p></Link>)}</div></div></section>
    </>
  );
}
