PRAGMA foreign_keys = ON;
BEGIN;

UPDATE sources
SET title = 'Festool CT 26 EI HEPA official product page',
    retrieved_date = '2026-10-01'
WHERE url = 'https://www.festoolusa.com/products/dust-extractors/workshop-dust-extractors/577871---ct-26-ei-hepa-us';

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://media.cdn.festool.io/productmedia/Images/attachment/9f0a0bce-9848-11f0-8a66-005056b3ad01.pdf', 'Festool CT 26/36/48 EI operating instructions', 'manufacturer', '2026-10-01'),
  ('https://www.festoolusa.com/service/repair-service/spare-parts', 'Festool spare-parts ordering page', 'manufacturer', '2026-10-01'),
  ('https://www.festoolusa.com/service/warranty-all-inclusive/service-terms-and-conditions', 'Festool USA Warranty all-inclusive terms', 'manufacturer', '2026-10-01'),
  ('https://www.festoolusa.com/-/media/tts/fcp/festool-usa/downloads/press-releases/festool_2025_springlaunch_press-release.pdf', 'Festool 2025 spring launch press release', 'manufacturer', '2026-10-01'),
  ('https://festoolownersgroup.com/threads/help-me-decide-new-ct-26-ei-or-new-ct-midi-i.77345/', 'Festool Owners Group CT 26 EI owner discussion', 'owner-report', '2026-10-01'),
  ('https://www.amazon.com/dp/B0DYK9VDC1', 'Amazon exact Festool CT 26 EI HEPA destination', 'other', '2026-10-01');

DELETE FROM product_sources WHERE product_id = 11;

INSERT INTO product_sources
SELECT 11, id, 'exact United States order number, identity, package contents, and Bluetooth functions' FROM sources
WHERE url = 'https://www.festoolusa.com/products/dust-extractors/workshop-dust-extractors/577871---ct-26-ei-hepa-us';
INSERT INTO product_sources
SELECT 11, id, 'operating, owner-maintenance, filter, sensor-cleaning, and qualified-repair boundaries' FROM sources
WHERE url = 'https://media.cdn.festool.io/productmedia/Images/attachment/9f0a0bce-9848-11f0-8a66-005056b3ad01.pdf';
INSERT INTO product_sources
SELECT 11, id, 'manufacturer spare-parts availability policy and ordering path' FROM sources
WHERE url = 'https://www.festoolusa.com/service/repair-service/spare-parts';
INSERT INTO product_sources
SELECT 11, id, 'current United States registration, coverage, and exclusion terms' FROM sources
WHERE url = 'https://www.festoolusa.com/service/warranty-all-inclusive/service-terms-and-conditions';
INSERT INTO product_sources
SELECT 11, id, 'spring 2025 United States generation launch date' FROM sources
WHERE url = 'https://www.festoolusa.com/-/media/tts/fcp/festool-usa/downloads/press-releases/festool_2025_springlaunch_press-release.pdf';
INSERT INTO product_sources
SELECT 11, id, 'qualified exact-model short-term owner discussion without multi-year duration evidence' FROM sources
WHERE url = 'https://festoolownersgroup.com/threads/help-me-decide-new-ct-26-ei-or-new-ct-midi-i.77345/';
INSERT INTO product_sources
SELECT 11, id, 'exact-model commercial destination' FROM sources
WHERE url = 'https://www.amazon.com/dp/B0DYK9VDC1';

UPDATE products
SET variant_notes = 'Festool order number 577871 is the United States CT 26 EI HEPA package. It is the EI generation with Bluetooth functions and must not be conflated with the earlier CT 26 E or non-U.S. package variants.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports the exact 577871 package, Bluetooth remote-start functions, owner filter and sensor maintenance, an official spare-parts ordering path with a published ten-year post-discontinuation availability policy, and three-year Warranty all-inclusive terms after timely registration. Festool announced this EI generation for spring 2025, and the exact-model owner discussion located during this refresh is short-term purchasing and use context rather than multi-year ownership evidence. Expected service life and a buy or repair recommendation therefore remain unverified.',
    last_reviewed_date = '2026-10-01'
