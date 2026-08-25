import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";

import DatabaseProductCard from "@/components/DatabaseProductCard";
import { categories } from "@/lib/data";
import { databaseProducts } from "@/lib/product-database";

interface PageProps { params: Promise<{ slug: string }> }

export function generateStaticParams() { return categories.map((category) => ({ slug: category.slug })); }

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const slug = (await params).slug;
  if (!categories.some((category) => category.slug === slug)) return {};
  return { title: `${slug === "tools" ? "Tools & Shop Equipment" : "Category"} Evidence Status`, description: "Verified database status for this category.", alternates: { canonical: `https://everlasting-goods.com/categories/${slug}` }, robots: slug === "tools" ? undefined : { index: false, follow: true } };
}

export default async function CategoryStatusPage({ params }: PageProps) {
  const slug = (await params).slug;
  const category = categories.find((item) => item.slug === slug);
  if (!category) notFound();
  const products = slug === "tools" ? databaseProducts : [];
  return <><section className="border-b border-cream-200 bg-white"><div className="mx-auto max-w-7xl px-4 py-14 sm:px-6 lg:px-8"><p className="text-sm font-semibold uppercase tracking-wider text-brown-accent">Category evidence status</p><h1 className="mt-3 font-serif text-5xl font-bold text-charcoal">{slug === "tools" ? "Tools & shop equipment" : category.name}</h1><p className="mt-4 max-w-3xl text-lg text-charcoal/60">{products.length ? `${products.length} manufacturer-documented records are published below.` : "No product record in this category has reached publishable evidence status. Legacy guides remain quarantined."}</p></div></section>{products.length ? <section className="mx-auto max-w-7xl px-4 py-14 sm:px-6 lg:px-8"><div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">{products.map((product) => <DatabaseProductCard key={product.slug} product={product} />)}</div></section> : <section className="mx-auto max-w-3xl px-4 py-20 text-center"><Link href="/database" className="rounded-xl bg-forest-500 px-6 py-3 font-semibold text-white hover:bg-forest-600">Browse verified tools</Link></section>}</>;
}
