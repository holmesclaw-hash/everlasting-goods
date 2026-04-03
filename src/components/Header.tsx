"use client";

import Link from "next/link";
import { useState } from "react";
import { categories } from "@/lib/data";

export default function Header() {
  const [mobileOpen, setMobileOpen] = useState(false);

  return (
    <header className="bg-white/80 backdrop-blur-md border-b border-cream-200 sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16 lg:h-20">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-2 group">
            <div className="w-8 h-8 bg-forest-500 rounded-full flex items-center justify-center">
              <span className="text-white font-serif text-sm font-bold">E</span>
            </div>
            <div className="flex flex-col">
              <span className="font-serif text-lg lg:text-xl font-bold text-charcoal leading-tight tracking-tight">
                Everlasting Goods
              </span>
              <span className="text-[10px] uppercase tracking-[0.2em] text-brown-accent font-medium hidden sm:block">
                Buy It For Life
              </span>
            </div>
          </Link>

          {/* Desktop Nav */}
          <nav className="hidden lg:flex items-center gap-8">
            <Link
              href="/blog"
              className="text-sm font-medium text-charcoal/70 hover:text-forest-500 transition-colors"
            >
              Articles
            </Link>
            <Link
              href="/products"
              className="text-sm font-medium text-charcoal/70 hover:text-forest-500 transition-colors"
            >
              Products
            </Link>
            <div className="relative group">
              <button className="text-sm font-medium text-charcoal/70 hover:text-forest-500 transition-colors flex items-center gap-1">
                Categories
                <svg className="w-3.5 h-3.5 mt-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              <div className="absolute top-full left-1/2 -translate-x-1/2 pt-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                <div className="bg-white rounded-xl shadow-lg border border-cream-200 p-2 min-w-[180px]">
                  {categories.map((cat) => (
                    <Link
                      key={cat.slug}
                      href={`/categories/${cat.slug}`}
                      className="flex items-center gap-2 px-3 py-2 text-sm text-charcoal/70 hover:text-forest-500 hover:bg-cream rounded-lg transition-colors"
                    >
                      <span>{cat.icon}</span>
                      {cat.name}
                    </Link>
                  ))}
                </div>
              </div>
            </div>
            <Link
              href="/about"
              className="text-sm font-medium text-charcoal/70 hover:text-forest-500 transition-colors"
            >
              About
            </Link>
          </nav>

          {/* Mobile hamburger */}
          <button
            onClick={() => setMobileOpen(!mobileOpen)}
            className="lg:hidden p-2 text-charcoal"
            aria-label="Toggle menu"
          >
            {mobileOpen ? (
              <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            ) : (
              <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            )}
          </button>
        </div>
      </div>

      {/* Mobile menu */}
      {mobileOpen && (
        <div className="lg:hidden bg-white border-t border-cream-200">
          <div className="px-4 py-4 space-y-1">
            <Link
              href="/blog"
              onClick={() => setMobileOpen(false)}
              className="block px-3 py-2.5 text-sm font-medium text-charcoal/70 hover:text-forest-500 hover:bg-cream rounded-lg"
            >
              Articles
            </Link>
            <Link
              href="/products"
              onClick={() => setMobileOpen(false)}
              className="block px-3 py-2.5 text-sm font-medium text-charcoal/70 hover:text-forest-500 hover:bg-cream rounded-lg"
            >
              Products
            </Link>
            <div className="px-3 py-2 text-xs uppercase tracking-wider text-charcoal/40 font-medium">
              Categories
            </div>
            {categories.map((cat) => (
              <Link
                key={cat.slug}
                href={`/categories/${cat.slug}`}
                onClick={() => setMobileOpen(false)}
                className="flex items-center gap-2 px-6 py-2 text-sm text-charcoal/70 hover:text-forest-500 hover:bg-cream rounded-lg"
              >
                <span>{cat.icon}</span>
                {cat.name}
              </Link>
            ))}
            <Link
              href="/about"
              onClick={() => setMobileOpen(false)}
              className="block px-3 py-2.5 text-sm font-medium text-charcoal/70 hover:text-forest-500 hover:bg-cream rounded-lg"
            >
              About
            </Link>
          </div>
        </div>
      )}
    </header>
  );
}
