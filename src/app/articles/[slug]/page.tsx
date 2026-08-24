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
  normalizeAmazonAffiliateUrl,
} from "@/lib/data";
import ProductCard from "@/components/ProductCard";
import AffiliateDisclosure from "@/components/AffiliateDisclosure";
import ArticleCard from "@/components/ArticleCard";
import Newsletter from "@/components/Newsletter";
import { articleAuthorJsonLd, publicArticleAuthor } from "@/lib/editorial.mjs";
import { renderArticleHtml } from "@/lib/article-html.mjs";

interface PageProps {
  params: Promise<{ slug: string }>;
}

export function generateStaticParams() {
  return articles.map((article) => ({ slug: article.slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const article = getArticleBySlug(slug);
  if (!article) return {};
  const publicAuthor = publicArticleAuthor(article.author);

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
      authors: [publicAuthor],
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

export default async function ArticlePage({ params }: PageProps) {
  const { slug } = await params;
  const article = getArticleBySlug(slug);
  if (!article) notFound();

  const publicAuthor = publicArticleAuthor(article.author);
  const category = getCategoryBySlug(article.category);
  const normalizedContent = renderArticleHtml(article.content);
  const headings = extractHeadings(normalizedContent);
  const recommendedProducts = article.products
    .map(getProductBySlug)
    .filter(Boolean);
  const hasAffiliateLinks = normalizedContent.includes("amazon.com") || recommendedProducts.length > 0;
  const relatedArticles = getRelatedArticles(article.slug, article.category);
  const faqs = extractFAQs(normalizedContent);

  const articleJsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: article.title,
    description: article.excerpt,
    author: articleAuthorJsonLd(),
    datePublished: article.date,
    dateModified: article.updatedAt ?? article.date,
    image: article.image,
    articleSection: category?.name ?? article.category,
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

  const breadcrumbJsonLd = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      {
        "@type": "ListItem",
        position: 1,
        name: "Home",
        item: "https://everlasting-goods.com",
      },
      {
        "@type": "ListItem",
        position: 2,
        name: "Best BIFL Products",
        item: "https://everlasting-goods.com/best-bifl-products",
      },
      ...(category
        ? [{
            "@type": "ListItem",
            position: 3,
            name: category.name,
            item: `https://everlasting-goods.com/categories/${category.slug}`,
          }]
        : []),
      {
        "@type": "ListItem",
        position: category ? 4 : 3,
        name: article.title,
        item: `https://everlasting-goods.com/articles/${article.slug}`,
      },
    ],
  };

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
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }}
      />
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
            <span>By {publicAuthor}</span>
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
            {hasAffiliateLinks && <AffiliateDisclosure />}
            <div
              className="article-content"
              dangerouslySetInnerHTML={{ __html: normalizedContent }}
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

            {/* Crawl path links */}
            <div className="mt-10 rounded-2xl border border-cream-200 bg-white p-6">
              <h2 className="font-serif text-xl font-bold text-charcoal mb-3">
                Keep Browsing
              </h2>
              <div className="flex flex-wrap gap-3 text-sm">
                <Link
                  href="/best-bifl-products"
                  className="inline-flex items-center rounded-full bg-cream-100 px-4 py-2 text-charcoal/70 hover:bg-cream-200 transition-colors"
                >
                  Full BIFL hub
                </Link>
                <Link
                  href="/blog"
                  className="inline-flex items-center rounded-full bg-cream-100 px-4 py-2 text-charcoal/70 hover:bg-cream-200 transition-colors"
                >
                  All articles
                </Link>
                {category && (
                  <Link
                    href={`/categories/${category.slug}`}
                    className="inline-flex items-center rounded-full bg-cream-100 px-4 py-2 text-charcoal/70 hover:bg-cream-200 transition-colors"
                  >
                    More {category.name.toLowerCase()} guides
                  </Link>
                )}
              </div>
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
                            href={normalizeAmazonAffiliateUrl(product.affiliateUrl)}
                            target="_blank"
                            rel="sponsored nofollow noopener noreferrer"
                            className="flex items-center justify-between gap-2 p-3 bg-cream rounded-xl hover:bg-cream-100 transition-colors group"
                          >
                            <div>
                              <p className="text-xs font-medium text-charcoal leading-snug">
                                {product.name}
                              </p>
                              <p className="text-xs text-charcoal/45 mt-0.5">
                                Check current listing
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
