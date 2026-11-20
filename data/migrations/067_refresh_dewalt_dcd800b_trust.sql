PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-12-brushless-cordless-drilldriver-tool-only', 'DEWALT DCD800B official product page', 'manufacturer', '2026-11-20'),
  ('https://www.toolservicenet.com/en/p/DCD800B', 'DEWALT ServiceNet DCD800B Type 1 parts catalog', 'manufacturer', '2026-11-20'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf', 'DEWALT DCD800 and DCD805 Type 1 instruction manual NA229093', 'manufacturer', '2026-11-20'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif', 'DEWALT DCD800B Type 1 exploded diagram', 'manufacturer', '2026-11-20'),
  ('https://www.amazon.com/dp/B09ZQ4VTXK', 'Amazon exact DEWALT DCD800B destination', 'other', '2026-11-20')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-12-brushless-cordless-drilldriver-tool-only' AS url,
         'current exact tool-only identity, features, downloads, package contents, and product-specific warranty program' AS purpose
  UNION ALL SELECT 'https://www.toolservicenet.com/en/p/DCD800B',
         'current DCD800B Type 1 parts catalog, purchasability, and internally inconsistent stock snapshot'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf',
         'Type 1 operation, maintenance, safety, and service-routing instructions'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif',
         'Type 1 exploded diagram'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/1gtj46k/ntd_i_finally_got_a_dcd800',
         'anecdotal exact-model report after a couple of years of daily cabinet and millwork use'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/1kp2tha/my_brand_new_drill_and_driver',
         'anecdotal exact-model intermittent-operation report after just over two years'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/1cfmgcn/dcd800',
         'anecdotal exact-model use and early chuck-replacement reports'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/1i0ti8r/will_the_dcd800_drill_be_upgraded_like_the_1007',
         'anecdotal exact-model frozen-chuck report'
  UNION ALL SELECT 'https://www.amazon.com/dp/B09ZQ4VTXK',
         'exact-model commercial destination; automated retrieval reached Amazon validation'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'dewalt-dcd800b';

UPDATE products
SET variant_notes = 'DCD800B is the U.S. tool-only package containing one DCD800 drill/driver and one belt hook; battery and charger are sold separately. DCD800 is the drill/driver, while DCD805 is the separate hammer-drill model covered by the shared Type 1 instruction manual.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'DEWALT currently identifies DCD800B as the tool-only 20V MAX XR brushless 1/2-inch drill/driver and publishes Type 1 manuals plus an exploded diagram. The exact Type 1 ServiceNet catalog exposed 26 entries on 2026-11-20, with 25 marked purchasable, including the motor-and-switch assembly, transmission assembly, and chuck. Its stock metadata is internally inconsistent: every entry carries an in-stock status even though the chuck and bag report stock level zero, while the charger is non-purchasable and also reports zero. This is a volatile catalog snapshot, not proof of continued support. Existing exact-model owner reports include a couple of years of daily cabinet and millwork use without problems, intermittent operation beginning just over two years after purchase, and separate early or frozen chuck reports. These anecdotes do not establish representative expected service life or failure rate, so repair economics and a buy-or-repair recommendation remain unverified.',
    last_reviewed_date = '2026-11-20'
WHERE slug = 'dewalt-dcd800b';

UPDATE product_fields
SET raw_value = 'DEWALT identifies DCD800B as the U.S. tool-only DCD800 20V MAX XR brushless cordless 1/2-inch drill/driver package. It has two speed settings of 0-650 and 0-2,000 RPM, a 6.37-inch tool-head length, a 1/2-inch metal ratcheting chuck, and includes one belt hook. Battery and charger are sold separately.',
    display_value = 'DCD800B tool-only 20V MAX XR brushless 1/2-inch drill/driver; 0-650 / 0-2,000 RPM and 6.37-inch tool-head length; battery and charger sold separately.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-12-brushless-cordless-drilldriver-tool-only'),
    verified_date = '2026-11-20',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact DCD800B Type 1 ServiceNet catalog exposed 26 entries on 2026-11-20. Twenty-five were marked purchasable, including the housing, motor-and-switch assembly, transmission assembly, chuck, selector, and LED light. All 26 carried an in-stock status, but the chuck and bag reported stock level zero; the charger was non-purchasable and also reported zero. The internally inconsistent status is a volatile snapshot and does not prove continued stock or complete component coverage.',
    display_value = 'Partial: the Type 1 catalog exposed 26 entries and marked 25 purchasable, including motor-and-switch, transmission, and chuck assemblies; stock metadata was internally inconsistent and continued support is not guaranteed.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en/p/DCD800B'),
    verified_date = '2026-11-20',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'DEWALT publishes the NA229093 Type 1 DCD800 and DCD805 instruction manual covering operation, weekly dry-air vent cleaning, mild-soap exterior cleaning, chuck and accessory procedures, and battery care. It directs repairs, maintenance, and adjustment to factory or authorized service and is not an owner-repair manual.',
    display_value = 'Official Type 1 operating and maintenance manual is available; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf'),
    verified_date = '2026-11-20',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The Type 1 manual documents user maintenance through weekly dry-air vent cleaning, mild-soap exterior cleaning, and ordinary chuck, accessory, and battery procedures. Repairs, maintenance, and adjustment are routed to a DEWALT factory or authorized service center even though ServiceNet lists several major assemblies.',
    display_value = 'User maintenance covers air-vent cleaning and ordinary accessory care; repairs go to DEWALT factory or authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf'),
    verified_date = '2026-11-20',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'The exact DCD800B product page publishes a 3-year limited warranty, 1-year free service, and 90-day money-back guarantee. Eligibility, exclusions, proof requirements, and current claim terms must be confirmed with DEWALT.',
    display_value = '3-year limited warranty, 1-year free service, and 90-day money-back guarantee; current DEWALT terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-12-brushless-cordless-drilldriver-tool-only'),
    verified_date = '2026-11-20',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-20',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'expected_service_life';

UPDATE product_fields
SET verified_date = '2026-11-20',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.toolservicenet.com/en/p/DCD800B',
    repair_manual_available = 0,
    repair_manual_url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en/p/DCD800B'),
    verified_date = '2026-11-20'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b');

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
  '3-year limited warranty; 1-year free service; 90-day money-back guarantee.',
  'The exact DCD800B product page publishes DEWALT''s 3-year limited warranty, 1-year free service, and 90-day money-back guarantee program.',
  'Eligibility, exclusions, proof requirements, and current claim terms must be confirmed with DEWALT for the purchaser and use case.',
  s.id,
  '2026-11-20'
FROM products p
JOIN sources s ON s.url = 'https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-12-brushless-cordless-drilldriver-tool-only'
WHERE p.slug = 'dewalt-dcd800b'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-20'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B09ZQ4VTXK?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '67');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-20');

COMMIT;
