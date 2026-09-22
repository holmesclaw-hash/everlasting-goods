PRAGMA foreign_keys = ON;
BEGIN;

UPDATE sources
SET url = 'https://www.dewalt.com/en-us/product/dcd800d1e1/20v-max-xr-brushless-cordless-12-drilldriver-kit',
    title = 'DEWALT DCD800D1E1 official product page',
    retrieved_date = '2026-09-22'
WHERE url = 'https://www.dewalt.com/en-us/product/dcd800d1e1/dewalt-20v-max-xr-brushless-cordless-12-drilldriver-kit';

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only', 'DEWALT DCD800B tool-body product and downloads page', 'manufacturer', '2026-09-22'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf', 'DEWALT DCD800 and DCD805 Type 1 instruction manual', 'manufacturer', '2026-09-22'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif', 'DEWALT DCD800 Type 1 exploded diagram', 'manufacturer', '2026-09-22'),
  ('https://www.dewalt.com/en-us/support', 'DEWALT support and ServiceNet overview', 'manufacturer', '2026-09-22'),
  ('https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams?sort_by=votes', 'DEWALT manuals, parts lists, and diagrams support', 'manufacturer', '2026-09-22'),
  ('https://support.dewalt.com/hc/en-us/articles/360012589737-Can-I-order-replacement-parts-from-DEWALT-', 'DEWALT replacement-parts ordering support', 'manufacturer', '2026-09-22'),
  ('https://www.reddit.com/r/Dewalt/comments/1cfmgcn/dcd800', 'DCD800 owner use and early chuck-replacement reports', 'owner-report', '2026-09-22'),
  ('https://www.reddit.com/r/Dewalt/comments/1i0ti8r/will_the_dcd800_drill_be_upgraded_like_the_1007', 'DCD800 owner frozen-chuck report', 'owner-report', '2026-09-22'),
  ('https://www.reddit.com/r/Dewalt/comments/15qvarj/broken_chuck', 'Used DCD800 chuck failure and warranty-repair report', 'owner-report', '2026-09-22'),
  ('https://www.amazon.com/dp/B00EOOZT5E', 'Amazon DCD800D1E1 exact-model listing', 'other', '2026-09-22');

DELETE FROM product_sources WHERE product_id = 1;

INSERT INTO product_sources
SELECT 1, id, 'exact kit identity, package, and warranty periods' FROM sources
WHERE url = 'https://www.dewalt.com/en-us/product/dcd800d1e1/20v-max-xr-brushless-cordless-12-drilldriver-kit';
INSERT INTO product_sources
SELECT 1, id, 'tool-body identity and exact Type 1 downloads' FROM sources
WHERE url = 'https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only';
INSERT INTO product_sources
SELECT 1, id, 'operating, maintenance, and safety instructions' FROM sources
WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf';
INSERT INTO product_sources
SELECT 1, id, 'exact Type 1 component diagram' FROM sources
WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif';
INSERT INTO product_sources
SELECT 1, id, 'repair and parts-support boundary' FROM sources
WHERE url = 'https://www.dewalt.com/en-us/support';
INSERT INTO product_sources
SELECT 1, id, 'model and type specific document lookup' FROM sources
WHERE url = 'https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams?sort_by=votes';
INSERT INTO product_sources
SELECT 1, id, 'replacement-parts ordering policy' FROM sources
WHERE url = 'https://support.dewalt.com/hc/en-us/articles/360012589737-Can-I-order-replacement-parts-from-DEWALT-';
INSERT INTO product_sources
SELECT 1, id, 'current warranty terms' FROM sources
WHERE url = 'https://www.dewalt.com/en-us/support/warranty';
INSERT INTO product_sources
SELECT 1, id, 'qualified exact-model owner use and failure evidence' FROM sources
WHERE url = 'https://www.reddit.com/r/Dewalt/comments/1cfmgcn/dcd800';
INSERT INTO product_sources
SELECT 1, id, 'qualified exact-model frozen-chuck report' FROM sources
WHERE url = 'https://www.reddit.com/r/Dewalt/comments/1i0ti8r/will_the_dcd800_drill_be_upgraded_like_the_1007';
INSERT INTO product_sources
SELECT 1, id, 'qualified used-tool repair report' FROM sources
WHERE url = 'https://www.reddit.com/r/Dewalt/comments/15qvarj/broken_chuck';
INSERT INTO product_sources
SELECT 1, id, 'exact-model commercial destination and title discrepancy' FROM sources
WHERE url = 'https://www.amazon.com/dp/B00EOOZT5E';

