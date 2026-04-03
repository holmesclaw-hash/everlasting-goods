import Link from "next/link";
import Image from "next/image";
import { Article, formatDate, getCategoryBySlug } from "@/lib/data";

interface ArticleCardProps {
  article: Article;
  featured?: boolean;
}

export default function ArticleCard({ article, featured = false }: ArticleCardProps) {
  const category = getCategoryBySlug(article.category);

  if (featured) {
    return (
      <Link href={`/articles/${article.slug}`} className="group block">
        <article className="bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-md transition-all duration-300 border border-cream-200">
          <div className="relative aspect-[16/9] overflow-hidden">
            <Image
              src={article.image}
              alt={article.title}
              fill
              className="object-cover group-hover:scale-105 transition-transform duration-500"
              sizes="(max-width: 768px) 100vw, 50vw"
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent" />
            {category && (
              <span className="absolute top-4 left-4 px-3 py-1 bg-forest-500 text-white text-xs font-medium rounded-full uppercase tracking-wider">
                {category.name}
              </span>
            )}
          </div>
          <div className="p-6">
            <h3 className="font-serif text-xl lg:text-2xl font-bold text-charcoal group-hover:text-forest-500 transition-colors leading-tight">
              {article.title}
            </h3>
            <p className="mt-3 text-charcoal/60 text-sm leading-relaxed line-clamp-2">
              {article.excerpt}
            </p>
            <div className="mt-4 flex items-center gap-3 text-xs text-charcoal/40">
              <span>{article.author}</span>
              <span className="w-1 h-1 bg-charcoal/20 rounded-full" />
              <span>{formatDate(article.date)}</span>
              <span className="w-1 h-1 bg-charcoal/20 rounded-full" />
              <span>{article.readTime}</span>
            </div>
          </div>
        </article>
      </Link>
    );
  }

  return (
    <Link href={`/articles/${article.slug}`} className="group block">
      <article className="bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-md transition-all duration-300 border border-cream-200 h-full flex flex-col">
        <div className="relative aspect-[16/10] overflow-hidden">
          <Image
            src={article.image}
            alt={article.title}
            fill
            className="object-cover group-hover:scale-105 transition-transform duration-500"
            sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
          />
          {category && (
            <span className="absolute top-3 left-3 px-2.5 py-0.5 bg-forest-500/90 text-white text-[10px] font-medium rounded-full uppercase tracking-wider">
              {category.name}
            </span>
          )}
        </div>
        <div className="p-5 flex flex-col flex-1">
          <h3 className="font-serif text-lg font-bold text-charcoal group-hover:text-forest-500 transition-colors leading-snug">
            {article.title}
          </h3>
          <p className="mt-2 text-charcoal/60 text-sm leading-relaxed line-clamp-2 flex-1">
            {article.excerpt}
          </p>
          <div className="mt-4 flex items-center gap-2 text-xs text-charcoal/40">
            <span>{formatDate(article.date)}</span>
            <span className="w-1 h-1 bg-charcoal/20 rounded-full" />
            <span>{article.readTime}</span>
          </div>
        </div>
      </article>
    </Link>
  );
}
