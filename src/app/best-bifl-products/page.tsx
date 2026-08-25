import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Evidence Database — Former BIFL Guide Hub",
  description: "The former article hub has been replaced by structured repairability and durability records.",
  alternates: { canonical: "https://everlasting-goods.com/best-bifl-products" },
  robots: { index: false, follow: true },
};

export default function FormerHubPage() {
  return <section className="mx-auto max-w-3xl px-4 py-20 sm:px-6 lg:px-8"><p className="text-sm font-semibold uppercase tracking-wider text-brown-accent">Site transition</p><h1 className="mt-4 font-serif text-4xl font-bold text-charcoal">The general guide hub is retired.</h1><p className="mt-6 text-lg leading-relaxed text-charcoal/65">Legacy buying-guide claims are under evidence review. The active site is now generated from structured tool and shop-equipment records with evidence tiers and verification dates.</p><Link href="/database" className="mt-8 inline-block rounded-xl bg-forest-500 px-6 py-3 font-semibold text-white hover:bg-forest-600">Open the repairability database</Link></section>;
}
