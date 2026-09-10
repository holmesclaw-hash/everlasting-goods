import { articleImageEvidence } from "@/content/article-image-evidence.mjs";

const restoredGuideCandidates = [
  {
    slug: "best-estwing-hammers-that-last-a-lifetime",
    title: "Estwing B3-3LB Drilling Hammer Evidence Review",
    description: "One-piece construction, warranty and repair limits, safety boundaries, and owner tradeoffs for the 3-lb drilling hammer.",
    reviewedAt: "2026-09-04",
  },
  {
    slug: "best-kitchen-knives-that-last-a-lifetime",
    title: "Victorinox Fibrox 8-Inch Evidence Review",
    description: "Edge maintenance, warranty limits, repairability boundaries, and dated long-term owner evidence for model 5.2063.20.",
    reviewedAt: "2026-08-31",
  },
  {
    slug: "best-cast-iron-skillets-that-last-forever",
    title: "Lodge 12-Inch Cast-Iron Skillet Evidence Review",
    description: "Maintainable seasoning, warranty exclusions, ownership tradeoffs, and dated owner evidence for the Lodge 12-inch skillet.",
    reviewedAt: "2026-08-30",
  },
  {
    slug: "best-safety-razors-that-last-a-lifetime",
    title: "Safety Razors: Construction and Maintenance",
    description: "Manufacturer-documented materials and blade systems, plus clearly limited owner evidence for the MERKUR 34C.",
    reviewedAt: "2026-08-29",
  },
] as const;

export const restoredGuides = restoredGuideCandidates.filter((guide) => articleImageEvidence[guide.slug]);
export const restoredGuideCount = restoredGuides.length;