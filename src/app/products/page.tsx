import { Metadata } from "next";
import { products, categories } from "@/lib/data";
import ProductCard from "@/components/ProductCard";
import AffiliateDisclosure from "@/components/AffiliateDisclosure";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Product Directory — BIFL Products Worth Buying",
  description:
    "Browse our curated directory of buy-it-for-life products. Durable, long-lasting gear across kitchen, EDC, outdoor, clothing, tools & home.",
  openGraph: {
    title: "Product Directory — Everlasting Goods",
    description:
      "Browse our curated directory of buy-it-for-life products.",
  },
};

export default function ProductsPage() {
  return (
    <>
      {/* Header */}
      <section className="bg-white border-b border-cream-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
          <p className="text-brown-accent text-sm font-medium uppercase tracking-wider mb-2">
            The Directory
          </p>
          <h1 className="font-serif text-3xl md:text-4xl lg:text-5xl font-bold text-charcoal">
            BIFL Products
          </h1>
          <p className="mt-3 text-charcoal/60 max-w-xl text-lg">
            Every product here is selected for durable construction, repairability, warranty support, and owner evidence.
          </p>
        </div>
      </section>

      {/* Category filters */}
      <section className="bg-white border-b border-cream-200 sticky top-16 lg:top-20 z-40">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center gap-2 overflow-x-auto py-3 scrollbar-hide">
            <Link
              href="/products"
              className="flex-shrink-0 px-4 py-1.5 bg-forest-500 text-white text-sm font-medium rounded-full"
            >
              All Products
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

      {/* Product grid */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
        <AffiliateDisclosure />
        <div className="mb-8 rounded-2xl border border-cream-200 bg-cream-100 p-5 md:p-6">
          <h2 className="font-serif text-xl font-bold text-charcoal">
            Need context before you buy?
          </h2>
          <p className="mt-2 text-sm leading-relaxed text-charcoal/60 max-w-2xl">
            The product directory is best paired with our full buying guides, where we explain what lasts, what fails first, and which alternatives are worth considering.
          </p>
          <div className="mt-4 flex flex-wrap gap-3">
            <Link
              href="/best-bifl-products"
              className="inline-flex items-center rounded-full bg-forest-500 px-4 py-2 text-sm font-medium text-white hover:bg-forest-600 transition-colors"
            >
              Read the full BIFL hub
            </Link>
            <Link
              href="/blog"
              className="inline-flex items-center rounded-full bg-white px-4 py-2 text-sm font-medium text-charcoal/70 hover:bg-cream-200 transition-colors border border-cream-200"
            >
              Browse all articles
            </Link>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          {products.map((product) => (
            <ProductCard key={product.slug} product={product} />
          ))}
        </div>
      </section>
    </>
  );
}
