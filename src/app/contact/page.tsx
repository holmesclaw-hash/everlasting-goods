export default function ContactPage() {
  return (
    <main className="max-w-3xl mx-auto px-4 py-16">
      <h1 className="font-serif text-3xl font-bold text-charcoal mb-8">Contact</h1>
      <div className="prose text-charcoal/70 space-y-4">
        <p><strong>Last updated:</strong> April 8, 2026</p>
        <p>If you have questions about an article, product recommendation, affiliate disclosure, or a correction we should make, email us.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Email</h2>
        <p><a href="mailto:contact@everlasting-goods.com">contact@everlasting-goods.com</a></p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">What to Include</h2>
        <p>Please include the article URL or product name you are asking about so we can help quickly.</p>
      </div>
    </main>
  );
}
