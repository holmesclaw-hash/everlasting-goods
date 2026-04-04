export default function ContactPage() {
  return (
    <main className="max-w-3xl mx-auto px-4 py-16">
      <h1 className="font-serif text-3xl font-bold text-charcoal mb-8">Contact Us</h1>
      <div className="prose text-charcoal/70 space-y-4">
        <p>We love hearing from our readers. Whether you have a product suggestion, a question about one of our reviews, or just want to say hello, we&apos;d love to hear from you.</p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Get in Touch</h2>
        <p>The best way to reach us is by email:</p>
        <p><a href="mailto:contact@everlasting-goods.com" className="text-forest-500 hover:text-forest-600 transition-colors font-medium">contact@everlasting-goods.com</a></p>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">What We&apos;d Love to Hear About</h2>
        <ul className="list-disc pl-5 space-y-2">
          <li>Product recommendations or suggestions for future reviews</li>
          <li>Corrections or updates to existing articles</li>
          <li>Partnership and collaboration inquiries</li>
          <li>General feedback about the site</li>
        </ul>
        <h2 className="font-serif text-xl font-bold text-charcoal mt-6">Response Time</h2>
        <p>We aim to respond to all emails within 48 hours. For urgent matters, please include &quot;URGENT&quot; in your subject line.</p>
      </div>
    </main>
  );
}
