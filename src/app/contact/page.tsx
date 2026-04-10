export default function ContactPage() {
  return (
    <main className="max-w-3xl mx-auto px-4 py-16">
      <h1 className="font-serif text-3xl font-bold text-charcoal mb-8">Contact</h1>
      <div className="prose text-charcoal/70 space-y-4">
        <p><strong>Last updated:</strong> April 10, 2026</p>
        <p>If you have questions about an article, a product recommendation, or a correction we should make, email us at contact@everlasting-goods.com.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Email</h2>
        <p><a href="mailto:contact@everlasting-goods.com">contact@everlasting-goods.com</a></p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">What to include</h2>
        <p>The product or article you are asking about, plus any useful details or links. That saves everyone time.</p>
      </div>
    </main>
  );
}
