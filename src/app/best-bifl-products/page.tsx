import { Metadata } from "next";
import Link from "next/link";
import { articles } from "@/lib/data";
import Newsletter from "@/components/Newsletter";

export const metadata: Metadata = {
  title: "Best Buy It For Life Products: The Complete BIFL Guide",
  description:
    "The ultimate guide to Buy It For Life products across every category. Kitchen, EDC, clothing, tools, outdoor, and home — everything worth buying once and keeping forever.",
  openGraph: {
    title: "Best Buy It For Life Products: The Complete BIFL Guide",
    description:
      "Every BIFL product review we've published, organized by category. Find the best durable goods worth buying once.",
    url: "https://everlasting-goods.com/best-bifl-products",
  },
  alternates: {
    canonical: "https://everlasting-goods.com/best-bifl-products",
  },
};

// Category config — slug fragments that map articles to display groups
const CATEGORY_GROUPS: { label: string; emoji: string; keywords: string[] }[] = [
  {
    label: "Kitchen & Cooking",
    emoji: "🍳",
    keywords: ["skillet", "kitchen", "knife", "knives", "dutch", "cookware", "cook", "mixer", "lodge", "cast-iron", "cast_iron", "chef"],
  },
  {
    label: "EDC & Everyday Carry",
    emoji: "🎒",
    keywords: ["backpack", "wallet", "pen", "flashlight", "edc", "pocket", "water-bottle", "water_bottle"],
  },
  {
    label: "Clothing & Footwear",
    emoji: "👢",
    keywords: ["boot", "jean", "denim", "belt", "wool", "merino", "rain-jacket", "rain_jacket", "base-layer", "base_layer", "sock"],
  },
  {
    label: "Tools & Workshop",
    emoji: "🔧",
    keywords: ["hammer", "tool", "woodwork", "garden"],
  },
  {
    label: "Home & Living",
    emoji: "🏠",
    keywords: ["faucet", "blanket", "throw", "home"],
  },
  {
    label: "Gifts & Gift Guides",
    emoji: "🎁",
    keywords: ["gift", "children", "kids", "under-50", "under_50"],
  },
  {
    label: "Watches & Accessories",
    emoji: "⌚",
    keywords: ["watch"],
  },
];

function categorizeArticles(articleList: typeof articles) {
  const assigned = new Set<string>();
  const grouped: { label: string; emoji: string; items: typeof articles }[] = [];

  for (const group of CATEGORY_GROUPS) {
    const matches = articleList.filter((a) => {
      if (assigned.has(a.slug)) return false;
      const text = (a.slug + " " + a.title).toLowerCase();
      return group.keywords.some((kw) => text.includes(kw.replace("_", "-")));
    });
    if (matches.length > 0) {
      matches.forEach((a) => assigned.add(a.slug));
      grouped.push({ ...group, items: matches });
    }
  }

  // Catch-all for anything uncategorized
  const uncategorized = articleList.filter((a) => !assigned.has(a.slug));
  if (uncategorized.length > 0) {
    grouped.push({ label: "More BIFL Guides", emoji: "📋", items: uncategorized });
  }

  return grouped;
}

export default function BIFLHubPage() {
  const grouped = categorizeArticles(articles);
  const totalArticles = articles.length;

  return (
    <>
      {/* Hero */}
      <section className="bg-charcoal text-white">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24 text-center">
          <p className="text-forest-400 text-sm font-medium uppercase tracking-wider mb-3">
            The Complete Guide
          </p>
          <h1 className="font-serif text-3xl md:text-5xl font-bold leading-tight">
            Best Buy It For Life Products
          </h1>
          <p className="mt-6 text-lg text-white/70 leading-relaxed max-w-2xl mx-auto">
            {totalArticles} in-depth reviews across every category. Everything worth buying once and keeping forever — no fluff, no disposable junk.
          </p>
          {/* Category jump links */}
          <div className="mt-8 flex flex-wrap justify-center gap-2">
            {grouped.map((g) => (
              <a
                key={g.label}
                href={`#${g.label.toLowerCase().replace(/[^a-z0-9]+/g, "-")}`}
                className="inline-flex items-center gap-1.5 px-4 py-2 rounded-full bg-white/10 hover:bg-white/20 text-sm text-white/80 transition-colors"
              >
                <span>{g.emoji}</span>
                <span>{g.label}</span>
              </a>
            ))}
          </div>
        </div>
      </section>

      {/* What is BIFL */}
      <section className="bg-white border-b border-cream-200">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <h2 className="font-serif text-2xl font-bold text-charcoal mb-4">What Is "Buy It For Life"?</h2>
          <p className="text-charcoal/70 leading-relaxed">
            Buy It For Life (BIFL) is a philosophy of intentional purchasing — choosing well-made, durable products that last decades instead of cheap alternatives you replace every year. A BIFL product costs more upfront but pays for itself through longevity. The best ones come with lifetime warranties, are repairable, and age beautifully with use.
          </p>
          <p className="mt-4 text-charcoal/70 leading-relaxed">
            Every review on this page evaluates products against the core BIFL criteria: <strong>build quality</strong>, <strong>repairability</strong>, <strong>warranty strength</strong>, and <strong>real-world durability</strong> reported by long-term owners. We link directly to Amazon so you can see current pricing and reviews.
          </p>
        </div>
      </section>

      {/* Category sections */}
      <section className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-16 space-y-16">
        {grouped.map((group) => (
          <div
            key={group.label}
            id={group.label.toLowerCase().replace(/[^a-z0-9]+/g, "-")}
            className="scroll-mt-8"
          >
            <div className="flex items-center gap-3 mb-6 pb-3 border-b border-cream-200">
              <span className="text-2xl">{group.emoji}</span>
              <h2 className="font-serif text-2xl font-bold text-charcoal">{group.label}</h2>
              <span className="ml-auto text-sm text-charcoal/40">{group.items.length} guides</span>
            </div>
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {group.items.map((article) => (
                <Link
                  key={article.slug}
                  href={`/articles/${article.slug}`}
                  className="group block rounded-xl border border-cream-200 bg-white p-5 hover:border-forest-500/40 hover:shadow-sm transition-all"
                >
                  <h3 className="font-serif font-semibold text-charcoal group-hover:text-forest-600 leading-snug transition-colors">
                    {article.title}
                  </h3>
                  {article.excerpt && (
                    <p className="mt-2 text-sm text-charcoal/50 leading-relaxed line-clamp-2">
                      {article.excerpt}
                    </p>
                  )}
                  <p className="mt-3 text-xs text-forest-600 font-medium group-hover:underline">
                    Read guide →
                  </p>
                </Link>
              ))}
            </div>
          </div>
        ))}
      </section>

      {/* Bottom CTA */}
      <section className="bg-white border-t border-cream-200">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-16 text-center">
          <h2 className="font-serif text-2xl font-bold text-charcoal mb-4">
            New Guides Every Week
          </h2>
          <p className="text-charcoal/60 leading-relaxed mb-8">
            We publish new BIFL reviews regularly across every category. Subscribe to get the best picks delivered to your inbox — no spam, just quality recommendations.
          </p>
          <Newsletter />
        </div>
      </section>
    </>
  );
}