WHERE id = 11 AND slug = 'festool-ct-26-ei-hepa';

UPDATE product_fields
SET raw_value = 'Festool order number 577871 is the United States CT 26 EI HEPA CLEANTEC mobile dust extractor. The product page documents Bluetooth automatic starting from a compatible battery pack and optional remote control, plus the supplied HEPA main filter, SELFCLEAN filter bag, and smooth suction hose.',
    display_value = 'Order 577871 CT 26 EI HEPA mobile dust extractor with Bluetooth remote-start functions and the documented U.S. package.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.festoolusa.com/products/dust-extractors/workshop-dust-extractors/577871---ct-26-ei-hepa-us'),
    verified_date = '2026-10-01',
    reverify_days = 180
WHERE product_id = 11 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Festool publishes an official spare-parts ordering path and states that original spare parts remain available for at least ten years after product discontinuation. That policy does not prove current orderability for every CT 26 EI component or identify a complete exact-model parts catalog.',
    display_value = 'Partial: Festool states original spare parts remain available for at least 10 years after discontinuation; exact CT 26 EI component orderability is not verified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.festoolusa.com/service/repair-service/spare-parts'),
    verified_date = '2026-10-01',
    reverify_days = 90
WHERE product_id = 11 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Festool publishes current CT 26/36/48 EI operating instructions covering setup, operation, filter-bag and main-filter replacement, fill-level sensor cleaning, troubleshooting, transport, and storage. The document directs repairs to qualified specialists and is not an owner-repair manual.',
    display_value = 'Official operating and maintenance manual is available; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://media.cdn.festool.io/productmedia/Images/attachment/9f0a0bce-9848-11f0-8a66-005056b3ad01.pdf'),
    verified_date = '2026-10-01',
    reverify_days = 180
WHERE product_id = 11 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The operating instructions document owner replacement of the filter bag and main filter, emptying the dust container, cleaning the automatic fill-level sensors, and routine cleaning. Internal repairs and damaged protective devices are directed to a qualified specialist or approved service workshop.',
    display_value = 'User-serviceable for filter bag, main filter, dust-container, and fill-level sensors; internal repairs go to a qualified service specialist.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://media.cdn.festool.io/productmedia/Images/attachment/9f0a0bce-9848-11f0-8a66-005056b3ad01.pdf'),
    verified_date = '2026-10-01',
    reverify_days = 180
WHERE product_id = 11 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Festool USA publishes three-year Warranty all-inclusive terms for eligible new tools purchased from an authorized dealer when the purchaser registers within 30 days and provides proof of purchase. Current exclusions and claim conditions apply.',
    display_value = '3-year Warranty all-inclusive coverage for eligible authorized-dealer purchases registered within 30 days; current terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.festoolusa.com/service/warranty-all-inclusive/service-terms-and-conditions'),
    verified_date = '2026-10-01',
    reverify_days = 180
WHERE product_id = 11 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-10-01'
WHERE product_id = 11 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  11,
  '3-year Warranty all-inclusive coverage after timely registration.',
  'Eligible new tools bought from an authorized dealer receive Festool''s published three-year coverage and service benefits, subject to current terms.',
  'Registration within 30 days and proof of purchase are required; consumables, misuse, improper use, unauthorized modifications, and published exclusions are not covered.',
  (SELECT id FROM sources WHERE url = 'https://www.festoolusa.com/service/warranty-all-inclusive/service-terms-and-conditions'),
  '2026-10-01'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.festoolusa.com/service/repair-service/spare-parts',
    repair_manual_available = 0,
    repair_manual_url = 'https://media.cdn.festool.io/productmedia/Images/attachment/9f0a0bce-9848-11f0-8a66-005056b3ad01.pdf',
    serviceability = 'user-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://media.cdn.festool.io/productmedia/Images/attachment/9f0a0bce-9848-11f0-8a66-005056b3ad01.pdf'),
    verified_date = '2026-10-01'
WHERE product_id = 11;

UPDATE affiliate_links
SET verified_date = '2026-10-01'
WHERE product_id = 11
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B0DYK9VDC1?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '28');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-01');

COMMIT;
