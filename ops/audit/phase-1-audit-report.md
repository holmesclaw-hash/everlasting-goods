# Phase 1 — Evidence-Gated Site Audit Report

**Audit date:** 2026-08-25  
**Scope source:** live sitemap and rendered HTML  
**Status:** applied and live-verified on 2026-08-25

## Inventory

- Sitemap rows: **66**
- Legacy article URLs: **54**
- Category hubs: **6**
- Other hubs/directories: **3**
- Static sitemap pages: **3**
- Published legal/contact routes missing from the pre-change sitemap: **3** (`/contact`, `/privacy`, `/terms`)
- HTTP failures during crawl: **0**

Checklist: `ops/audit/page-manifest.csv`  
Applied disposition: `ops/audit/page-manifest-applied.csv`

## Claims sweep

The heuristic sweep produced **929** rows requiring disposition:

- Warranty language: **277**
- Specification language: **284**
- Price language: **307**
- Testing/experience candidates from the heuristic ledger: **6**
- High-confidence unsupported hands-on assertions from the independent source audit: **7 lines on 5 pages**
- Rating/score language: **1**
- Legacy author identities: **54**

The independent source audit confirmed unsupported hands-on assertions in wallets, stand mixers, garden tools, tool sets, and bath towels. It also found testing/comparison-methodology language in cast iron, backpacks, rain jackets, denim, and safety razors. All 54 legacy article bodies are quarantined rather than selectively backfilled. Their live URLs render no product claims or affiliate links and carry `noindex`. All source author fields are normalized to `Everlasting Goods Editorial Team`.

Raw ledger: `ops/audit/claims-ledger.csv`  
Applied ledger: `ops/audit/claims-ledger-applied.csv`

## Link and asset sweep

- Amazon links found: **493**
- Amazon search-result links: **239**
- Products with unresolved photo provenance: **6 of 6 legacy products**
- Live placeholder-card instances before remediation: **20 across 11 pages**

Legacy recommendations are not migrated into the database. This removes the search-result destinations and photo placeholders from public discovery until exact-model and image-provenance evidence exists. The new database currently publishes no affiliate link and no product photo.

Raw audit: `ops/audit/link-asset-audit.csv`  
Applied audit: `ops/audit/link-asset-audit-applied.csv`

## Structural and link anomalies

- Near-duplicate pairs: milestone-watch guides (cosine similarity 0.817) and Dutch-oven guides (0.751).
- Safety razors had competing source bodies in `src/lib/data.ts` and `src/content/safety-razors.mjs`.
- Confirmed internal 404: `/articles/best-buy-it-for-life-wallets`, referenced twice in quarantined legacy prose.
- Empty `href="#"` links: nine occurrences across three quarantined articles.
- Confirmed external 404: the former buyitforlife.com Estwing source URL.
- Rendered asset audit: 74 unique assets checked; zero confirmed broken live assets.

These defects no longer render publicly because the affected legacy bodies are quarantined. The three previously omitted legal/contact routes are now explicitly included in the generated sitemap.

## Disclosure

The pre-change crawl found **0** pages where an affiliate link preceded the standard disclosure. The repositioned database currently contains no affiliate links. The existing standard disclosure component remains available and is required before any exact-model affiliate link is added.

Evidence: `ops/audit/disclosure-audit.csv`

## Deletion recommendations

All 54 legacy article URLs are recommended for traffic-informed rebuild-or-delete review. This implementation does **not** delete them: it preserves each URL as a noindex evidence-review notice. Specific destructive deletion approval can therefore be handled as a later exception batch without leaving unsupported claims live.

Evidence: `ops/audit/deletion-recommendations.csv`

## Applied architecture

- Git-tracked SQLite database: `data/everlasting.db`
- Schema/migrations: `data/migrations/`
- Generated web view: `src/generated/database.json`
- Sixteen T2 tools/shop records with manufacturer sources and verification dates
- Database record pages, generated category comparisons, Product/Review JSON-LD without ratings
- Cost-per-year calculator and evidence-aware repair-or-replace tool
- LLM/organic/direct/referral classification in the consent-gated analytics hook

## Remaining evidence limits

No T1 claims exist because Daniel has not yet supplied product-specific shop notes. Price, expected service life, annual maintenance, known failure points, serviceability, and verdict fields remain T4 unless documented otherwise. No affiliate program registration or scheduler change was attempted.

## Deployment verification

All 31 sitemap routes returned HTTP 200 with unique URLs and route-level canonicals. All 16 database record routes, five generated category routes, and the contact/privacy/terms routes were present. Fifty-four quarantined legacy article URLs returned HTTP 200 with `noindex`, the evidence-review notice, and no Amazon link. Live sitemap pages contained zero Amazon search-result links, zero product-photo placeholders, and zero legacy author names. The consent-gated bundle contained `referral_visit`, `affiliate_click`, and the consent key. Exact manufacturer manuals and parts catalogs from the independent follow-up research are registered for the reconciled records.

Machine evidence: `ops/audit/deployment-verification.json`
