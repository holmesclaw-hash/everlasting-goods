PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.reddit.com/r/airbrush/comments/1hbgdpo/compressor_choice/', 'California Air Tools 8010 multi-year owner report in compressor-choice discussion', 'owner-report', '2026-10-08'),
  ('https://www.reddit.com/r/airbrush/comments/1obm6k7/best_air_compressor_under_500/', 'California Air Tools 8010 few-year owner report in compressor discussion', 'owner-report', '2026-10-08'),
  ('https://airpsi.com/low-noise/california-air-tools-8010-review/', 'Air PSI California Air Tools 8010 model and ASIN corroboration', 'other', '2026-10-08'),
  ('https://www.amazon.com/dp/B00WM1VPKE', 'Amazon exact California Air Tools 8010 destination', 'other', '2026-10-08');

UPDATE sources
SET title = 'California Air Tools 8010 official manual', retrieved_date = '2026-10-08'
WHERE url = 'https://californiaairtools.com/wp-content/uploads/2025/09/8010-Owners-Manual-EN-FR-2025-09-29.pdf';

UPDATE sources
SET title = 'California Air Tools current limited warranty policy', retrieved_date = '2026-10-08'
WHERE url = 'https://californiaairtools.com/wp-content/uploads/2026/02/CAT-WARRANTY-POLICY.pdf';

UPDATE sources
SET title = 'California Air Tools 8010 multi-year owner report in compressor-choice discussion',
    source_type = 'owner-report',
    retrieved_date = '2026-10-08'
WHERE url = 'https://www.reddit.com/r/airbrush/comments/1hbgdpo/compressor_choice/';

UPDATE sources
SET title = 'California Air Tools 8010 few-year owner report in compressor discussion',
    source_type = 'owner-report',
    retrieved_date = '2026-10-08'
WHERE url = 'https://www.reddit.com/r/airbrush/comments/1obm6k7/best_air_compressor_under_500/';

UPDATE sources
SET title = 'Air PSI California Air Tools 8010 model and ASIN corroboration',
    source_type = 'other',
    retrieved_date = '2026-10-08'
WHERE url = 'https://airpsi.com/low-noise/california-air-tools-8010-review/';

UPDATE sources
SET title = 'Amazon exact California Air Tools 8010 destination',
    source_type = 'other',
    retrieved_date = '2026-10-08'
WHERE url = 'https://www.amazon.com/dp/B00WM1VPKE';

INSERT OR IGNORE INTO product_sources
SELECT 14, id, 'exact-model owner report: a few years of use with no complaints; anecdotal and not representative'
FROM sources
WHERE url = 'https://www.reddit.com/r/airbrush/comments/1obm6k7/best_air_compressor_under_500/';

INSERT OR IGNORE INTO product_sources
SELECT 14, id, 'exact-model owner report: years of airbrush use before moving to a larger compressor; anecdotal and not representative'
FROM sources
WHERE url = 'https://www.reddit.com/r/airbrush/comments/1hbgdpo/compressor_choice/';

INSERT OR IGNORE INTO product_sources
SELECT 14, id, 'independent exact model 8010 to ASIN B00WM1VPKE corroboration'
FROM sources
WHERE url = 'https://airpsi.com/low-noise/california-air-tools-8010-review/';

INSERT OR IGNORE INTO product_sources
SELECT 14, id, 'exact Amazon destination; identity is corroborated separately because automated readback reached Amazon validation'
FROM sources
WHERE url = 'https://www.amazon.com/dp/B00WM1VPKE';

UPDATE products
SET last_reviewed_date = '2026-10-08',
    recommendation_reasoning = 'Manufacturer documentation supports routine owner maintenance, troubleshooting, a model-specific parts list, two authorized spare-parts providers, and an authorized service path. Two exact-model owners report multi-year use: one says the 8010 has run for a few years with no complaints, while another identifies the 8010 and says they had one for years before moving to a larger compressor. These reports are anecdotal and do not establish representative durability, so expected service life remains unverified; repair economics and a buy or repair recommendation also remain unverified.'
WHERE id = 14 AND slug = 'california-air-tools-8010';

