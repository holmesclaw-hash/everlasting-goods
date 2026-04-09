export default function ContactPage() {
  return (
    <main className="max-w-3xl mx-auto px-4 py-16">
      <h1 className="font-serif text-3xl font-bold text-charcoal mb-8">Contact</h1>
      <div className="prose text-charcoal/70 space-y-4">
        <p><strong>Last updated:</strong> April 9, 2026</p>
        <p>If you have a question, feedback, or a product suggestion for Everlasting Goods, email us and we will get back to you as soon as we can.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Email</h2>
        <p>
          <a href="mailto:contact@everlasting-goods.com">contact@everlasting-goods.com</a>
        </p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">What to Send</h2>
        <p>We welcome product tips, correction requests, partnership inquiries, and general questions about our reviews or buying guides.</p>
      </div>
    </main>
  );
}
