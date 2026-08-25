import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";

import EvidenceBadge from "@/components/EvidenceBadge";
import { databaseProducts, fieldFor, formatCategory, getDatabaseProduct } from "@/lib/product-database";

interface PageProps { params: Promise<{ slug: string }> }

export function generateStaticParams() {
  return databaseProducts.map((product) => ({ slug: product.slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const product = getDatabaseProduct((await params).slug);
  if (!product) return {};
  const identity = fieldFor(product, "identity")?.display_value ?? `${product.brand} ${product.model}`;
  return {
    title: `${product.brand} ${product.model} Repairability Record`,
    description: `${identity}. Evidence-tiered manufacturer sources, warranty, manuals, parts support, and explicit unverified gaps.`,
    alternates: { canonical: `https://everlasting-goods.com/database/${product.slug}` },
  };
}

export default async function ProductRecordPage({ params }: PageProps) {
  const product = getDatabaseProduct((await params).slug);
  if (!product) notFound();

  const identity = fieldFor(product, "identity")?.display_value ?? `${product.brand} ${product.model}`;
  const jsonLd = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "Product",
        name: `${product.brand} ${product.model}`,
        model: product.model,
        sku: product.sku,
        brand: { "@type": "Brand", name: product.brand },
        category: formatCategory(product.category),
        description: identity,
        url: `https://everlasting-goods.com/database/${product.slug}`,
      },
      {
        "@type": "Review",
        itemReviewed: { "@type": "Product", name: `${product.brand} ${product.model}` },
        author: { "@type": "Organization", name: "Everlasting Goods Editorial Team" },
        datePublished: product.last_reviewed_date,
        reviewBody: "Evidence profile based on linked manufacturer documentation. No hands-on rating is asserted. Unverified fields are displayed as gaps.",
      },
    ],
  };

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <section className="border-b border-cream-200 bg-white">
        <div className="mx-auto max-w-5xl px-4 py-14 sm:px-6 lg:px-8">
          <Link href={`/database/category/${product.category}`} className="text-sm font-semibold text-forest-600 hover:underline">← {formatCategory(product.category)}</Link>
          <div className="mt-6 flex flex-col justify-between gap-5 md:flex-row md:items-start">
            <div>
              <p className="text-sm font-semibold uppercase tracking-wider text-charcoal/45">{product.brand}</p>
              <h1 className="mt-2 font-serif text-4xl font-bold text-charcoal md:text-5xl">{product.model}</h1>
              <p className="mt-4 max-w-3xl text-lg leading-relaxed text-charcoal/65">{identity}</p>
            </div>
            <EvidenceBadge tier={product.evidence_tier} />
          </div>
          <p className="mt-6 text-sm text-charcoal/45">Last reviewed: {product.last_reviewed_date}</p>
        </div>
      </section>

      <section className="mx-auto grid max-w-7xl gap-10 px-4 py-14 sm:px-6 lg:grid-cols-[1fr_340px] lg:px-8">
        <div>
          <h2 className="font-serif text-3xl font-bold text-charcoal">Evidence fields</h2>
          <div className="mt-6 overflow-hidden rounded-2xl border border-cream-200 bg-white">
            {product.fields.map((field) => (
              <div key={field.name} className="grid gap-3 border-b border-cream-200 p-5 last:border-0 md:grid-cols-[180px_1fr]">
                <div>
                  <p className="font-semibold text-charcoal">{formatCategory(field.name)}</p>
                  <div className="mt-2"><EvidenceBadge tier={field.evidence_tier} /></div>
                </div>
                <div>
                  <p className="text-charcoal/70">{field.display_value}</p>
                  <p className="mt-2 text-xs text-charcoal/45">Verified {field.verified_date}; recheck every {field.reverify_days} days; stale after {field.stale_after}</p>
                  {field.source_url && <a href={field.source_url} target="_blank" rel="noopener noreferrer" className="mt-2 inline-block text-sm font-semibold text-forest-600 hover:underline">Manufacturer source ↗</a>}
                </div>
              </div>
            ))}
          </div>
        </div>

        <aside className="space-y-6">
          <div className="rounded-2xl border border-cream-200 bg-white p-6">
            <h2 className="font-serif text-xl font-bold text-charcoal">Repairability</h2>
            <dl className="mt-4 space-y-4 text-sm">
              <div><dt className="text-charcoal/45">Parts availability</dt><dd className="font-semibold text-charcoal">{product.repairability?.parts_availability ?? "not-yet-verified"}</dd></div>
              <div><dt className="text-charcoal/45">Serviceability</dt><dd className="font-semibold text-charcoal">{product.repairability?.serviceability ?? "not-yet-verified"}</dd></div>
              <div><dt className="text-charcoal/45">Repair manual</dt><dd className="font-semibold text-charcoal">{product.repairability?.repair_manual_available ? "Official link available" : "Not yet verified"}</dd></div>
            </dl>
            {product.repairability?.repair_manual_url && <a href={product.repairability.repair_manual_url} target="_blank" rel="noopener noreferrer" className="mt-5 block rounded-xl bg-forest-500 px-4 py-3 text-center text-sm font-semibold text-white hover:bg-forest-600">Open official manual</a>}
          </div>
          <div className="rounded-2xl border border-cream-200 bg-cream-100 p-6">
            <h2 className="font-serif text-xl font-bold text-charcoal">Current verdict</h2>
            <p className="mt-3 text-charcoal/65">{product.recommendation_reasoning}</p>
            <p className="mt-3 text-xs text-charcoal/45">No price, expected service life, failure point, or cost-per-year figure is published until its evidence reaches T1–T3.</p>
          </div>
          <div className="rounded-2xl border border-cream-200 bg-white p-6">
            <h2 className="font-serif text-xl font-bold text-charcoal">Source register</h2>
            <ul className="mt-4 space-y-3 text-sm">
              {product.sources.map((source) => (
                <li key={`${source.url}-${source.purpose}`}><a href={source.url} target="_blank" rel="noopener noreferrer" className="font-semibold text-forest-600 hover:underline">{source.purpose}: {source.title}</a><p className="text-xs text-charcoal/45">Retrieved {source.retrieved_date}</p></li>
              ))}
            </ul>
          </div>
        </aside>
      </section>
    </>
  );
}
