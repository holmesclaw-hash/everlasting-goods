PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://fein.com/en_us/tools/wet-dry-dust-extraction/wet-dry-dust-extraction/turbo-i-92035236090', 'FEIN Turbo I 92035236090 official U.S. product page', 'manufacturer', '2026-11-23'),
  ('https://fein.com/fileadmin/Assets/Documents/Products/Instructions/8/c/4/8c4a1f4799718a165f3443ea50b4b3f9-ZBA_34101211210_Turbo_l_ll_20221212.pdf', 'FEIN Turbo I and Turbo II operating and maintenance manual 34101211210', 'manufacturer', '2026-11-23'),
  ('https://etk.fein.de/spc/index.php?r=item%2Flist&id=9768', 'FEIN electronic Turbo I 92035236090 exploded parts catalog', 'manufacturer', '2026-11-23'),
  ('https://fein.com/en_us/services/3-year-fein-plus-warranty', 'FEIN U.S. three-year FEIN PLUS warranty terms and FAQ', 'manufacturer', '2026-11-23'),
  ('https://sawmillcreek.org/threads/fein-turbo-i.233488/', 'Sawmill Creek exact-model FEIN Turbo I ownership thread', 'owner-report', '2026-11-23'),
  ('https://www.lumberjocks.com/threads/fein-turbo-1.345144/', 'LumberJocks FEIN Turbo I seven-to-eight-year owner report', 'owner-report', '2026-11-23'),
  ('https://www.amazon.com/dp/B00K69ILFQ', 'Amazon exact FEIN Turbo I 92035236090 destination', 'other', '2026-11-23')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://fein.com/en_us/tools/wet-dry-dust-extraction/wet-dry-dust-extraction/turbo-i-92035236090' AS url,
         'current exact U.S. identity, package specifications, power-tool switching, capacity, airflow, vacuum, and noise claims' AS purpose
  UNION ALL SELECT 'https://fein.com/fileadmin/Assets/Documents/Products/Instructions/8/c/4/8c4a1f4799718a165f3443ea50b4b3f9-ZBA_34101211210_Turbo_l_ll_20221212.pdf',
         'official operation, filter care, owner-replaceable items, annual inspection, maintenance, and qualified-service boundaries'
  UNION ALL SELECT 'https://etk.fein.de/spc/index.php?r=item%2Flist&id=9768',
         'exact 92035236090 exploded catalog and dated component-availability status snapshot'
  UNION ALL SELECT 'https://fein.com/en_us/services/3-year-fein-plus-warranty',
         'current three-year registration timing, proof requirement, coverage, and exclusions'
  UNION ALL SELECT 'https://sawmillcreek.org/threads/fein-turbo-i.233488/',
         'anecdotal exact-model report progressing from about two to about three years with continued operation and indoor or covered outdoor use'
  UNION ALL SELECT 'https://www.lumberjocks.com/threads/fein-turbo-1.345144/',
         'anecdotal model-labeled Turbo I report describing seven to eight years of effective sander and Domino dust extraction'
  UNION ALL SELECT 'https://www.amazon.com/dp/B00K69ILFQ',
         'exact-model commercial destination for FEIN Turbo I order number 92035236090'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'fein-turbo-i';

UPDATE products
SET variant_notes = '9 20 35 236 09 0, also written 92035236090, is the exact United States and Canada 60 Hz, 120 V, 5.8-gallon FEIN Turbo I package. Turbo I HEPA, Turbo II, and Turbo II HEPA are separate configurations and are not this record.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'FEIN currently identifies 92035236090 as the 120 V Turbo I and publishes an exact exploded catalog with 65 component entries. On 2026-11-23 the catalog marked 52 entries available, 12 available soon, and one assembly aid no longer available; available entries included the container, motor, filters, electronics, socket, switch, wiring harness, antistatic hose connection, and hose. Catalog status and displayed euro pricing do not prove U.S. checkout success, revision compatibility, or future supply. Model-labeled owner evidence is positive but limited: one owner reported obtaining a Turbo I about two years before October 2017 and said in November 2018 that it was still working well, implying roughly three years of use; another owner reported in 2023 that a Fein Turbo I had served for seven or eight years and worked effectively with sanders and a Domino, but did not identify the exact package order number or production revision. These anecdotes do not establish representative expected service life or failure rate, so annual maintenance cost, repair economics, and a buy-or-repair recommendation remain unverified.',
    last_reviewed_date = '2026-11-23'
WHERE slug = 'fein-turbo-i';

