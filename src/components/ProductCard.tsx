import Image from "next/image";
import { Product } from "@/lib/data";

interface ProductCardProps {
  product: Product;
  compact?: boolean;
}

export default function ProductCard({ product, compact = false }: ProductCardProps) {
  if (compact) {
    return (
      <div className="bg-white rounded-xl border border-cream-200 p-4 flex gap-4 items-start hover:shadow-md transition-shadow">
        <div className="relative w-20 h-20 rounded-lg overflow-hidden flex-shrink-0">
          <Image
            src={product.image}
            alt={product.name}
            fill
            className="object-cover"
            sizes="80px"
          />
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-xs text-brown-accent font-medium uppercase tracking-wider">
            {product.brand}
          </p>
          <h4 className="font-serif text-base font-bold text-charcoal mt-0.5 leading-snug">
            {product.name}
          </h4>
          <div className="flex items-center gap-2 mt-1.5">
            <span className="text-forest-500 font-bold">{product.price}</span>
            <span className="flex items-center gap-0.5 text-xs text-amber-500">
              {"★".repeat(Math.round(product.rating))}
              <span className="text-charcoal/40 ml-1">{product.rating}</span>
            </span>
          </div>
          <a
            href={product.affiliateUrl}
            target="_blank"
            rel="noopener noreferrer nofollow"
            className="inline-flex items-center gap-1.5 mt-2.5 px-4 py-1.5 bg-forest-500 text-white text-xs font-medium rounded-lg hover:bg-forest-600 transition-colors"
          >
            Check Price on Amazon
            <svg className="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
            </svg>
          </a>
        </div>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-md transition-all duration-300 border border-cream-200 flex flex-col h-full">
      <div className="relative aspect-[4/3] overflow-hidden">
        <Image
          src={product.image}
          alt={product.name}
          fill
          className="object-cover"
          sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
        />
      </div>
      <div className="p-5 flex flex-col flex-1">
        <p className="text-xs text-brown-accent font-medium uppercase tracking-wider">
          {product.brand}
        </p>
        <h3 className="font-serif text-lg font-bold text-charcoal mt-1 leading-snug">
          {product.name}
        </h3>
        <p className="mt-2 text-sm text-charcoal/60 leading-relaxed line-clamp-3 flex-1">
          {product.description}
        </p>
        <div className="mt-4 flex items-center justify-between">
          <div>
            <span className="text-lg font-bold text-forest-500">{product.price}</span>
            <div className="flex items-center gap-0.5 mt-0.5 text-xs text-amber-500">
              {"★".repeat(Math.round(product.rating))}
              <span className="text-charcoal/40 ml-1">{product.rating}/5</span>
            </div>
          </div>
        </div>
        <a
          href={product.affiliateUrl}
          target="_blank"
          rel="noopener noreferrer nofollow"
          className="mt-4 flex items-center justify-center gap-2 w-full px-4 py-2.5 bg-forest-500 text-white text-sm font-medium rounded-xl hover:bg-forest-600 transition-colors"
        >
          Check Price on Amazon
          <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
          </svg>
        </a>
      </div>
    </div>
  );
}
