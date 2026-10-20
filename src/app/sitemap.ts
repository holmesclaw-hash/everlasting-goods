import type { MetadataRoute } from "next";

import database from "@/generated/database.json";
import { databaseCategories } from "@/lib/product-database";
import { latestCategoryReviewDate, latestReviewDate } from "@/lib/sitemap-freshness.mjs";

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = "https://everlasting-goods.com";
  const reviewed = new Date("2026-08-25");
  const databaseReviewed = new Date(latestReviewDate(database.products) ?? "2026-08-25");
  const staticPages: MetadataRoute.Sitemap = [
    { url: baseUrl, lastModified: databaseReviewed, changeFrequency: "weekly", priority: 1 },
    { url: `${baseUrl}/database`, lastModified: databaseReviewed, changeFrequency: "weekly", priority: 1 },
    { url: `${baseUrl}/products`, lastModified: databaseReviewed, changeFrequency: "weekly", priority: 0.9 },
    { url: `${baseUrl}/blog`, lastModified: new Date("2026-09-14"), changeFrequency: "weekly", priority: 0.8 },
    { url: `${baseUrl}/tools/cost-per-year`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/tools/repair-or-replace`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/articles/best-cast-iron-skillets-that-last-forever`, lastModified: new Date("2026-10-15"), changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/articles/best-estwing-hammers-that-last-a-lifetime`, lastModified: new Date("2026-09-04"), changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/articles/best-kitchen-knives-that-last-a-lifetime`, lastModified: new Date("2026-08-31"), changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/articles/best-safety-razors-that-last-a-lifetime`, lastModified: new Date("2026-10-14"), changeFrequency: "monthly", priority: 0.7 },
    { url: `${baseUrl}/articles/is-a-moccamaster-buy-it-for-life`, lastModified: new Date("2026-10-13"), changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/about`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.5 },
    { url: `${baseUrl}/methodology`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.6 },
    { url: `${baseUrl}/contact`, lastModified: reviewed, changeFrequency: "yearly", priority: 0.3 },
    { url: `${baseUrl}/privacy`, lastModified: reviewed, changeFrequency: "yearly", priority: 0.2 },
    { url: `${baseUrl}/terms`, lastModified: reviewed, changeFrequency: "yearly", priority: 0.2 },
  ];
  const productPages: MetadataRoute.Sitemap = database.products.map((product) => ({ url: `${baseUrl}/database/${product.slug}`, lastModified: new Date(product.last_reviewed_date), changeFrequency: "monthly", priority: 0.8 }));
  const categoryPages: MetadataRoute.Sitemap = databaseCategories.map((category) => ({
    url: `${baseUrl}/database/category/${category}`,
    lastModified: new Date(latestCategoryReviewDate(database.products, category) ?? "2026-08-25"),
    changeFrequency: "monthly",
    priority: 0.7,
  }));
  return [...staticPages, ...productPages, ...categoryPages];
}
