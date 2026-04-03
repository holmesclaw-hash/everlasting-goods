import Link from "next/link";
import Image from "next/image";
import { Category } from "@/lib/data";

export default function CategoryCard({ category }: { category: Category }) {
  return (
    <Link
      href={`/categories/${category.slug}`}
      className="group relative block rounded-2xl overflow-hidden aspect-[4/3] bg-charcoal"
    >
      <Image
        src={category.image}
        alt={category.name}
        fill
        className="object-cover opacity-60 group-hover:opacity-40 group-hover:scale-105 transition-all duration-500"
        sizes="(max-width: 768px) 50vw, 33vw"
      />
      <div className="absolute inset-0 flex flex-col items-center justify-center text-white p-4">
        <span className="text-3xl mb-2">{category.icon}</span>
        <h3 className="font-serif text-xl font-bold">{category.name}</h3>
        <p className="text-xs text-white/70 mt-1 text-center max-w-[200px] leading-relaxed hidden sm:block">
          {category.description}
        </p>
      </div>
    </Link>
  );
}
