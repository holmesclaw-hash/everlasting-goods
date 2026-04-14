import { Metadata } from "next";
import { articles, categories } from "@/lib/data";
import ArticleCard from "@/components/ArticleCard";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Articles — Buy It For Life Product Reviews",
  description:
    "In-depth reviews of the most durable, long-lasting products money can buy. Expert picks across kitchen, EDC, outdoor, clothing, tools & home.",
  alternates: {
    canonical: "https://everlasting-goods.com/blog",
  },
  openGraph: {
    title: "Articles — Everlasting Goods",
    description:
      "In-depth reviews of the most durable, long-lasting products money can buy.",
    url: "https://everlasting-goods.com/blog",
  },
};

export default function BlogPage() {
  return (
    <>
      {/* Header */}
      <section className="bg-white border-b border-cream-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
          <p className="text-brown-accent text-sm font-medium uppercase tracking-wider mb-2">
            The Journal
          </p>
          <h1 className="font-serif text-3xl md:text-4xl lg:text-5xl font-bold text-charcoal">
            All Articles
          </h1>
          <p className="mt-3 text-charcoal/60 max-w-xl text-lg">
            Deep-dive reviews, buying guides, and care tips for products that last a lifetime.
          </p>
          <div className="mt-5">
            <Link
              href="/best-bifl-products"
              className="inline-flex items-center gap-1.5 text-sm font-medium text-forest-500 hover:text-forest-600 transition-colors"
            >
              Start with the complete BIFL hub
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
              </svg>
            </Link>
          </div>
        </div>
      </section>

      {/* Category filters */}
      <section className="bg-white border-b border-cream-200 sticky top-16 lg:top-20 z-40">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center gap-2 overflow-x-auto py-3 scrollbar-hide">
            <Link
              href="/blog"
              className="flex-shrink-0 px-4 py-1.5 bg-forest-500 text-white text-sm font-medium rounded-full"
            >
              All
            </Link>
            {categories.map((cat) => (
              <Link
                key={cat.slug}
                href={`/categories/${cat.slug}`}
                className="flex-shrink-0 px-4 py-1.5 bg-cream-100 text-charcoal/60 text-sm font-medium rounded-full hover:bg-cream-200 transition-colors"
              >
                {cat.icon} {cat.name}
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* Article grid */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
        <div className="mb-8 rounded-2xl border border-cream-200 bg-cream-100 p-5 md:p-6">
          <h2 className="font-serif text-xl font-bold text-charcoal">
            Looking for the fastest way in?
          </h2>
          <p className="mt-2 text-sm leading-relaxed text-charcoal/60 max-w-2xl">
            Start with the complete BIFL hub for the highest-value guides, or jump straight into a category below if you already know what you are shopping for.
          </p>
          <div className="mt-4 flex flex-wrap gap-3">
            <Link
              href="/best-bifl-products"
              className="inline-flex items-center rounded-full bg-forest-500 px-4 py-2 text-sm font-medium text-white hover:bg-forest-600 transition-colors"
            >
              Open the BIFL hub
            </Link>
            <Link
              href="/products"
              className="inline-flex items-center rounded-full bg-white px-4 py-2 text-sm font-medium text-charcoal/70 hover:bg-cream-200 transition-colors border border-cream-200"
            >
              Browse products
            </Link>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {articles.map((article) => (
            <ArticleCard key={article.slug} article={article} />
          ))}
        </div>

        {/* Pagination placeholder */}
        <div className="mt-12 flex items-center justify-center gap-2">
          <span className="w-10 h-10 flex items-center justify-center bg-forest-500 text-white text-sm font-medium rounded-lg">
            1
          </span>
          <span className="w-10 h-10 flex items-center justify-center bg-cream-100 text-charcoal/40 text-sm font-medium rounded-lg cursor-not-allowed">
            2
          </span>
          <span className="w-10 h-10 flex items-center justify-center bg-cream-100 text-charcoal/40 text-sm font-medium rounded-lg cursor-not-allowed">
            3
          </span>
        </div>
      </section>
    </>
  );
}
