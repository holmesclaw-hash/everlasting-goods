"use client";

export default function Newsletter() {
  return (
    <section className="bg-forest-500 rounded-3xl p-8 md:p-12 lg:p-16 text-center">
      <h2 className="font-serif text-2xl md:text-3xl lg:text-4xl font-bold text-white">
        Never Buy Junk Again
      </h2>
      <p className="mt-4 text-forest-100 text-base md:text-lg max-w-xl mx-auto">
        Join 10,000+ readers who get our weekly picks for the best buy-it-for-life products.
        No spam, no fluff — just quality recommendations.
      </p>
      <form
        className="mt-8 flex flex-col sm:flex-row gap-3 max-w-md mx-auto"
        onSubmit={(e) => e.preventDefault()}
      >
        <input
          type="email"
          placeholder="Enter your email"
          className="flex-1 px-5 py-3 rounded-xl text-charcoal placeholder-charcoal/40 bg-white focus:ring-2 focus:ring-brown-accent border-0"
        />
        <button
          type="submit"
          className="px-8 py-3 bg-brown-accent text-white font-medium rounded-xl hover:bg-brown-dark transition-colors whitespace-nowrap"
        >
          Subscribe Free
        </button>
      </form>
      <p className="mt-3 text-xs text-forest-200/60">
        Free forever. Unsubscribe anytime.
      </p>
    </section>
  );
}
