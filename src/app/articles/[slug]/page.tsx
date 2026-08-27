import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";

import { articleImageEvidence } from "@/content/article-image-evidence.mjs";

import { renderArticleHtml } from "@/lib/article-html.mjs";
import { articles, getArticleBySlug } from "@/lib/data";

interface PageProps { params: Promise<{ slug: string }> }

const RESTORED_GUIDE_SLUG = "best-safety-razors-that-last-a-lifetime";
const RESTORED_GUIDE_TITLE = "Safety Razors: Construction, Blade Format, and Maintenance";
const RESTORED_GUIDE_DESCRIPTION = "A manufacturer-sourced comparison of Edwin Jagger DE89, MERKUR 34C, Henson AL13, and MÜHLE R 41 construction and maintainability.";

export function generateStaticParams() {
  return articles.map((article) => ({ slug: article.slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const article = getArticleBySlug((await params).slug);
  if (!article) return {};
  const canonical = `https://everlasting-goods.com/articles/${article.slug}`;

  if (article.slug === RESTORED_GUIDE_SLUG) {
    const imageEvidence = articleImageEvidence[RESTORED_GUIDE_SLUG];
    return {
      title: RESTORED_GUIDE_TITLE,
      description: RESTORED_GUIDE_DESCRIPTION,
      robots: { index: true, follow: true },
      alternates: { canonical },
      openGraph: {
        type: "article",
        title: RESTORED_GUIDE_TITLE,
        description: RESTORED_GUIDE_DESCRIPTION,
        url: canonical,
        images: [{ url: imageEvidence.image, alt: imageEvidence.alt }],
      },
      twitter: {
        card: "summary_large_image",
        title: RESTORED_GUIDE_TITLE,
        description: RESTORED_GUIDE_DESCRIPTION,
        images: [imageEvidence.image],
      },
    };
  }

  return {
    title: "Legacy guide under evidence review",
    description: "This legacy guide is unavailable while its claims, links, and product identities are re-verified.",
    robots: { index: false, follow: true },
    alternates: { canonical },
  };
}

function RestoredSafetyRazorGuide({ article }: { article: NonNullable<ReturnType<typeof getArticleBySlug>> }) {
  const content = renderArticleHtml(article.content);
  const canonical = `https://everlasting-goods.com/articles/${article.slug}`;
  const imageEvidence = articleImageEvidence[RESTORED_GUIDE_SLUG];
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: RESTORED_GUIDE_TITLE,
    description: RESTORED_GUIDE_DESCRIPTION,
    author: { "@type": "Organization", name: "Everlasting Goods Editorial Team" },
    publisher: { "@type": "Organization", name: "Everlasting Goods", url: "https://everlasting-goods.com" },
    datePublished: article.date,
    dateModified: article.updatedAt ?? article.date,
    image: `https://everlasting-goods.com${imageEvidence.image}`,
    mainEntityOfPage: canonical,
  };

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <section className="border-b border-cream-200 bg-white">
        <div className="mx-auto max-w-4xl px-4 py-14 sm:px-6 lg:px-8">
          <p className="text-sm font-semibold uppercase tracking-[0.2em] text-forest-600">Restored after evidence review</p>
          <h1 className="mt-4 font-serif text-4xl font-bold text-charcoal md:text-5xl">{RESTORED_GUIDE_TITLE}</h1>
          <p className="mt-5 max-w-3xl text-lg leading-relaxed text-charcoal/65">{RESTORED_GUIDE_DESCRIPTION}</p>
          <p className="mt-5 text-sm text-charcoal/45">By Everlasting Goods Editorial Team · Manufacturer sources reviewed 2026-08-25</p>
        </div>
      </section>
      <figure className="mx-auto max-w-5xl px-4 pt-10 sm:px-6 lg:px-8">
        <div className="overflow-hidden rounded-2xl border border-cream-200 bg-white">
          <Image
            src={imageEvidence.image}
            alt={imageEvidence.alt}
            width={1504}
            height={1000}
            className="h-auto w-full object-cover"
            priority
          />
        </div>
        <figcaption className="mt-3 text-sm leading-relaxed text-charcoal/55">
          {imageEvidence.exact_product_model}. Photo: {imageEvidence.attribution}. Source:{" "}
          <a href={imageEvidence.source_url} target="_blank" rel="noopener noreferrer" className="font-semibold text-forest-600 hover:underline">Wikimedia Commons</a>. Licensed under{" "}
          <a href={imageEvidence.license_url} target="_blank" rel="noopener noreferrer" className="font-semibold text-forest-600 hover:underline">{imageEvidence.license}</a>.
        </figcaption>
      </figure>
      <section className="mx-auto max-w-4xl px-4 py-12 sm:px-6 lg:px-8">
        <div className="mb-8 rounded-2xl border border-cream-200 bg-cream-100 p-5 text-sm leading-relaxed text-charcoal/65">
          This restored guide contains no affiliate destination, price, rating, availability, or hands-on claim. Manufacturer statements are attributed; editorial observations are identified as such.
        </div>
        <div className="article-content" dangerouslySetInnerHTML={{ __html: content }} />
        <div className="mt-12 flex flex-wrap gap-3 border-t border-cream-200 pt-8">
          <Link href="/methodology" className="rounded-xl bg-forest-500 px-5 py-3 font-semibold text-white hover:bg-forest-600">Evidence methodology</Link>
          <Link href="/database" className="rounded-xl border border-cream-200 bg-white px-5 py-3 font-semibold text-charcoal hover:bg-cream-100">Verified product database</Link>
        </div>
      </section>
    </>
  );
}

export default async function ArticlePage({ params }: PageProps) {
  const article = getArticleBySlug((await params).slug);
  if (!article) notFound();

  if (article.slug === RESTORED_GUIDE_SLUG) {
    return <RestoredSafetyRazorGuide article={article} />;
  }

  return (
    <section className="mx-auto max-w-3xl px-4 py-20 sm:px-6 lg:px-8">
      <p className="text-sm font-semibold uppercase tracking-[0.2em] text-brown-accent">Evidence audit</p>
      <h1 className="mt-4 font-serif text-4xl font-bold text-charcoal md:text-5xl">Legacy guide under evidence review</h1>
      <div className="mt-8 rounded-2xl border border-cream-200 bg-white p-6 md:p-8">
        <p className="text-lg leading-relaxed text-charcoal/70">The previous content at this URL has been quarantined. Its specifications, warranty statements, prices, ratings, product links, and experience language are not republished until each claim has a source URL and verification date.</p>
        <p className="mt-4 text-charcoal/60">Editorial identity: <strong>Everlasting Goods Editorial Team</strong>. No hands-on or ownership claim is implied.</p>
        <div className="mt-6 flex flex-wrap gap-3">
          <Link href="/database" className="rounded-xl bg-forest-500 px-5 py-3 font-semibold text-white hover:bg-forest-600">Browse verified records</Link>
          <Link href="/methodology" className="rounded-xl border border-cream-200 bg-cream-100 px-5 py-3 font-semibold text-charcoal hover:bg-cream-200">Evidence methodology</Link>
        </div>
      </div>
    </section>
  );
}
