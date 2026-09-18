PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_1', 'DEWALT ServiceNet DWE7491RS Type 1 parts catalog', 'manufacturer', '2026-09-18'),
  ('https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_2', 'DEWALT ServiceNet DWE7491RS Type 2 parts catalog', 'manufacturer', '2026-09-18'),
  ('https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_10', 'DEWALT ServiceNet DWE7491RS Type 10 parts catalog', 'manufacturer', '2026-09-18'),
  ('https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11', 'DEWALT ServiceNet DWE7491RS Type 11 parts catalog', 'manufacturer', '2026-09-18'),
  ('https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QU/DWE7491RS/11/Instruction_Manual/EN/N531890_DWE7491rs.pdf', 'DEWALT DWE7491RS Type 11 instruction manual', 'manufacturer', '2026-09-18'),
  ('https://www.reddit.com/r/Dewalt/comments/1ilj1dt/do_not_purchase_the_dwe7491_table_saw/', 'Seven-year DWE7491RS owner report and fence tradeoff', 'owner-report', '2026-09-18');

UPDATE sources
SET retrieved_date = '2026-09-18'
WHERE url IN (
  'https://www.dewalt.com/en-us/product/dwe7491rs/10-jobsite-table-saw-and-rolling-stand',
  'https://www.dewalt.com/en-us/support/warranty',
  'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS//p/DWE7491RS_3'
);

UPDATE products
SET variant_notes = 'DWE7491RS uses type-specific documentation and parts catalogs. DEWALT ServiceNet marks Types 10 and 11 live; Types 1, 2, and 3 are discontinued, so owners must match the type number before ordering parts.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Current manufacturer documentation supports type-specific parts lookup, routine owner maintenance, and authorized repair. One exact-model owner reports close to seven years without general problems while also describing gradual fence drift; a single anecdote is not representative durability data, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-09-18'
WHERE id = 6 AND slug = 'dewalt-dwe7491rs';

INSERT OR IGNORE INTO product_sources
SELECT 6, id, 'type-specific parts status' FROM sources
WHERE url = 'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_1';
INSERT OR IGNORE INTO product_sources
SELECT 6, id, 'type-specific parts status' FROM sources
WHERE url = 'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_2';
INSERT OR IGNORE INTO product_sources
SELECT 6, id, 'type-specific parts status' FROM sources
WHERE url = 'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS//p/DWE7491RS_3';
INSERT OR IGNORE INTO product_sources
SELECT 6, id, 'type-specific parts status' FROM sources
WHERE url = 'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_10';
INSERT OR IGNORE INTO product_sources
SELECT 6, id, 'type-specific parts status' FROM sources
WHERE url = 'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11';
INSERT OR IGNORE INTO product_sources
SELECT 6, id, 'current operating and maintenance manual' FROM sources
WHERE url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QU/DWE7491RS/11/Instruction_Manual/EN/N531890_DWE7491rs.pdf';
INSERT OR IGNORE INTO product_sources
SELECT 6, id, 'long-term exact-model owner evidence' FROM sources
WHERE url = 'https://www.reddit.com/r/Dewalt/comments/1ilj1dt/do_not_purchase_the_dwe7491_table_saw/';

UPDATE product_fields
SET raw_value = 'DWE7491RS is a corded 10-inch jobsite table saw package with a rolling stand, 15-amp motor, rack-and-pinion fence, and 32-1/2-inch rip capacity.',
    display_value = 'Corded 10-inch jobsite table saw with rolling stand and 32-1/2-inch rip capacity.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dwe7491rs/10-jobsite-table-saw-and-rolling-stand'),
    verified_date = '2026-09-18',
    reverify_days = 180
WHERE product_id = 6 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'DEWALT ServiceNet publishes type-specific DWE7491RS catalogs. Types 10 and 11 are marked live, while Types 1, 2, and 3 are marked discontinued; individual component availability varies and owners must match the type number.',
    display_value = 'Partial: type-specific ServiceNet catalogs are available, with Types 10 and 11 marked live and older types discontinued.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11'),
    verified_date = '2026-09-18',
    reverify_days = 90
WHERE product_id = 6 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'DEWALT publishes a current Type 11 instruction manual with setup, alignment, operation, cleaning, lubrication, maintenance, and safety procedures. It routes repairs to DEWALT factory or authorized service centers and is not an owner-repair manual.',
    display_value = 'Official Type 11 operating and maintenance manual is available; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QU/DWE7491RS/11/Instruction_Manual/EN/N531890_DWE7491rs.pdf'),
    verified_date = '2026-09-18',
    reverify_days = 180
WHERE product_id = 6 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The Type 11 manual documents owner procedures for fence alignment, dust-system cleanup, and periodic cleaning and lubrication of the height-adjustment screw. It directs repairs, maintenance, and adjustment beyond those procedures to DEWALT factory or authorized service centers.',
    display_value = 'User-serviceable for documented fence alignment, dust cleanup, and height-adjustment screw maintenance; repairs are routed to authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QU/DWE7491RS/11/Instruction_Manual/EN/N531890_DWE7491rs.pdf'),
    verified_date = '2026-09-18',
    reverify_days = 180
WHERE product_id = 6 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'The exact product page lists a 3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee; current DEWALT policy controls eligibility, exclusions, and proof requirements.',
    display_value = '3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee; current DEWALT terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dwe7491rs/10-jobsite-table-saw-and-rolling-stand'),
    verified_date = '2026-09-18',
    reverify_days = 180
WHERE product_id = 6 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-09-18'
WHERE product_id = 6 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  6,
  '3-year limited warranty; 1-year free service; 90-day satisfaction guarantee.',
  'The exact product page lists all three support periods; the general policy defines current coverage and claim requirements.',
  'Normal wear, tool abuse, unauthorized-seller limits, and attempted unauthorized repairs are subject to the current DEWALT policy.',
  (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
  '2026-09-18'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11',
    repair_manual_available = 0,
    repair_manual_url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QU/DWE7491RS/11/Instruction_Manual/EN/N531890_DWE7491rs.pdf',
    serviceability = 'user-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/dewalt/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11'),
    verified_date = '2026-09-18'
WHERE product_id = 6;

UPDATE affiliate_links
SET verified_date = '2026-09-18'
WHERE product_id = 6
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B00F2CGXGG?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '14');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-18');

COMMIT;
