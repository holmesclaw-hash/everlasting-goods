import Link from "next/link";
import { newsletterSignupUrl } from "@/lib/newsletter.mjs";

export default function Newsletter() {
  const signupUrl = newsletterSignupUrl(process.env.NEXT_PUBLIC_NEWSLETTER_ACTION);

  return (
    <section className="bg-forest-500 rounded-3xl p-8 md:p-12 lg:p-16 text-center">
      <h2 className="font-serif text-2xl md:text-3xl lg:text-4xl font-bold text-white">
        Durable Gear, No Disposable Junk
      </h2>
      <p className="mt-4 text-forest-100 text-base md:text-lg max-w-xl mx-auto">
        Get researched Buy It For Life guides, maintenance advice, and product updates.
        No fake testing claims and no sponsored rankings.
      </p>
      {signupUrl ? (
        <>
          <form
            action={signupUrl}
            method="post"
            className="mt-8 flex flex-col sm:flex-row gap-3 max-w-md mx-auto"
          >
            <input
              type="email"
              name="email"
              required
              autoComplete="email"
              aria-label="Email address"
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
            Unsubscribe anytime.
          </p>
        </>
      ) : (
        <Link
          href="/blog"
          className="mt-8 inline-flex px-8 py-3 bg-brown-accent text-white font-medium rounded-xl hover:bg-brown-dark transition-colors"
        >
          Browse the latest guides
        </Link>
      )}
    </section>
  );
}
