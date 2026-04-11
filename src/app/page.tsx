import Link from "next/link";
import Image from "next/image";
import { articles, categories } from "@/lib/data";
import ArticleCard from "@/components/ArticleCard";
import CategoryCard from "@/components/CategoryCard";
import Newsletter from "@/components/Newsletter";

export default function HomePage() {
  const latestArticles = articles.slice(0, 3);

  return (
    <>
      {/* Hero */}
      <section className="relative bg-charcoal overflow-hidden">
        <Image
          src="https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?w=1600&h=700&fit=crop"
          alt="Quality goods"
          fill
          className="object-cover opacity-30"
          priority
          sizes="100vw"
        />
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 md:py-32 lg:py-40">
          <div className="max-w-2xl">
            <p className="text-forest-300 text-sm font-medium uppercase tracking-[0.2em] mb-4">
              Buy It For Life
            </p>
            <h1 className="font-serif text-4xl md:text-5xl lg:text-6xl font-bold text-white leading-[1.1]">
              Quality That
              <br />
              <span className="text-forest-300">Outlasts Trends</span>
            </h1>
            <p className="mt-6 text-lg md:text-xl text-white/70 leading-relaxed max-w-lg">
              Expert reviews of durable, long-lasting products worth buying once. Stop replacing. Start investing.
            </p>
            <div className="mt-8 flex flex-col sm:flex-row gap-4">
              <Link
                href="/best-bifl-products"
                className="inline-flex items-center justify-center px-8 py-3.5 bg-forest-500 text-white font-medium rounded-xl hover:bg-forest-600 transition-colors"
              >
                Start with the BIFL Hub
              </Link>
              <Link
                href="/blog"
                className="inline-flex items-center justify-center px-8 py-3.5 bg-white/10 text-white font-medium rounded-xl hover:bg-white/20 transition-colors backdrop-blur-sm border border-white/10"
              >
                Read All Reviews
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* Trust bar */}
      <section className="bg-white border-b border-cream-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
            <div>
              <p className="font-serif text-2xl font-bold text-forest-500">50+</p>
              <p className="text-xs text-charcoal/50 mt-1">Articles Published</p>
            </div>
            <div>
              <p className="font-serif text-2xl font-bold text-forest-500">6</p>
              <p className="text-xs text-charcoal/50 mt-1">Core Categories Covered</p>
            </div>
            <div>
              <p className="font-serif text-2xl font-bold text-forest-500">0</p>
              <p className="text-xs text-charcoal/50 mt-1">Sponsored Reviews</p>
            </div>
            <div>
              <p className="font-serif text-2xl font-bold text-forest-500">1</p>
              <p className="text-xs text-charcoal/50 mt-1">BIFL Hub to Start Here</p>
            </div>
          </div>
        </div>
      </section>

      {/* Latest Articles */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">
        <div className="flex items-end justify-between mb-10">
          <div>
            <p className="text-brown-accent text-sm font-medium uppercase tracking-wider mb-2">
              Latest Reviews
            </p>
            <h2 className="font-serif text-3xl md:text-4xl font-bold text-charcoal">
              Fresh Off the Bench
            </h2>
          </div>
          <Link
            href="/best-bifl-products"
            className="hidden sm:inline-flex items-center gap-1.5 text-sm font-medium text-forest-500 hover:text-forest-600 transition-colors"
          >
            View the full BIFL hub
            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
            </svg>
          </Link>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {latestArticles.map((article) => (
            <ArticleCard key={article.slug} article={article} />
          ))}
        </div>
        <div className="mt-8 text-center sm:hidden">
          <Link
            href="/best-bifl-products"
            className="inline-flex items-center gap-1.5 text-sm font-medium text-forest-500"
          >
            View the full BIFL hub
            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
            </svg>
          </Link>
        </div>
      </section>

      {/* Categories */}
      <section className="bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">
          <div className="text-center mb-12">
            <p className="text-brown-accent text-sm font-medium uppercase tracking-wider mb-2">
              Browse By Category
            </p>
            <h2 className="font-serif text-3xl md:text-4xl font-bold text-charcoal">
              Find Your Forever Gear
            </h2>
            <p className="mt-3 text-charcoal/60 max-w-lg mx-auto">
              From kitchen essentials to everyday carry, we cover the gear that&apos;s worth buying once.
            </p>
            <div className="mt-6">
              <Link
                href="/best-bifl-products"
                className="inline-flex items-center gap-1.5 text-sm font-medium text-forest-500 hover:text-forest-600 transition-colors"
              >
                See every guide in one place
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
                </svg>
              </Link>
            </div>
          </div>
          <div className="grid grid-cols-2 md:grid-cols-3 gap-4 md:gap-6">
            {categories.map((category) => (
              <CategoryCard key={category.slug} category={category} />
            ))}
          </div>
        </div>
      </section>

      {/* BIFL Philosophy */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">
        <div className="grid md:grid-cols-2 gap-12 items-center">
          <div>
            <p className="text-brown-accent text-sm font-medium uppercase tracking-wider mb-2">
              Our Philosophy
            </p>
            <h2 className="font-serif text-3xl md:text-4xl font-bold text-charcoal leading-tight">
              Buy Less, Buy Better
            </h2>
            <p className="mt-4 text-charcoal/60 leading-relaxed">
              In a world of disposable everything, we believe in a different approach. Every product we recommend has been
              researched, tested, and vetted for long-term durability. We don&apos;t chase trends — we find the gear that will still
              be going strong in 10, 20, or 50 years.
            </p>
            <p className="mt-4 text-charcoal/60 leading-relaxed">
              Our reviews are independent and honest. We earn affiliate commissions when you buy through our links, but
              that never influences our recommendations. If a product doesn&apos;t deserve to be called &quot;buy it for life,&quot; it
              doesn&apos;t make the cut.
            </p>
            <Link
              href="/about"
              className="inline-flex items-center gap-1.5 mt-6 text-sm font-medium text-forest-500 hover:text-forest-600 transition-colors"
            >
              Learn more about us
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
              </svg>
            </Link>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div className="bg-cream-100 rounded-2xl p-6 text-center">
              <div className="text-3xl mb-3">🔬</div>
              <h3 className="font-serif font-bold text-charcoal">Tested</h3>
              <p className="text-xs text-charcoal/50 mt-1">Hands-on with every product</p>
            </div>
            <div className="bg-cream-100 rounded-2xl p-6 text-center">
              <div className="text-3xl mb-3">🛡️</div>
              <h3 className="font-serif font-bold text-charcoal">Warranted</h3>
              <p className="text-xs text-charcoal/50 mt-1">Lifetime warranty preferred</p>
            </div>
            <div className="bg-cream-100 rounded-2xl p-6 text-center">
              <div className="text-3xl mb-3">🌍</div>
              <h3 className="font-serif font-bold text-charcoal">Sustainable</h3>
              <p className="text-xs text-charcoal/50 mt-1">Less waste, more value</p>
            </div>
            <div className="bg-cream-100 rounded-2xl p-6 text-center">
              <div className="text-3xl mb-3">💯</div>
              <h3 className="font-serif font-bold text-charcoal">Honest</h3>
              <p className="text-xs text-charcoal/50 mt-1">Unbiased recommendations</p>
            </div>
          </div>
        </div>
      </section>

      {/* Newsletter */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pb-16 md:pb-24">
        <Newsletter />
      </section>
    </>
  );
}
