import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";

import AffiliateDisclosure from "@/components/AffiliateDisclosure";
import { articleImageEvidence } from "@/content/article-image-evidence.mjs";

import { amazonLink } from "@/lib/affiliate.mjs";
import { renderArticleHtml } from "@/lib/article-html.mjs";
import { articles, getArticleBySlug } from "@/lib/data";

interface PageProps { params: Promise<{ slug: string }> }

const RESTORED_GUIDE_SLUG = "best-safety-razors-that-last-a-lifetime";
const CAST_IRON_GUIDE_SLUG = "best-cast-iron-skillets-that-last-forever";
const ESTWING_GUIDE_SLUG = "best-estwing-hammers-that-last-a-lifetime";
const VICTORINOX_GUIDE_SLUG = "best-kitchen-knives-that-last-a-lifetime";

const restoredGuides = {
  [RESTORED_GUIDE_SLUG]: {
    slug: RESTORED_GUIDE_SLUG,
    title: "Safety Razors: Construction, Blade Format, and Maintenance",
    description: "A manufacturer-sourced comparison of Edwin Jagger DE89, MERKUR 34C, Henson AL13, and MÜHLE R 41 construction and maintainability.",
    reviewedAt: "2026-08-29",
    asin: "B002A8JO1Q",
    destinationDescription: "MERKUR Classic MK-34C, ASIN B002A8JO1Q",
    destinationLabel: "View exact MERKUR 34C on Amazon",
    imageWidth: 1504,
    imageHeight: 1000,
  },
  [CAST_IRON_GUIDE_SLUG]: {
    slug: CAST_IRON_GUIDE_SLUG,
    title: "Cast-Iron Skillets That Last: Lodge 12-Inch Evidence Review",
    description: "A source-checked review of the Lodge 12-inch Classic Cast Iron Skillet, including maintainable seasoning, warranty limits, ownership tradeoffs, and dated owner evidence.",
    reviewedAt: "2026-08-30",
    asin: "B00006JSUB",
    destinationDescription: "the standalone Lodge L10SK3 12-inch skillet, ASIN B00006JSUB",
    destinationLabel: "View exact Lodge L10SK3 on Amazon",
    imageWidth: 1494,
    imageHeight: 1742,
  },
  [ESTWING_GUIDE_SLUG]: {
    slug: ESTWING_GUIDE_SLUG,
    title: "Estwing B3-3LB Drilling Hammer: Durability and Limits",
    description: "A source-checked review of the Estwing B3-3LB 3-lb drilling hammer, including one-piece construction, warranty and repair limits, safety boundaries, and owner tradeoffs.",
    reviewedAt: "2026-09-04",
    asin: "B00002N5NI",
    destinationDescription: "the Estwing B3-3LB 3-lb drilling/crack hammer, ASIN B00002N5NI",
    destinationLabel: "View exact Estwing B3-3LB on Amazon",
    imageWidth: 1800,
    imageHeight: 3264,
  },
  [VICTORINOX_GUIDE_SLUG]: {
    slug: VICTORINOX_GUIDE_SLUG,
    title: "Kitchen Knives That Last: Victorinox Fibrox 8-Inch Evidence Review",
    description: "A source-checked review of the Victorinox Fibrox 5.2063.20 chef’s knife, including edge maintenance, warranty limits, repairability boundaries, and dated owner evidence.",
    reviewedAt: "2026-08-31",
    asin: "B008M5U1C2",
    destinationDescription: "the black Victorinox Fibrox Pro 8-inch chef’s knife, ASIN B008M5U1C2",
    destinationLabel: "View exact Victorinox Fibrox 8-inch on Amazon",
    imageWidth: 1198,
    imageHeight: 674,
  },
} as const;

type RestoredGuideSlug = keyof typeof restoredGuides;
type RestoredGuideConfig = (typeof restoredGuides)[RestoredGuideSlug];

function restoredGuideFor(slug: string): RestoredGuideConfig | undefined {
  return restoredGuides[slug as RestoredGuideSlug];
}

function ExactModelDestination({
  config,
  placement,
}: {
  config: RestoredGuideConfig;
  placement: "decision-start" | "decision-end";
}) {
  return (
    <div className={placement === "decision-start"
      ? "mb-10 rounded-2xl border border-cream-200 bg-white p-6"
      : "mt-12 rounded-2xl border border-forest-200 bg-white p-6"}>
      <AffiliateDisclosure />
      <h2 className="font-serif text-2xl font-bold text-charcoal">
        {placement === "decision-start" ? "Exact model checked" : "Compare the exact model"}
      </h2>
      <p className="mt-3 text-sm leading-relaxed text-charcoal/60">
        The destination below was checked for {config.destinationDescription}. Confirm the model, size, seller, and included items before ordering. Price and availability are shown only by the merchant.
      </p>
      <a
        href={amazonLink(config.asin)}
        data-affiliate-placement={placement}
        target="_blank"
        rel="sponsored nofollow noopener noreferrer"
        className="mt-5 inline-flex rounded-xl bg-forest-500 px-5 py-3 font-semibold text-white hover:bg-forest-600"
      >
        {config.destinationLabel}
      </a>
    </div>
  );
}

export function generateStaticParams() {
  return articles.map((article) => ({ slug: article.slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const article = getArticleBySlug((await params).slug);
  if (!article) return {};
  const canonical = `https://everlasting-goods.com/articles/${article.slug}`;
  const config = restoredGuideFor(article.slug);

  if (config) {
    const imageEvidence = articleImageEvidence[config.slug];
    return {
      title: config.title,
      description: config.description,
      robots: { index: true, follow: true },
      alternates: { canonical },
      openGraph: {
        type: "article",
        title: config.title,
        description: config.description,
        url: canonical,
        images: [{ url: imageEvidence.image, alt: imageEvidence.alt }],
      },
      twitter: {
        card: "summary_large_image",
        title: config.title,
        description: config.description,
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

function RestoredGuide({
  article,
  config,
}: {
  article: NonNullable<ReturnType<typeof getArticleBySlug>>;
  config: RestoredGuideConfig;
}) {
  const content = renderArticleHtml(article.content);
  const canonical = `https://everlasting-goods.com/articles/${article.slug}`;
  const imageEvidence = articleImageEvidence[config.slug];
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: config.title,
    description: config.description,
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
          <h1 className="mt-4 font-serif text-4xl font-bold text-charcoal md:text-5xl">{config.title}</h1>
          <p className="mt-5 max-w-3xl text-lg leading-relaxed text-charcoal/65">{config.description}</p>
          <p className="mt-5 text-sm text-charcoal/45">By Everlasting Goods Editorial Team · Manufacturer and owner sources reviewed {config.reviewedAt}</p>
        </div>
      </section>
      <figure className="mx-auto max-w-5xl px-4 pt-10 sm:px-6 lg:px-8">
        <div className="overflow-hidden rounded-2xl border border-cream-200 bg-white">
          <Image
            src={imageEvidence.image}
            alt={imageEvidence.alt}
            width={config.imageWidth}
            height={config.imageHeight}
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
          This restored guide uses two disclosed links to one independently identity-checked exact-product affiliate destination. It contains no price, rating, availability, or hands-on claim. Manufacturer statements and owner reports are attributed; editorial observations are identified as such.
        </div>
        <ExactModelDestination config={config} placement="decision-start" />
        <div className="article-content" dangerouslySetInnerHTML={{ __html: content }} />
        <ExactModelDestination config={config} placement="decision-end" />
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
  const config = restoredGuideFor(article.slug);

  if (config) {
    return <RestoredGuide article={article} config={config} />;
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
