import type { Metadata } from "next";
import Link from "next/link";

import RepairOrReplaceTool from "@/components/RepairOrReplaceTool";
import { databaseProducts } from "@/lib/product-database";

export const metadata: Metadata = {
  title: "Repair or Replace Decision Tool",
  description: "Compare a repair quote with verified replacement economics while keeping unknown failure and service-life evidence explicit.",
  alternates: { canonical: "https://everlasting-goods.com/tools/repair-or-replace" },
};

export default function RepairOrReplacePage() {
  const products = databaseProducts.map((product) => ({ slug: product.slug, label: `${product.brand} ${product.model}` }));
  return (
    <section className="mx-auto max-w-5xl px-4 py-16 sm:px-6 lg:px-8">
      <Link href="/database" className="text-sm font-semibold text-forest-600 hover:underline">← Repairability database</Link>
      <p className="mt-8 text-sm font-semibold uppercase tracking-[0.2em] text-brown-accent">Interactive tool</p>
      <h1 className="mt-3 font-serif text-4xl font-bold text-charcoal md:text-5xl">Repair or replace?</h1>
      <p className="mt-5 max-w-3xl text-lg leading-relaxed text-charcoal/60">Enter a symptom, repair quote, and your own verified replacement inputs. The tool refuses to recommend when service-life or replacement economics are missing.</p>
      <div className="mt-10"><RepairOrReplaceTool products={products} /></div>
    </section>
  );
}
