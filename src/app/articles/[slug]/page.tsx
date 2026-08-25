import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";

import { articles, getArticleBySlug } from "@/lib/data";

interface PageProps { params: Promise<{ slug: string }> }

export function generateStaticParams() {
  return articles.map((article) => ({ slug: article.slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const article = getArticleBySlug((await params).slug);
  if (!article) return {};
  return {
    title: "Legacy guide under evidence review",
    description: "This legacy guide is unavailable while its claims, links, and product identities are re-verified.",
    robots: { index: false, follow: true },
    alternates: { canonical: `https://everlasting-goods.com/articles/${article.slug}` },
  };
}

export default async function ArticleAuditHoldPage({ params }: PageProps) {
  const article = getArticleBySlug((await params).slug);
  if (!article) notFound();

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
