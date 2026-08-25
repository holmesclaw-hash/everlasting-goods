import database from "@/generated/database.json";

export type DatabaseProduct = (typeof database.products)[number];

export const databaseProducts = database.products as DatabaseProduct[];
export const freshnessQueue = database.freshness_queue;

export function getDatabaseProduct(slug: string): DatabaseProduct | undefined {
  return databaseProducts.find((product) => product.slug === slug);
}

export function getDatabaseProductsByCategory(category: string): DatabaseProduct[] {
  return databaseProducts.filter((product) => product.category === category);
}

export const databaseCategories = Array.from(new Set(databaseProducts.map((product) => product.category))).sort();

export function formatCategory(category: string): string {
  return category.split("-").map((part) => part.charAt(0).toUpperCase() + part.slice(1)).join(" ");
}

export function fieldFor(product: DatabaseProduct, name: string) {
  return product.fields.find((field) => field.name === name);
}
