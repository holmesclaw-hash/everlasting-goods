import { articleImageEvidence } from "@/content/article-image-evidence.mjs";

const restoredGuideCandidates = [
  {
    slug: "is-a-moccamaster-buy-it-for-life",
    databaseSlug: "moccamaster-kbgv-select-53948",
    title: "Moccamaster K741.64B and KBGV Evidence Review",
    description: "A 15-year-old K741.64B, current KBGV parts and repair support, warranty limits, maintenance, and owner tradeoffs.",
    reviewedAt: "2026-10-13",
    asin: "B093DXS54M",
    destinationVerifiedAt: "2026-10-29",
    destinationLabel: "View exact Moccamaster 53948 KBGV Select on Amazon",
  },
  {
    slug: "best-estwing-hammers-that-last-a-lifetime",
    databaseSlug: "estwing-b3-3lb",
    title: "Estwing B3-3LB Drilling Hammer Evidence Review",
    description: "One-piece construction, warranty and repair limits, safety boundaries, and owner tradeoffs for the 3-lb drilling hammer.",
    reviewedAt: "2026-10-28",
    asin: "B00002N5NI",
    destinationVerifiedAt: "2026-10-29",
    destinationLabel: "View exact Estwing B3-3LB on Amazon",
  },
  {
    slug: "best-kitchen-knives-that-last-a-lifetime",
    databaseSlug: "victorinox-fibrox-5-2063-20",
    title: "Victorinox Fibrox 8-Inch Evidence Review",
    description: "Edge maintenance, warranty limits, repairability boundaries, and dated long-term owner evidence for model 5.2063.20.",
    reviewedAt: "2026-10-06",
    asin: "B008M5U1C2",
    destinationVerifiedAt: "2026-10-29",
    destinationLabel: "View exact Victorinox Fibrox 8-inch on Amazon",
  },
  {
    slug: "best-cast-iron-skillets-that-last-forever",
    databaseSlug: "lodge-l10sk3",
    title: "Lodge 12-Inch Cast-Iron Skillet Evidence Review",
    description: "Maintainable seasoning, warranty exclusions, ownership tradeoffs, and dated owner evidence for the Lodge 12-inch skillet.",
    reviewedAt: "2026-10-15",
    asin: "B00006JSUB",
    destinationVerifiedAt: "2026-10-29",
    destinationLabel: "View exact Lodge L10SK3 on Amazon",
  },
  {
    slug: "best-safety-razors-that-last-a-lifetime",
    databaseSlug: "merkur-34c",
    title: "Safety Razors: Construction and Maintenance",
    description: "Manufacturer-documented materials and blade systems, plus clearly limited owner evidence for the MERKUR 34C.",
    reviewedAt: "2026-10-14",
    asin: "B002A8JO1Q",
    destinationVerifiedAt: "2026-10-29",
    destinationLabel: "View exact MERKUR 34C on Amazon",
  },
] as const;

export const restoredGuides = restoredGuideCandidates.filter((guide) => articleImageEvidence[guide.slug]);
export const restoredGuideCount = restoredGuides.length;