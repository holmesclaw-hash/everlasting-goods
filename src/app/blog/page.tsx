import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";

import { articleImageEvidence } from "@/content/article-image-evidence.mjs";

export const metadata: Metadata = {
  title: "Durable Product Guides",
  description: "Evidence-reviewed guides to durable products, using lawful exact-model photography, manufacturer documentation, owner evidence, and visible limitations.",
  alternates: { canonical: "https://everlasting-goods.com/blog" },
  robots: { index: true, follow: true },
};

const guideCandidates = [
  {
    slug: "best-estwing-hammers-that-last-a-lifetime",
    title: "Estwing B3-3LB Drilling Hammer Evidence Review",
    description: "One-piece construction, warranty and repair limits, safety boundaries, and owner tradeoffs for the 3-lb drilling hammer.",
    reviewedAt: "2026-09-04",
  },
  {
    slug: "best-kitchen-knives-that-last-a-lifetime",
    title: "Victorinox Fibrox 8-Inch Evidence Review",
    description: "Edge maintenance, warranty limits, repairability boundaries, and dated long-term owner evidence for model 5.2063.20.",
    reviewedAt: "2026-08-31",
  },
  {
    slug: "best-cast-iron-skillets-that-last-forever",
    title: "Lodge 12-Inch Cast-Iron Skillet Evidence Review",
    description: "Maintainable seasoning, warranty exclusions, ownership tradeoffs, and dated owner evidence for the Lodge 12-inch skillet.",
    reviewedAt: "2026-08-30",
  },
  {
    slug: "best-safety-razors-that-last-a-lifetime",
    title: "Safety Razors: Construction and Maintenance",
    description: "Manufacturer-documented materials and blade systems, plus clearly limited owner evidence for the MERKUR 34C.",
    reviewedAt: "2026-08-29",
  },
] as const;

const guides = guideCandidates.filter((guide) => articleImageEvidence[guide.slug]);

export default function GuideHubPage() {
  return (
    <>
      <section className="border-b border-cream-200 bg-white">
        <div className="mx-auto max-w-7xl px-4 py-16 sm:px-6 lg:px-8">
          <p className="text-sm font-semibold uppercase tracking-[0.2em] text-forest-600">Evidence-reviewed guides</p>
          <h1 className="mt-4 max-w-4xl font-serif text-5xl font-bold text-charcoal">Durable product guides that show the evidence and the limits.</h1>
          <p className="mt-6 max-w-3xl text-lg leading-relaxed text-charcoal/65">
            Only restored guides that passed claim, product-identity, image-rights, and affiliate-destination review appear here. Legacy articles remain quarantined and are not listed.
          </p>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-14 sm:px-6 lg:px-8">
        <div className="grid gap-7 md:grid-cols-2 lg:grid-cols-3">
          {guides.map((guide) => {
            const image = articleImageEvidence[guide.slug];
            return (
              <article key={guide.slug} className="flex flex-col overflow-hidden rounded-2xl border border-cream-200 bg-white shadow-sm">
                {image ? (
                  <Link href={`/articles/${guide.slug}`} className="block border-b border-cream-200 bg-cream-50">
                    <Image
                      src={image.image}
                      alt={image.alt}
                      width={1200}
                      height={800}
                      className="aspect-[4/3] h-auto w-full object-contain p-4"
                    />
                  </Link>
                ) : null}
                <div className="flex flex-1 flex-col p-6">
                  <p className="text-xs font-semibold uppercase tracking-wider text-brown-accent">Reviewed {guide.reviewedAt}</p>
                  <h2 className="mt-2 font-serif text-2xl font-bold leading-tight text-charcoal">
                    <Link href={`/articles/${guide.slug}`} className="hover:text-forest-600">{guide.title}</Link>
                  </h2>
                  <p className="mt-4 flex-1 text-sm leading-relaxed text-charcoal/60">{guide.description}</p>
                  <Link href={`/articles/${guide.slug}`} className="mt-6 font-semibold text-forest-600 hover:underline">Read the evidence review →</Link>
                  {image ? (
                    <p className="mt-5 border-t border-cream-200 pt-4 text-[11px] leading-relaxed text-charcoal/45">
                      Photo: {image.attribution}.{" "}
                      <a href={image.source_url} target="_blank" rel="noopener noreferrer" className="font-semibold text-forest-600 hover:underline">Source</a>{" "}
                      · <a href={image.license_url} target="_blank" rel="noopener noreferrer" className="font-semibold text-forest-600 hover:underline">{image.license}</a>
                    </p>
                  ) : null}
                </div>
              </article>
            );
          })}
        </div>

        <div className="mt-14 rounded-2xl bg-charcoal p-8 text-white md:flex md:items-center md:justify-between md:gap-8">
          <div>
            <h2 className="font-serif text-3xl font-bold">Need structured repairability data?</h2>
            <p className="mt-3 max-w-2xl text-sm leading-relaxed text-white/65">The product database keeps manufacturer evidence, verification dates, unknown fields, and exact-model records separate from editorial guides.</p>
          </div>
          <Link href="/database" className="mt-6 inline-block shrink-0 rounded-xl bg-forest-500 px-5 py-3 font-semibold text-white hover:bg-forest-600 md:mt-0">Open the database</Link>
        </div>
      </section>
    </>
  );
}
