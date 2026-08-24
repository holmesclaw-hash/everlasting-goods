import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Review Methodology and Editorial Standards",
  description:
    "How Everlasting Goods researches durable products, handles evidence and AI assistance, discloses affiliate relationships, and corrects errors.",
  alternates: {
    canonical: "https://everlasting-goods.com/methodology",
  },
};

export default function MethodologyPage() {
  return (
    <main className="max-w-3xl mx-auto px-4 py-16">
      <p className="text-sm font-medium uppercase tracking-wider text-brown-accent">
        Editorial standards
      </p>
      <h1 className="mt-3 font-serif text-3xl md:text-4xl font-bold text-charcoal">
        How We Research Buy It For Life Products
      </h1>
      <p className="mt-4 text-charcoal/60 leading-relaxed">
        Everlasting Goods publishes evidence-led buying guides under the Everlasting Goods Editorial Team.
        We do not invent human authors, ownership stories, laboratory results, or years of personal use.
      </p>

      <div className="mt-10 prose prose-neutral max-w-none text-charcoal/70">
        <h2>What we evaluate</h2>
        <p>
          We prioritize materials and construction, common failure modes, repairability, replacement parts,
          warranty terms, maintenance requirements, manufacturer documentation, and credible long-term owner reports.
          A product does not qualify merely because it is expensive, popular, or marketed as sustainable.
        </p>

        <h2>Evidence hierarchy</h2>
        <ol>
          <li>Primary manufacturer specifications, manuals, warranty terms, and repair documentation.</li>
          <li>Independent technical or professional sources that identify the exact product or model.</li>
          <li>Consistent long-term owner reports, clearly described as owner reports rather than controlled tests.</li>
          <li>Editorial judgment that explains its assumptions and limitations.</li>
        </ol>

        <h2>Hands-on testing</h2>
        <p>
          We use terms such as “tested,” “used,” or “owned” only when a dated record identifies the tester,
          exact product, method, duration, and results. If that evidence does not exist, the article uses research
          language and says what kind of evidence supports the recommendation.
        </p>

        <h2>AI assistance</h2>
        <p>
          Automated tools may assist with research organization, drafting, link maintenance, and quality checks.
          They may not fabricate experience or evidence. Every publishable change must pass automated tests for
          affiliate attribution, deceptive claims, editorial identity, and build integrity.
        </p>

        <h2>Affiliate relationships</h2>
        <p>
          Some links earn a commission at no extra cost to the buyer. Commission availability does not decide rankings.
          We prefer exact product destinations and remove stale prices or ratings when no approved current data source exists.
          As an Amazon Associate I earn from qualifying purchases.
        </p>

        <h2>Corrections and updates</h2>
        <p>
          Products, warranty terms, and parts support change. If you find an error, send the exact page, product,
          and correction evidence through our <Link href="/contact">contact page</Link>. We correct material errors
          and record substantive updates in the site&apos;s version history.
        </p>
      </div>
    </main>
  );
}
