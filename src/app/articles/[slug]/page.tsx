import { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";
import {
  articles,
  getArticleBySlug,
  getProductBySlug,
  getRelatedArticles,
  getCategoryBySlug,
  formatDate,
} from "@/lib/data";
import ProductCard from "@/components/ProductCard";
import ArticleCard from "@/components/ArticleCard";
import Newsletter from "@/components/Newsletter";

interface PageProps {
  params: { slug: string };
}

export function generateStaticParams() {
  return articles.map((article) => ({ slug: article.slug }));
}

export function generateMetadata({ params }: PageProps): Metadata {
  const article = getArticleBySlug(params.slug);
  if (!article) return {};

  return {
    title: article.title,
    description: article.excerpt,
    alternates: {
      canonical: `https://everlasting-goods.com/articles/${article.slug}`,
    },
    openGraph: {
      title: article.title,
      description: article.excerpt,
      type: "article",
      publishedTime: article.date,
      authors: [article.author],
      images: [{ url: article.image, width: 1200, height: 630, alt: article.title }],
    },
    twitter: {
      card: "summary_large_image",
      title: article.title,
      description: article.excerpt,
    },
  };
}

function extractHeadings(content: string): { id: string; text: string }[] {
  const regex = /<h2 id="([^"]+)">([^<]+)<\/h2>/g;
  const headings: { id: string; text: string }[] = [];
  let match;
  while ((match = regex.exec(content)) !== null) {
    headings.push({ id: match[1], text: match[2] });
  }
  return headings;
}

