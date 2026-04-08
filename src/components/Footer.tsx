"use client";

import Link from "next/link";
import { categories } from "@/lib/data";

export default function Footer() {
  return (
    <footer className="bg-charcoal text-white/70">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12">
          {/* Brand */}
          <div className="lg:col-span-1">
            <Link href="/" className="flex items-center gap-2 mb-4">
              <div className="w-8 h-8 bg-forest-500 rounded-full flex items-center justify-center">
                <span className="text-white font-serif text-sm font-bold">E</span>
              </div>
              <span className="font-serif text-lg font-bold text-white">
                Everlasting Goods
              </span>
            </Link>
            <p className="text-sm leading-relaxed text-white/50">
              Expert reviews of durable, long-lasting products worth buying once. Quality over quantity, always.
            </p>
          </div>

          {/* Categories */}
          <div>
            <h3 className="text-xs uppercase tracking-wider text-white/40 font-medium mb-4">
              Categories
            </h3>
            <ul className="space-y-2.5">
              {categories.map((cat) => (
                <li key={cat.slug}>
                  <Link
                    href={`/categories/${cat.slug}`}
                    className="text-sm hover:text-forest-300 transition-colors"
                  >
                    {cat.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Site */}
          <div>
            <h3 className="text-xs uppercase tracking-wider text-white/40 font-medium mb-4">
              Site
            </h3>
            <ul className="space-y-2.5">
              <li>
                <Link href="/blog" className="text-sm hover:text-forest-300 transition-colors">
                  Articles
                </Link>
              </li>
              <li>
                <Link href="/best-bifl-products" className="text-sm hover:text-forest-300 transition-colors">
                  BIFL Guide
                </Link>
              </li>
              <li>
                <Link href="/products" className="text-sm hover:text-forest-300 transition-colors">
                  Product Directory
                </Link>
              </li>
              <li>
                <Link href="/about" className="text-sm hover:text-forest-300 transition-colors">
                  About
                </Link>
              </li>
              <li>
                <Link href="/contact" className="text-sm hover:text-forest-300 transition-colors">
                  Contact
                </Link>
              </li>
              <li>
                <Link href="/privacy" className="text-sm hover:text-forest-300 transition-colors">
                  Privacy Policy
                </Link>
              </li>
              <li>
                <Link href="/terms" className="text-sm hover:text-forest-300 transition-colors">
                  Terms of Service
                </Link>
              </li>
            </ul>
          </div>

          {/* Newsletter */}
          <div>
            <h3 className="text-xs uppercase tracking-wider text-white/40 font-medium mb-4">
              Stay Updated
            </h3>
            <p className="text-sm text-white/50 mb-3">
              Get our latest BIFL picks delivered to your inbox.
            </p>
            <form className="flex gap-2" onSubmit={(e) => e.preventDefault()}>
              <input
                type="email"
                placeholder="you@email.com"
                className="flex-1 px-3 py-2 bg-white/10 border border-white/10 rounded-lg text-sm text-white placeholder-white/30 focus:ring-1 focus:ring-forest-400 focus:border-forest-400"
              />
              <button
                type="submit"
                className="px-4 py-2 bg-forest-500 text-white text-sm font-medium rounded-lg hover:bg-forest-600 transition-colors"
              >
                Join
              </button>
            </form>
          </div>
        </div>

        <div className="mt-16 pt-8 border-t border-white/10 space-y-4">
          <div className="flex flex-wrap items-center gap-4 text-xs text-white/30">
            <Link href="/privacy" className="hover:text-forest-300 transition-colors">
              Privacy Policy
            </Link>
            <Link href="/terms" className="hover:text-forest-300 transition-colors">
              Terms of Service
            </Link>
            <Link href="/contact" className="hover:text-forest-300 transition-colors">
              Contact
            </Link>
          </div>
          <div className="flex flex-col sm:flex-row items-center justify-between gap-4">
            <p className="text-xs text-white/30">
              &copy; {new Date().getFullYear()} Everlasting Goods. All rights reserved.
            </p>
            <p className="text-xs text-white/30">
              Affiliate Disclosure: We earn commissions from qualifying purchases through our affiliate links at no extra cost to you.
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}
