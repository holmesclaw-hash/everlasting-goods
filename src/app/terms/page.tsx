import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Terms of Service",
  description: "Terms governing use of the Everlasting Goods repairability database and decision tools.",
  alternates: { canonical: "https://everlasting-goods.com/terms" },
};

export default function TermsPage() {
  return (
    <main className="max-w-3xl mx-auto px-4 py-16">
      <h1 className="font-serif text-3xl font-bold text-charcoal mb-8">Terms of Service</h1>
      <div className="prose text-charcoal/70 space-y-4">
        <p><strong>Last updated:</strong> August 24, 2026</p>
        <p>By accessing and using everlasting-goods.com, you accept and agree to be bound by these terms.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Content</h2>
        <p>Product records are generated from field-level evidence in the tracked database. T1 identifies documented shop input; T2 identifies manufacturer documentation; T3 requires corroborated owner sources; and T4 displays as not yet verified. No hands-on claim is published without a dated first-party record.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Affiliate Disclosure</h2>
        <p>Everlasting Goods is a participant in the Amazon Services LLC Associates Program, an affiliate advertising program designed to provide a means for sites to earn advertising fees by advertising and linking to Amazon.com. Product links on this site may be affiliate links.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Intellectual Property</h2>
        <p>All site text and design are the property of Everlasting Goods unless otherwise noted. A product image is not published until its source and license basis are recorded in the database.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Limitation of Liability</h2>
        <p>Everlasting Goods shall not be liable for damages arising from use of this website or reliance on database records, calculations, or decision-tool output.</p>
      </div>
    </main>
  );
}
