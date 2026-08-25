import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Legacy Article Archive Under Evidence Review",
  description: "Legacy articles are quarantined while claims, links, and identities are re-verified.",
  alternates: { canonical: "https://everlasting-goods.com/blog" },
  robots: { index: false, follow: true },
};

export default function BlogAuditPage() {
  return <section className="mx-auto max-w-3xl px-4 py-20 sm:px-6 lg:px-8"><p className="text-sm font-semibold uppercase tracking-wider text-brown-accent">Evidence audit</p><h1 className="mt-4 font-serif text-4xl font-bold text-charcoal">Legacy article archive quarantined</h1><p className="mt-6 text-lg leading-relaxed text-charcoal/65">The prior article catalog is not displayed while claim-level citations, exact-model links, prices, ratings, and author fields are audited. URLs remain available as noindex evidence-review notices.</p><Link href="/database" className="mt-8 inline-block rounded-xl bg-forest-500 px-6 py-3 font-semibold text-white hover:bg-forest-600">Browse verified database records</Link></section>;
}