UPDATE product_fields
SET raw_value = 'FEIN identifies order number 9 20 35 236 09 0, compact form 92035236090, as the U.S. and Canada 60 Hz, 120 V Turbo I wet/dry dust extractor. The current page states a 5.8-gallon container, 151 cfm maximum airflow at the blower, 98.4 inches of water lift, 67 dB sound pressure, variable suction, and automatic start and stop through the integrated power-tool socket.',
    display_value = 'Turbo I 92035236090: 120 V, 5.8-gallon wet/dry extractor with 151 cfm maximum blower airflow, 98.4 in. water lift, 67 dB sound pressure, and automatic power-tool switching.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://fein.com/en_us/tools/wet-dry-dust-extraction/wet-dry-dust-extraction/turbo-i-92035236090'),
    verified_date = '2026-11-23',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact FEIN electronic catalog for Turbo I 92035236090 exposed 65 component entries on 2026-11-23. It marked 52 available, 12 available soon, and one assembly aid no longer available. Available entries included the container, motor, filters, electronics, integrated socket, switch, wiring harness, antistatic hose connection, and hose. The catalog requires sign-in for cart use and does not prove U.S. checkout success, compatibility with every production revision, or future supply.',
    display_value = 'Partial: the exact catalog exposed 65 entries—52 available, 12 available soon, and one assembly aid no longer available—including motor, filter, electronics, socket, switch, wiring, and hose components.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://etk.fein.de/spc/index.php?r=item%2Flist&id=9768'),
    verified_date = '2026-11-23',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'FEIN publishes the 34101211210 instruction manual for Turbo I, Turbo I HEPA, Turbo II, and Turbo II HEPA. It covers operation, filter and sensor care, owner-replaceable items, maintenance, and service routing. It is an operating and maintenance manual, not a comprehensive internal repair manual.',
    display_value = 'Official operating and maintenance manual is available; it is not an internal repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://fein.com/fileadmin/Assets/Documents/Products/Instructions/8/c/4/8c4a1f4799718a165f3443ea50b4b3f9-ZBA_34101211210_Turbo_l_ll_20221212.pdf'),
    verified_date = '2026-11-23',
    reverify_days = 365
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The manual identifies the fleece filter bag, flat-fold filter, filter cartridge, hose, and tool adapter as owner-replaceable. It directs damaged connections, seals, hoses, power cords, and internal service to qualified personnel or FEIN service using original replacement parts. It also calls for container cleaning after use, filter and sensor care, drying after wet pickup, and a dust-technical inspection at least annually.',
    display_value = 'Shop-serviceable: owner-replaceable filter bag, flat-fold filter, cartridge, hose, and tool adapter; deeper repairs and the annual dust-system inspection are assigned to qualified service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://fein.com/fileadmin/Assets/Documents/Products/Instructions/8/c/4/8c4a1f4799718a165f3443ea50b4b3f9-ZBA_34101211210_Turbo_l_ll_20221212.pdf'),
    verified_date = '2026-11-23',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'FEIN states that eligible products receive a three-year FEIN PLUS warranty after registration within six weeks of purchase. Proof of purchase is required. The published terms cover defects in materials, production, or workmanship and exclude wear parts plus damage from improper use, overload, unsuitable accessories, or unauthorized opening or repair.',
    display_value = '3-year FEIN PLUS warranty after registration within 6 weeks; proof of purchase is required, and wear, improper use, overload, unsuitable accessories, and unauthorized repair are excluded.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://fein.com/en_us/services/3-year-fein-plus-warranty'),
    verified_date = '2026-11-23',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-23',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i')
  AND name IN ('expected_service_life', 'annual_maintenance_cost');

UPDATE product_fields
SET verified_date = '2026-11-23',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://etk.fein.de/spc/index.php?r=item%2Flist&id=9768',
    repair_manual_available = 0,
    repair_manual_url = 'https://fein.com/fileadmin/Assets/Documents/Products/Instructions/8/c/4/8c4a1f4799718a165f3443ea50b4b3f9-ZBA_34101211210_Turbo_l_ll_20221212.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://etk.fein.de/spc/index.php?r=item%2Flist&id=9768'),
    verified_date = '2026-11-23'
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i');

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
)
SELECT
  p.id,
  '3-year FEIN PLUS warranty after timely registration.',
  'FEIN states that registered eligible products receive three years of coverage under the published FEIN PLUS terms, with proof of purchase required.',
  'Registration must be completed within six weeks of purchase; current terms exclude wear parts and damage from improper use, overload, unsuitable accessories, or unauthorized opening or repair.',
  s.id,
  '2026-11-23'
FROM products p
JOIN sources s ON s.url = 'https://fein.com/en_us/services/3-year-fein-plus-warranty'
WHERE p.slug = 'fein-turbo-i'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-23'
WHERE product_id = (SELECT id FROM products WHERE slug = 'fein-turbo-i')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B00K69ILFQ?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '70');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-23');

COMMIT;
