import { Metadata } from "next";
import { products, categories } from "@/lib/data";
import ProductCard from "@/components/ProductCard";
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
            Every product here has earned its place. Tested, vetted, and built to last a lifetime.
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
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          {products.map((product) => (
            <ProductCard key={product.slug} product={product} />
          ))}
        </div>
      </section>
    </>
  );
}
