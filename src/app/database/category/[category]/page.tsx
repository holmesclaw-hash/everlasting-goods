import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";

import AffiliateDisclosure from "@/components/AffiliateDisclosure";
import EvidenceBadge from "@/components/EvidenceBadge";
import { databaseCategories, fieldFor, formatCategory, getDatabaseProductsByCategory } from "@/lib/product-database";

interface PageProps { params: Promise<{ category: string }> }

export function generateStaticParams() {
  return databaseCategories.map((category) => ({ category }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const category = (await params).category;
  if (!databaseCategories.includes(category)) return {};
  return {
    title: `${formatCategory(category)} Repairability Comparison`,
    description: `Evidence-tiered manufacturer documentation for ${formatCategory(category).toLowerCase()}, including warranty, manuals, parts support, and visible data gaps.`,
    alternates: { canonical: `https://everlasting-goods.com/database/category/${category}` },
  };
}

export default async function DatabaseCategoryPage({ params }: PageProps) {
  const category = (await params).category;
  const products = getDatabaseProductsByCategory(category);
  if (!products.length) notFound();

  return (
    <>
      <section className="border-b border-cream-200 bg-white">
        <div className="mx-auto max-w-6xl px-4 py-14 sm:px-6 lg:px-8">
          <Link href="/database" className="text-sm font-semibold text-forest-600 hover:underline">← Database</Link>
          <h1 className="mt-5 font-serif text-4xl font-bold text-charcoal md:text-5xl">{formatCategory(category)}</h1>
          <p className="mt-4 max-w-3xl text-lg text-charcoal/60">Generated comparison of manufacturer-documented fields. An empty economic or service-life field is intentional, not a missing guess.</p>
        </div>
      </section>
      <section className="mx-auto max-w-7xl px-4 py-14 sm:px-6 lg:px-8">
        <AffiliateDisclosure />
        <div className="overflow-x-auto rounded-2xl border border-cream-200 bg-white">
          <table className="min-w-full text-left text-sm">
            <thead className="bg-cream-100 text-charcoal"><tr><th className="p-4">Product</th><th className="p-4">Evidence</th><th className="p-4">Warranty</th><th className="p-4">Parts</th><th className="p-4">Manual</th><th className="p-4">Cost/year</th><th className="p-4">Exact model</th></tr></thead>
            <tbody>
              {products.map((product) => {
                const affiliateLink = product.affiliate_links[0];
                return (
                  <tr key={product.slug} className="border-t border-cream-200 align-top">
                    <td className="p-4"><Link href={`/database/${product.slug}`} className="font-semibold text-forest-600 hover:underline">{product.brand} {product.model}</Link><p className="mt-1 text-xs text-charcoal/45">{fieldFor(product, "identity")?.display_value}</p></td>
                    <td className="p-4"><EvidenceBadge tier={product.evidence_tier} /></td>
                    <td className="p-4 text-charcoal/65">{fieldFor(product, "warranty")?.display_value}</td>
                    <td className="p-4 text-charcoal/65">{fieldFor(product, "parts_availability")?.display_value}</td>
                    <td className="p-4 text-charcoal/65">{fieldFor(product, "repair_manual")?.display_value}</td>
                    <td className="p-4 font-semibold text-charcoal">{product.cost_per_year == null ? "Not yet verified" : `$${product.cost_per_year}`}</td>
                    <td className="min-w-52 p-4">
                      {affiliateLink ? (
                        <>
                          <a href={affiliateLink.url} target="_blank" rel="sponsored nofollow noopener noreferrer" className="inline-block rounded-xl bg-brown-accent px-4 py-3 text-center text-xs font-semibold text-white hover:bg-brown-dark">View exact model on Amazon</a>
                          <p className="mt-2 text-xs leading-relaxed text-charcoal/45">Destination verified {affiliateLink.verified_date}. Price and availability are shown only by the merchant.</p>
                        </>
                      ) : (
                        <span className="text-xs text-charcoal/45">No verified destination</span>
                      )}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </section>
    </>
  );
}
