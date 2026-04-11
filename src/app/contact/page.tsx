export default function ContactPage() {
  return (
    <main className="max-w-3xl mx-auto px-4 py-16">
      <h1 className="font-serif text-3xl font-bold text-charcoal mb-8">Contact</h1>
      <div className="prose text-charcoal/70 space-y-4">
        <p><strong>Last updated:</strong> April 11, 2026</p>
        <p>If you have a question, product suggestion, correction, or partnership inquiry, send us an email.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Email</h2>
        <p>
          Reach us at <a href="mailto:contact@everlasting-goods.com">contact@everlasting-goods.com</a>.
        </p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">What to Include</h2>
        <p>If you are asking about a product recommendation, include the category, your budget, and how you plan to use it. That makes a useful reply much easier.</p>
      </div>
    </main>
  );
}
