import type { MetadataRoute } from "next";

import database from "@/generated/database.json";
import { databaseCategories } from "@/lib/product-database";

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = "https://everlasting-goods.com";
  const reviewed = new Date("2026-08-25");
  const staticPages: MetadataRoute.Sitemap = [
    { url: baseUrl, lastModified: reviewed, changeFrequency: "weekly", priority: 1 },
    { url: `${baseUrl}/database`, lastModified: reviewed, changeFrequency: "weekly", priority: 1 },
    { url: `${baseUrl}/products`, lastModified: reviewed, changeFrequency: "weekly", priority: 0.9 },
    { url: `${baseUrl}/tools/cost-per-year`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/tools/repair-or-replace`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/about`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.5 },
    { url: `${baseUrl}/methodology`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.6 },
  ];
  const productPages: MetadataRoute.Sitemap = database.products.map((product) => ({ url: `${baseUrl}/database/${product.slug}`, lastModified: new Date(product.last_reviewed_date), changeFrequency: "monthly", priority: 0.8 }));
  const categoryPages: MetadataRoute.Sitemap = databaseCategories.map((category) => ({ url: `${baseUrl}/database/category/${category}`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.7 }));
  return [...staticPages, ...productPages, ...categoryPages];
}
