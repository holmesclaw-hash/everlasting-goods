# Everlasting Goods — Remediation & Repositioning Work Order

**Owner:** Daniel (Holmes)  
**Executor:** Hermes agent  
**Date issued:** 2026-08-25  
**Approval:** Daniel approved execution through all phases on 2026-08-25, with instructions to continue without stopping unless a critical blocker is reached.

## Mission

Reposition everlasting-goods.com from a general BIFL review blog into a **repairability, durability, and true-cost database** for long-lasting products — starting with tools and shop equipment, where DW Design has first-party expertise. The site remains affiliate-monetized but competes on verified structured data and interactive tools, not article volume.

**Operating posture:** exception-driven, low-touch. Daniel budgets roughly one hour per week for flagged decisions and dictated first-party input. Hermes performs the remaining approved work.

## Phase 0 — Standing Rules

1. **Publishing freeze.** No new articles or product pages are published until Phase 1 is complete. Audit-required corrections are the only permitted content changes during the freeze.
2. **Evidence gate.** Every factual claim on the site must trace to a source URL plus retrieval date, or to a tagged first-party note from Daniel. Unsupported claims are removed or rewritten, never backfilled with plausible-sounding sources.
3. **Never invent experience.** No first-person testing or ownership claims, fictional author personas, or fabricated ratings. Experience language must be tagged T1 input from Daniel or attributed to cited owner reports. This is an FTC fake-reviews compliance requirement under 16 CFR Part 465.
4. **Propose-and-confirm.** Destructive deletion batches, structural changes, and monetization changes require a concrete proposal batch. Routine corrections and the phases approved by Daniel may proceed without repeated approval.
5. **No done without evidence.** Completion reports require diffs, URL lists, screenshots, query output, or equivalent evidence.
6. **No scheduler changes.** No cron, launchd, supervisor, or equivalent change without explicit approval.
7. **No paid or contractual actions.** Affiliate-program registrations, paid services, contracts, and payout/account changes remain blocked pending Daniel's explicit action.

## Phase 1 — Evidence-Gated Site Audit

### 1.1 Inventory

Crawl the site's sitemap and produce a manifest containing URL, page type, word count, last modified, audit status, action, and disposition.

### 1.2 Claims ledger

Create a CSV or SQLite ledger with `url`, `claim_text`, `class`, `evidence_url`, `verified_date`, `action`, and `status`. Sweep testing/experience claims, specifications, ratings/scores, prices, and author identity. Verify stand-mixer and rain-jacket articles first, then sweep all pages. All visible bylines and structured author data must use `Everlasting Goods Editorial Team`.

### 1.3 Links and assets

Replace Amazon search-result links with exact-model destinations or remove the recommendation. Resolve every unverified-photo placeholder using legally available affiliate/manufacturer assets, or remove the entry until an image exists. Check affiliate destinations for 404s and dead ASINs.

### 1.4 Disclosure compliance

Place a clear affiliate disclosure near the first affiliate link using a standard component.

### 1.5 Deliverable

Produce the manifest, claims ledger, proposed rewrite diffs, deletion recommendations, and applied-change evidence.

## Phase 2 — Repairability Database Schema

Use a git-tracked SQLite database with schema and migrations as the factual source of truth. Generate pages, tables, and JSON-LD from structured records. Product records cover identity, exact-model affiliate links, image provenance, warranty/support, repairability, economics, verdict, evidence tier, source URL, verification date, and re-verification interval.

### Evidence tiers

- **T1 — First-party:** Daniel/shop notes and photos. Only Daniel can create T1 evidence.
- **T2 — Manufacturer documentation:** official specs, warranty documents, parts catalogs, and manuals.
- **T3 — Corroborated owner reports:** at least three independent cited sources.
- **T4 — Unverified:** displayed as `not yet verified`; never presented as fact.

### Freshness

Prices reverify every 30 days. Warranties and parts availability reverify every 180 days. Stale fields display verification dates and enter the re-verification queue.

## Phase 3 — Category One: Tools & Shop Equipment

Seed approximately 20 deeply verified tool/shop records. Daniel's future T1 input loop is a weekly batch of short product notes and optional shop photos. Hermes must not extend those notes beyond what Daniel states. Generate product records, category hubs, comparison tables, repair-or-replace guides, evidence badges, verification dates, and Product/Review JSON-LD from the database.

Affiliate diversification may be proposed, but registering for programs or accepting terms requires Daniel.

## Phase 4 — Tools & Distribution

1. Cost-per-year calculator driven by database fields.
2. Repair-or-replace tool using product, symptom, repair quote, known failure points, parts costs, and replacements.
3. GEO/AI-citability through stable URLs, structured data, evidence tiers, and verification dates.
4. Separate organic, LLM-referral, direct, and affiliate-program measurement where connected data permits it.

## Cadence & Accountability

The weekly digest contains evidence-backed changes, exceptions, T1 queue, re-verification queue, traffic split, and revenue by program. Scheduler changes are prohibited without explicit approval; digest generation may be implemented as an on-demand command until scheduling is approved.

## Definition of Done

- Phase 1 audit applied cleanly.
- Database live and generating category-one pages with at least 15 records whose core fields are T1 or T2.
- Calculators shipped.
- Two consecutive weekly digests completed with no critical exceptions.

Temporal or account-dependent requirements that cannot be completed in one run must be recorded as critical blockers rather than fabricated as complete.
