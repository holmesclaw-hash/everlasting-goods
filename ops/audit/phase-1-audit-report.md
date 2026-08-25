# Phase 1 — Evidence-Gated Site Audit Report

**Audit date:** 2026-08-25  
**Scope source:** live sitemap and rendered HTML  
**Status:** corrections implemented locally; deployment evidence pending

## Inventory

- Sitemap rows: **66**
- Legacy article URLs: **54**
- Category hubs: **6**
- Other hubs/directories: **3**
- Static pages: **3**
- HTTP failures during crawl: **0**

Checklist: `ops/audit/page-manifest.csv`  
Applied disposition: `ops/audit/page-manifest-applied.csv`

## Claims sweep

The heuristic sweep produced **929** rows requiring disposition:

- Warranty language: **277**
- Specification language: **284**
- Price language: **307**
- Testing/experience language: **6**
- Rating/score language: **1**
- Legacy author identities: **54**

The rain-jacket guide contained testing-language qualification, while the wider sweep also found unsupported experience-style language in safety razors, garden tools, and desk lamps. All 54 legacy article bodies are quarantined rather than selectively backfilled. Their live URLs render no product claims or affiliate links and carry `noindex`. All source author fields are normalized to `Everlasting Goods Editorial Team`.

Raw ledger: `ops/audit/claims-ledger.csv`  
Applied ledger: `ops/audit/claims-ledger-applied.csv`

## Link and asset sweep

- Amazon links found: **493**
- Amazon search-result links: **239**
- Unverified-photo placeholders: **5**

Legacy recommendations are not migrated into the database. This removes the search-result destinations and photo placeholders from public discovery until exact-model and image-provenance evidence exists. The new database currently publishes no affiliate link and no product photo.

Raw audit: `ops/audit/link-asset-audit.csv`  
Applied audit: `ops/audit/link-asset-audit-applied.csv`

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
- Fifteen T2 tools/shop records with manufacturer sources and verification dates
- Database record pages, generated category comparisons, Product/Review JSON-LD without ratings
- Cost-per-year calculator and evidence-aware repair-or-replace tool
- LLM/organic/direct/referral classification in the consent-gated analytics hook

## Remaining evidence limits

No T1 claims exist because Daniel has not yet supplied product-specific shop notes. Price, expected service life, annual maintenance, known failure points, serviceability, and verdict fields remain T4 unless documented otherwise. No affiliate program registration or scheduler change was attempted.