UPDATE product_fields
SET raw_value = 'The 8010 owner manual includes a model-specific parts list and identifies replacement air filter 90227. The current California Air Tools warranty policy names Master Tool Repair and Jacks Small Engines as authorized spare-parts providers that can be searched by compressor model. Live stock, price, and complete exact-model orderability were not verified.',
    display_value = 'Partial: the manual identifies air filter 90227 and a model-specific parts list, and the current policy names two authorized parts providers; live stock and complete orderability are not verified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://californiaairtools.com/wp-content/uploads/2026/02/CAT-WARRANTY-POLICY.pdf'),
    verified_date = '2026-10-08',
    reverify_days = 180
WHERE product_id = 14 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'The exact 8010 owner manual documents tank draining, air-filter replacement, leak testing, pressure-switch checks, cleaning, storage, troubleshooting, an illustrated parts list, and the manufacturer service route. Repairs beyond those procedures are not presented as owner repairs.',
    display_value = 'User-serviceable for documented routine maintenance and troubleshooting; other repair work routes through manufacturer or authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://californiaairtools.com/wp-content/uploads/2025/09/8010-Owners-Manual-EN-FR-2025-09-29.pdf'),
    verified_date = '2026-10-08',
    reverify_days = 180
WHERE product_id = 14 AND name = 'serviceability';

UPDATE product_fields
SET source_id = (SELECT id FROM sources WHERE url = 'https://californiaairtools.com/wp-content/uploads/2025/09/8010-Owners-Manual-EN-FR-2025-09-29.pdf'),
    verified_date = '2026-10-08',
    reverify_days = 180
WHERE product_id = 14 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact 8010 owner manual documents tank draining, air-filter replacement, leak testing, pressure-switch checks, cleaning, storage, troubleshooting, and an illustrated model-specific parts list. It supplies a manufacturer service route but does not provide internal component-repair procedures.',
    display_value = 'Exact owner manual covers maintenance, troubleshooting, and a model-specific parts list; it is not an internal repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://californiaairtools.com/wp-content/uploads/2025/09/8010-Owners-Manual-EN-FR-2025-09-29.pdf'),
    verified_date = '2026-10-08',
    reverify_days = 180
WHERE product_id = 14 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'California Air Tools currently provides 12 months of parts-and-labor coverage for noncommercial and commercial or rental use, beginning on the original retail purchase date. Coverage is limited to the original retail purchaser buying through an authorized dealer path and requires authorized-service confirmation. Current exclusions include improper setup or maintenance, misuse, abnormal applications, normal wear, and repair or modification without written consent.',
    display_value = '12-month parts and labor limited warranty for the original retail purchaser; authorized-service requirements and current exclusions apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://californiaairtools.com/wp-content/uploads/2026/02/CAT-WARRANTY-POLICY.pdf'),
    verified_date = '2026-10-08',
    reverify_days = 180
WHERE product_id = 14 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-10-08'
WHERE product_id = 14
  AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  14,
  '12 months parts and labor.',
  'The original retail purchaser buying through an authorized dealer path receives repair-or-replacement coverage for defects in material or workmanship after authorized-service verification; transportation remains the customer responsibility.',
  'The current policy excludes normal wear, improper setup or maintenance, accident, abuse, misuse, abnormal applications, unapproved accessories, and unauthorized repair or modification, among other stated limits.',
  (SELECT id FROM sources WHERE url = 'https://californiaairtools.com/wp-content/uploads/2026/02/CAT-WARRANTY-POLICY.pdf'),
  '2026-10-08'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://californiaairtools.com/maintenance-troubleshooting-guide',
    repair_manual_available = 1,
    repair_manual_url = 'https://californiaairtools.com/wp-content/uploads/2025/09/8010-Owners-Manual-EN-FR-2025-09-29.pdf',
    serviceability = 'user-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://californiaairtools.com/wp-content/uploads/2025/09/8010-Owners-Manual-EN-FR-2025-09-29.pdf'),
    verified_date = '2026-10-08'
WHERE product_id = 14;

UPDATE affiliate_links
SET url = 'https://www.amazon.com/dp/B00WM1VPKE?tag=everlastin08f-20',
    exact_model = 1,
    verified_date = '2026-10-08'
WHERE product_id = 14 AND program_name = 'Amazon Associates';

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '39');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-08');

COMMIT;
