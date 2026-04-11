import { Metadata } from "next";
import { notFound } from "next/navigation";
import {
  categories,
  getCategoryBySlug,
  getArticlesByCategory,
  getProductsByCategory,
} from "@/lib/data";
import ArticleCard from "@/components/ArticleCard";
import ProductCard from "@/components/ProductCard";
import Link from "next/link";

interface PageProps {
  params: { slug: string };
}

export function generateStaticParams() {
  return categories.map((cat) => ({ slug: cat.slug }));
}

export function generateMetadata({ params }: PageProps): Metadata {
  const category = getCategoryBySlug(params.slug);
  if (!category) return {};

  return {
    title: `${category.name} — Buy It For Life ${category.name} Reviews`,
    description: category.description,
    alternates: {
      canonical: `https://everlasting-goods.com/categories/${category.slug}`,
    },
    openGraph: {
      title: `${category.name} — Everlasting Goods`,
      description: category.description,
      url: `https://everlasting-goods.com/categories/${category.slug}`,
    },
  };
}

export default function CategoryPage({ params }: PageProps) {
  const category = getCategoryBySlug(params.slug);
  if (!category) notFound();

  const categoryArticles = getArticlesByCategory(params.slug);
  const categoryProducts = getProductsByCategory(params.slug);

  return (
    <>
      {/* Header */}
      <section className="bg-white border-b border-cream-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
          <div className="flex items-center gap-3 mb-4">
            <span className="text-4xl">{category.icon}</span>
            <div>
              <p className="text-brown-accent text-sm font-medium uppercase tracking-wider">
                Category
              </p>
              <h1 className="font-serif text-3xl md:text-4xl lg:text-5xl font-bold text-charcoal">
                {category.name}
              </h1>
            </div>
          </div>
          <p className="mt-2 text-charcoal/60 max-w-xl text-lg">
            {category.description}
          </p>
          <div className="mt-5">
            <Link
              href="/best-bifl-products"
              className="inline-flex items-center gap-1.5 text-sm font-medium text-forest-500 hover:text-forest-600 transition-colors"
            >
              Browse the complete BIFL hub
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
              </svg>
            </Link>
          </div>
        </div>
      </section>

      {/* Category nav */}
      <section className="bg-white border-b border-cream-200 sticky top-16 lg:top-20 z-40">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center gap-2 overflow-x-auto py-3 scrollbar-hide">
            <Link
              href="/blog"
              className="flex-shrink-0 px-4 py-1.5 bg-cream-100 text-charcoal/60 text-sm font-medium rounded-full hover:bg-cream-200 transition-colors"
            >
              All
            </Link>
            {categories.map((cat) => (
              <Link
                key={cat.slug}
                href={`/categories/${cat.slug}`}
                className={`flex-shrink-0 px-4 py-1.5 text-sm font-medium rounded-full transition-colors ${
                  cat.slug === params.slug
                    ? "bg-forest-500 text-white"
                    : "bg-cream-100 text-charcoal/60 hover:bg-cream-200"
                }`}
              >
                {cat.icon} {cat.name}
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* Articles */}
      {categoryArticles.length > 0 && (
        <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
          <h2 className="font-serif text-2xl md:text-3xl font-bold text-charcoal mb-8">
            {category.name} Articles
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {categoryArticles.map((article) => (
              <ArticleCard key={article.slug} article={article} />
            ))}
          </div>
        </section>
      )}

      {/* Products */}
      {categoryProducts.length > 0 && (
        <section className="bg-white">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
            <h2 className="font-serif text-2xl md:text-3xl font-bold text-charcoal mb-8">
              {category.name} Products
            </h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
              {categoryProducts.map((product) => (
                <ProductCard key={product.slug} product={product} />
              ))}
            </div>
          </div>
        </section>
      )}

      {/* Empty state */}
      {categoryArticles.length === 0 && categoryProducts.length === 0 && (
        <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 text-center">
          <p className="text-4xl mb-4">{category.icon}</p>
          <h2 className="font-serif text-2xl font-bold text-charcoal">
            Coming Soon
          </h2>
          <p className="mt-2 text-charcoal/60">
            We&apos;re working on reviews for {category.name.toLowerCase()} products. Check back soon!
          </p>
          <Link
            href="/blog"
            className="inline-flex items-center gap-1.5 mt-6 text-sm font-medium text-forest-500 hover:text-forest-600 transition-colors"
          >
            Browse all articles
            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
            </svg>
          </Link>
        </section>
      )}
    </>
  );
}
