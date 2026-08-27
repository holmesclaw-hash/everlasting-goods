import Link from "next/link";

import EvidenceBadge from "@/components/EvidenceBadge";
import type { DatabaseProduct } from "@/lib/product-database";

interface DatabaseProductCardProps {
  product: DatabaseProduct;
  showAffiliateCta?: boolean;
}

export default function DatabaseProductCard({ product, showAffiliateCta = false }: DatabaseProductCardProps) {
  const affiliateLink = showAffiliateCta ? product.affiliate_links[0] : undefined;

  return (
    <article className="flex flex-col rounded-2xl border border-cream-200 bg-white p-6 transition hover:border-forest-500/40 hover:shadow-sm">
      <Link href={`/database/${product.slug}`} className="block flex-1">
        <div className="flex items-start justify-between gap-4">
          <div>
            <p className="text-xs font-semibold uppercase tracking-wider text-charcoal/45">{product.brand}</p>
            <h2 className="mt-1 font-serif text-xl font-bold text-charcoal">{product.model}</h2>
          </div>
          <EvidenceBadge tier={product.evidence_tier} />
        </div>
        <p className="mt-4 text-sm text-charcoal/60">{product.fields.find((field) => field.name === "identity")?.display_value}</p>
        <div className="mt-5 flex items-center justify-between text-xs text-charcoal/45">
          <span>Reviewed {product.last_reviewed_date}</span>
          <span className="font-semibold text-forest-600">View evidence →</span>
        </div>
      </Link>
      {affiliateLink && (
        <div className="mt-5 border-t border-cream-200 pt-5">
          <a
            href={affiliateLink.url}
            target="_blank"
            rel="sponsored nofollow noopener noreferrer"
            className="block rounded-xl bg-brown-accent px-4 py-3 text-center text-sm font-semibold text-white hover:bg-brown-dark"
          >
            View exact model on Amazon
          </a>
          <p className="mt-2 text-xs leading-relaxed text-charcoal/45">
            Destination verified {affiliateLink.verified_date}. Price and availability are shown only by the merchant.
          </p>
        </div>
      )}
    </article>
  );
}