UPDATE products
SET variant_notes = 'DCD800D1E1 is the U.S. kit containing one DCD800 drill/driver, one DCBP034 POWERSTACK battery, one DCB203 2Ah battery, one DCB112 charger, one kit bag, and one belt hook. It does not include an impact driver, despite that phrase in the current Amazon listing title.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports the exact kit, a Type 1 operating and maintenance manual, an exact exploded diagram, parts ordering through ServiceNet, authorized repair, and current warranty terms. One exact-model owner reports months of general carpentry use; separate owners report an early chuck replacement, a frozen chuck, and a seized used-tool chuck that was repaired under warranty. These anecdotes do not establish representative multi-year durability, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-09-22'
WHERE id = 1 AND slug = 'dewalt-dcd800d1e1';

UPDATE product_fields
SET raw_value = 'DCD800D1E1 is the 20V MAX XR brushless 1/2-inch drill/driver kit containing one DCD800 drill/driver, one DCBP034 POWERSTACK battery, one DCB203 2Ah battery, one DCB112 charger, one kit bag, and one belt hook. No impact driver is included.',
    display_value = 'DCD800D1E1 drill/driver kit with two batteries, charger, bag, and belt hook; no impact driver is included.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcd800d1e1/20v-max-xr-brushless-cordless-12-drilldriver-kit'),
    verified_date = '2026-09-22',
    reverify_days = 180
WHERE product_id = 1 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact product page lists a 3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee. Current general terms limit coverage to faulty materials or workmanship for the original end-user purchaser and apply exclusions and proof requirements.',
    display_value = '3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee; current DEWALT terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
    verified_date = '2026-09-22',
    reverify_days = 180
WHERE product_id = 1 AND name = 'warranty';

UPDATE product_fields
SET raw_value = 'DEWALT publishes a Type 1 DCD800 and DCD805 instruction manual covering operation, weekly air-vent cleaning, chuck and accessory handling, and battery care. It directs repairs, maintenance, and adjustment to DEWALT factory or authorized service and is not an owner-repair manual.',
    display_value = 'Official Type 1 operating and maintenance manual is available; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf'),
    verified_date = '2026-09-22',
    reverify_days = 180
WHERE product_id = 1 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'DEWALT publishes an exact DCD800 Type 1 exploded diagram and directs owners to model and type specific parts lists and available replacement-part ordering through ServiceNet. The current orderability of every diagrammed component is not verified.',
    display_value = 'Partial: an exact Type 1 exploded diagram is published; current component orderability is not verified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif'),
    verified_date = '2026-09-22',
    reverify_days = 90
WHERE product_id = 1 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'The manual documents weekly air-vent cleaning and ordinary chuck and accessory procedures, but directs repairs, maintenance, and adjustment to a DEWALT factory or authorized service center. ServiceNet supports parts ordering but does not make this an unrestricted owner-repair design.',
    display_value = 'Owner care covers air-vent cleaning and ordinary accessory handling; repairs go to DEWALT factory or authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf'),
    verified_date = '2026-09-22',
    reverify_days = 180
WHERE product_id = 1 AND name = 'serviceability';

UPDATE product_fields
SET verified_date = '2026-09-22'
WHERE product_id = 1 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  1,
  '3-year limited warranty; 1-year free service; 90-day money-back guarantee.',
  'Faulty materials or workmanship for the original end-user purchaser; first-year free service includes maintenance and replacement of worn parts caused by normal use.',
  'Normal wear, tool abuse, accessories, unauthorized repair damage, and unauthorized-seller limitations apply; proof of purchase may be required.',
  (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
  '2026-09-22'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif',
    repair_manual_available = 0,
    repair_manual_url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf'),
    verified_date = '2026-09-22'
WHERE product_id = 1;

UPDATE affiliate_links
SET verified_date = '2026-09-22'
WHERE product_id = 1
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B00EOOZT5E?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '18');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-22');

COMMIT;
