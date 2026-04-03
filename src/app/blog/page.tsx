import { Metadata } from "next";
import { articles, categories } from "@/lib/data";
import ArticleCard from "@/components/ArticleCard";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Articles — Buy It For Life Product Reviews",
  description:
    "In-depth reviews of the most durable, long-lasting products money can buy. Expert picks across kitchen, EDC, outdoor, clothing, tools & home.",
  openGraph: {
    title: "Articles — Everlasting Goods",
    description:
      "In-depth reviews of the most durable, long-lasting products money can buy.",
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
