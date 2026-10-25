import type { MetadataRoute } from "next";

import { restoredGuides } from "@/content/restored-guides";
import database from "@/generated/database.json";
import { databaseCategories } from "@/lib/product-database";
import { latestCategoryReviewDate, latestGuideReviewDate, latestReviewDate } from "@/lib/sitemap-freshness.mjs";

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = "https://everlasting-goods.com";
  const reviewed = new Date("2026-08-25");
  const databaseReviewed = new Date(latestReviewDate(database.products) ?? "2026-08-25");
  const guideReviewed = new Date(latestGuideReviewDate(restoredGuides) ?? "2026-08-25");
  const staticPages: MetadataRoute.Sitemap = [
    { url: baseUrl, lastModified: databaseReviewed, changeFrequency: "weekly", priority: 1 },
    { url: `${baseUrl}/database`, lastModified: databaseReviewed, changeFrequency: "weekly", priority: 1 },
    { url: `${baseUrl}/products`, lastModified: databaseReviewed, changeFrequency: "weekly", priority: 0.9 },
    { url: `${baseUrl}/blog`, lastModified: guideReviewed, changeFrequency: "weekly", priority: 0.8 },
    { url: `${baseUrl}/tools/cost-per-year`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.8 },
    { url: `${baseUrl}/tools/repair-or-replace`, lastModified: reviewed, changeFrequency: "monthly", priority: 0.8 },
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
  const guidePages: MetadataRoute.Sitemap = restoredGuides.map((guide) => ({
    url: `${baseUrl}/articles/${guide.slug}`,
    lastModified: new Date(guide.reviewedAt),
    changeFrequency: "monthly",
    priority: guide.slug === "best-safety-razors-that-last-a-lifetime" ? 0.7 : 0.8,
  }));
  return [...staticPages, ...guidePages, ...productPages, ...categoryPages];
}
