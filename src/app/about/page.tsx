import { Metadata } from "next";
import Newsletter from "@/components/Newsletter";

export const metadata: Metadata = {
  title: "About — Our Buy It For Life Philosophy",
  description:
    "Everlasting Goods is dedicated to finding and reviewing the most durable, long-lasting products worth buying once. Learn about our BIFL philosophy.",
  openGraph: {
    title: "About — Everlasting Goods",
    description:
      "Learn about our mission to help you buy less and buy better.",
  },
};

export default function AboutPage() {
  return (
    <>
      {/* Hero */}
      <section className="bg-white border-b border-cream-200">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24 text-center">
          <p className="text-brown-accent text-sm font-medium uppercase tracking-wider mb-3">
            About Us
          </p>
          <h1 className="font-serif text-3xl md:text-4xl lg:text-5xl font-bold text-charcoal leading-tight">
            We Believe In Buying
            <br />
            <span className="text-forest-500">Things That Last</span>
          </h1>
          <p className="mt-6 text-lg text-charcoal/60 leading-relaxed max-w-2xl mx-auto">
            In a world designed around planned obsolescence, we take a different approach.
            Every product we recommend is built to serve you for years — or decades — to come.
          </p>
        </div>
      </section>

      {/* Story */}
      <section className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">
        <div className="space-y-12">
          <div>
            <h2 className="font-serif text-2xl font-bold text-charcoal mb-4">
              The Problem
            </h2>
            <p className="text-charcoal/70 leading-relaxed">
              We live in a throwaway culture. Products are designed to break, to be replaced, to keep
              you buying. The average American household spends thousands of dollars every year replacing
              items that should have lasted much longer. That waste isn&apos;t just bad for your wallet — it&apos;s
              bad for the planet.
            </p>
          </div>

          <div>
            <h2 className="font-serif text-2xl font-bold text-charcoal mb-4">
              Our Mission
            </h2>
            <p className="text-charcoal/70 leading-relaxed">
              Everlasting Goods exists to help you break free from the cycle of cheap, disposable products.
              We research, test, and review products that are built to last — the kind of gear you buy once
              and never think about again. Whether it&apos;s a cast iron skillet, a pair of boots, or a backpack,
              we find the items that are truly worth your money.
            </p>
          </div>

          <div>
            <h2 className="font-serif text-2xl font-bold text-charcoal mb-4">
              How We Review
            </h2>
            <div className="grid sm:grid-cols-2 gap-6">
              <div className="bg-white rounded-2xl border border-cream-200 p-6">
                <div className="w-10 h-10 bg-forest-500/10 rounded-xl flex items-center justify-center text-forest-500 mb-3">
                  <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                  </svg>
                </div>
                <h3 className="font-serif font-bold text-charcoal mb-1">Research</h3>
                <p className="text-sm text-charcoal/60 leading-relaxed">
                  We start with extensive research — reading reviews, studying materials, and understanding
                  manufacturing processes.
                </p>
              </div>
              <div className="bg-white rounded-2xl border border-cream-200 p-6">
                <div className="w-10 h-10 bg-forest-500/10 rounded-xl flex items-center justify-center text-forest-500 mb-3">
                  <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z" />
                  </svg>
                </div>
                <h3 className="font-serif font-bold text-charcoal mb-1">Testing</h3>
                <p className="text-sm text-charcoal/60 leading-relaxed">
                  We get hands-on with every product we recommend. No armchair reviews — real use, real conditions.
                </p>
              </div>
              <div className="bg-white rounded-2xl border border-cream-200 p-6">
                <div className="w-10 h-10 bg-forest-500/10 rounded-xl flex items-center justify-center text-forest-500 mb-3">
                  <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <h3 className="font-serif font-bold text-charcoal mb-1">Longevity</h3>
                <p className="text-sm text-charcoal/60 leading-relaxed">
                  We verify long-term durability through community reports, warranty analysis, and years of follow-up.
                </p>
              </div>
              <div className="bg-white rounded-2xl border border-cream-200 p-6">
                <div className="w-10 h-10 bg-forest-500/10 rounded-xl flex items-center justify-center text-forest-500 mb-3">
                  <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                  </svg>
                </div>
                <h3 className="font-serif font-bold text-charcoal mb-1">Warranty</h3>
                <p className="text-sm text-charcoal/60 leading-relaxed">
                  We prioritize products backed by meaningful warranties — lifetime guarantees are our gold standard.
                </p>
              </div>
            </div>
          </div>

          <div>
            <h2 className="font-serif text-2xl font-bold text-charcoal mb-4">
              How We Make Money
            </h2>
            <p className="text-charcoal/70 leading-relaxed">
              We earn affiliate commissions when you purchase products through our links. This means we get
              a small percentage of the sale at no additional cost to you. This is how we keep the lights on
              and fund our research.
            </p>
            <p className="mt-3 text-charcoal/70 leading-relaxed">
              <strong>Here&apos;s what we promise:</strong> affiliate commissions never influence our recommendations.
              We recommend products because they&apos;re genuinely great and built to last — not because of the
              commission. If a product doesn&apos;t meet our standards, it doesn&apos;t make the site, regardless of
              how much we&apos;d earn.
            </p>
          </div>

          <div className="bg-forest-500/5 rounded-2xl p-8 border border-forest-500/10">
            <h2 className="font-serif text-2xl font-bold text-charcoal mb-4">
              The BIFL Philosophy
            </h2>
            <blockquote className="text-lg text-charcoal/70 leading-relaxed italic font-serif">
              &ldquo;Buy it nice, or buy it twice.&rdquo;
            </blockquote>
            <p className="mt-4 text-charcoal/70 leading-relaxed">
              The Buy It For Life (BIFL) movement is about making intentional purchasing decisions. Instead of
              buying the cheapest option and replacing it when it inevitably breaks, BIFL advocates investing in
              quality products that last for years, decades, or even generations. It&apos;s better for your wallet in the
              long run, better for the environment, and — honestly — just more satisfying. There&apos;s something deeply
              gratifying about owning gear that works perfectly, year after year.
            </p>
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