function extractFAQs(content: string): { question: string; answer: string }[] {
  const faqRegex = /<div class=['"]faq-item['"]>\s*<h3[^>]*>([^<]+)<\/h3>\s*<p>([\s\S]*?)<\/p>\s*<\/div>/g;
  const faqs: { question: string; answer: string }[] = [];
  let match;
  while ((match = faqRegex.exec(content)) !== null) {
    faqs.push({ question: match[1], answer: match[2].replace(/<[^>]+>/g, "").trim() });
  }
  return faqs;
}

export default function ArticlePage({ params }: PageProps) {
  const article = getArticleBySlug(params.slug);
  if (!article) notFound();

  const category = getCategoryBySlug(article.category);
  const headings = extractHeadings(article.content);
  const recommendedProducts = article.products
    .map(getProductBySlug)
    .filter(Boolean);
  const relatedArticles = getRelatedArticles(article.slug, article.category);
  const faqs = extractFAQs(article.content);

  const articleType = article.products.length > 0 ? "ProductReview" : "Article";

  const articleJsonLd = {
    "@context": "https://schema.org",
    "@type": articleType,
    headline: article.title,
    description: article.excerpt,
    author: { "@type": "Person", name: article.author },
    datePublished: article.date,
    image: article.image,
    publisher: {
      "@type": "Organization",
      name: "Everlasting Goods",
      url: "https://everlasting-goods.com",
      logo: {
        "@type": "ImageObject",
        url: "https://everlasting-goods.com/icon.png",
      },
    },
    mainEntityOfPage: `https://everlasting-goods.com/articles/${article.slug}`,
  };

  const faqJsonLd = faqs.length > 0 ? {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: faqs.map((faq) => ({
      "@type": "Question",
      name: faq.question,
      acceptedAnswer: {
        "@type": "Answer",
        text: faq.answer,
      },
    })),
  } : null;

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(articleJsonLd) }}
      />
      {faqJsonLd && (
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }}
        />
      )}
      {/* Hero */}
      <section className="relative bg-charcoal">
        <Image
          src={article.image}
          alt={article.title}
          fill
          className="object-cover opacity-30"
          priority
          sizes="100vw"
        />
        <div className="relative max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24 text-center">
          {category && (
            <Link
              href={`/categories/${category.slug}`}
              className="inline-block px-3 py-1 bg-forest-500 text-white text-xs font-medium rounded-full uppercase tracking-wider mb-6 hover:bg-forest-600 transition-colors"
            >
              {category.name}
            </Link>
          )}
          <h1 className="font-serif text-3xl md:text-4xl lg:text-5xl font-bold text-white leading-tight">
            {article.title}
          </h1>
          <p className="mt-4 text-white/70 text-lg max-w-2xl mx-auto">
            {article.excerpt}
          </p>
          <div className="mt-6 flex items-center justify-center gap-3 text-sm text-white/50">
            <span>By {article.author}</span>
            <span className="w-1 h-1 bg-white/30 rounded-full" />
            <span>{formatDate(article.date)}</span>
            <span className="w-1 h-1 bg-white/30 rounded-full" />
            <span>{article.readTime}</span>
          </div>
        </div>
      </section>

      {/* Content */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
        <div className="grid grid-cols-1 lg:grid-cols-[1fr_280px] gap-12">
          {/* Article body */}
          <div>
            <div
              className="article-content"
              dangerouslySetInnerHTML={{ __html: article.content }}
            />

            {/* Product recommendations */}
            {recommendedProducts.length > 0 && (
              <div className="mt-12 pt-8 border-t border-cream-200">
                <h2 className="font-serif text-2xl font-bold text-charcoal mb-6">
                  Products Mentioned
                </h2>
                <div className="space-y-4">
                  {recommendedProducts.map(
                    (product) =>
                      product && (
                        <ProductCard
                          key={product.slug}
                          product={product}
                          compact
                        />
                      )
                  )}
                </div>
              </div>
            )}

            {/* Affiliate disclosure */}
            <div className="mt-8 p-4 bg-cream-100 rounded-xl text-xs text-charcoal/50 leading-relaxed">
              <strong className="text-charcoal/70">Affiliate Disclosure:</strong> Everlasting Goods
              earns commissions from qualifying purchases made through affiliate links in this article.
              This doesn&apos;t affect the price you pay or our editorial independence.
            </div>
          </div>

          {/* Sidebar */}
          <aside className="hidden lg:block">
            <div className="sticky top-24 space-y-8">
              {/* Table of Contents */}
              {headings.length > 0 && (
                <div className="bg-white rounded-2xl border border-cream-200 p-6">
                  <h3 className="text-xs uppercase tracking-wider text-charcoal/40 font-medium mb-4">
                    Table of Contents
                  </h3>
                  <nav className="space-y-2">
                    {headings.map((heading) => (
                      <a
                        key={heading.id}
                        href={`#${heading.id}`}
                        className="block text-sm text-charcoal/60 hover:text-forest-500 transition-colors leading-snug py-1"
                      >
                        {heading.text}
                      </a>
                    ))}
                  </nav>
                </div>
              )}

              {/* Quick product links */}
              {recommendedProducts.length > 0 && (
                <div className="bg-white rounded-2xl border border-cream-200 p-6">
                  <h3 className="text-xs uppercase tracking-wider text-charcoal/40 font-medium mb-4">
                    Quick Links
                  </h3>
                  <div className="space-y-3">
                    {recommendedProducts.map(
                      (product) =>
                        product && (
                          <a
                            key={product.slug}
                            href={product.affiliateUrl}
                            target="_blank"
                            rel="noopener noreferrer nofollow"
                            className="flex items-center justify-between gap-2 p-3 bg-cream rounded-xl hover:bg-cream-100 transition-colors group"
                          >
                            <div>
                              <p className="text-xs font-medium text-charcoal leading-snug">
                                {product.name}
                              </p>
                              <p className="text-xs text-forest-500 font-bold mt-0.5">
                                {product.price}
                              </p>
                            </div>
                            <svg
                              className="w-4 h-4 text-charcoal/30 group-hover:text-forest-500 transition-colors flex-shrink-0"
                              fill="none"
                              viewBox="0 0 24 24"
                              stroke="currentColor"
                            >
                              <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={2}
                                d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"
                              />
                            </svg>
                          </a>
                        )
                    )}
                  </div>
                </div>
              )}
            </div>
          </aside>
        </div>
      </section>

      {/* Related Articles */}
      {relatedArticles.length > 0 && (
        <section className="bg-white">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
            <h2 className="font-serif text-2xl md:text-3xl font-bold text-charcoal mb-8">
              Related Articles
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {relatedArticles.map((a) => (
                <ArticleCard key={a.slug} article={a} />
              ))}
            </div>
          </div>
        </section>
      )}

      {/* Newsletter */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
        <Newsletter />
      </section>
    </>
  );
}
