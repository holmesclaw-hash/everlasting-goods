PRAGMA foreign_keys = ON;
BEGIN;

UPDATE sources
SET retrieved_date = '2026-09-26'
WHERE url IN (
  'https://www.boschtools.com/us/en/products/1617evspk-0601617577',
  'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf',
  'https://www.boschtools.com/us/en/service/product-warranty/'
);

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/1617evspk-3601F75710', 'Bosch 1617EVSPK exact spare-parts catalog', 'manufacturer', '2026-09-26'),
  ('https://www.garagejournal.com/forum/threads/bosch-1617-router-users-beware.327633/', 'Bosch 1617 owner report: switch issue after about 13 years', 'owner-report', '2026-09-26'),
  ('https://festoolownersgroup.com/threads/bosch-1617evspk-combo-router-kit.69166/', 'Bosch 1617EVSPK owner report: plunge-base binding after about two years', 'owner-report', '2026-09-26'),
  ('https://www.amazon.com/dp/B00005RHPD', 'Amazon exact Bosch 1617EVSPK destination', 'other', '2026-09-26'),
  ('https://slickdeals.net/f/18625288-bosch-2-25-hp-variable-speed-router-combination-kit-1617evspk-149-free-shipping', 'September 2026 Bosch 1617EVSPK commercial listing corroboration', 'other', '2026-09-26');

DELETE FROM product_sources WHERE product_id = 9;

INSERT INTO product_sources
SELECT 9, id, 'current catalog identity, performance range, current part number, and package contents' FROM sources
WHERE url = 'https://www.boschtools.com/us/en/products/1617evspk-0601617577';
INSERT INTO product_sources
SELECT 9, id, 'exact technical-part-number spare-parts catalog' FROM sources
WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/1617evspk-3601F75710';
INSERT INTO product_sources
SELECT 9, id, 'operating, cleaning, bit and collet, maintenance, and authorized-service boundaries' FROM sources
WHERE url = 'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf';
INSERT INTO product_sources
SELECT 9, id, 'current Bosch corded-tool warranty terms' FROM sources
WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty/';
INSERT INTO product_sources
SELECT 9, id, 'qualified 1617-family owner report of about 13 trouble-free years before a switch problem' FROM sources
WHERE url = 'https://www.garagejournal.com/forum/threads/bosch-1617-router-users-beware.327633/';
INSERT INTO product_sources
SELECT 9, id, 'qualified exact-combo owner report of plunge-base binding after about two years' FROM sources
WHERE url = 'https://festoolownersgroup.com/threads/bosch-1617evspk-combo-router-kit.69166/';
INSERT INTO product_sources
SELECT 9, id, 'exact-model commercial destination' FROM sources
WHERE url = 'https://www.amazon.com/dp/B00005RHPD';
INSERT INTO product_sources
SELECT 9, id, 'recent exact-model commercial identity corroboration' FROM sources
WHERE url = 'https://slickdeals.net/f/18625288-bosch-2-25-hp-variable-speed-router-combination-kit-1617evspk-149-free-shipping';

UPDATE products
SET variant_notes = 'Bosch identifies 1617EVSPK as the 2.25 HP variable-speed combination kit with fixed and plunge bases. The current catalog page lists part number 06016176A1, while the exact Bosch service catalog maps the kit to technical part number 3601F75710; those identifiers should not be substituted for another 1617 package.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports the exact fixed-base and plunge-base package, owner cleaning and bit or collet procedures, an exact technical-part-number spare-parts catalog, authorized service, and a one-year limited warranty. One 1617-family owner reports about 13 years of trouble-free use before an intermittent switch problem; an exact 1617EVSPK owner reports plunge-base binding after about two years. These reports are anecdotal, cover different failure paths, and do not establish a representative service life, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-09-26'
WHERE id = 9 AND slug = 'bosch-1617evspk';

UPDATE product_fields
SET raw_value = 'Bosch identifies 1617EVSPK as a 2.25 HP corded variable-speed router combination kit with fixed and plunge bases, 8,000 to 25,000 rpm speed control, current part number 06016176A1, and exact service technical part number 3601F75710.',
    display_value = '2.25 HP corded variable-speed router kit, 8,000–25,000 RPM, with fixed and plunge bases.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/1617evspk-0601617577'),
    verified_date = '2026-09-26',
    reverify_days = 180
WHERE product_id = 9 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Bosch maps the 1617EVSPK to technical part number 3601F75710 and publishes an exact spare-parts catalog. The review confirmed the catalog route but did not verify current individual orderability for every listed component.',
    display_value = 'Partial: 3601F75710 maps to an official spare-parts catalog; individual component availability remains unverified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/1617evspk-3601F75710'),
    verified_date = '2026-09-26',
    reverify_days = 90
WHERE product_id = 9 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Bosch publishes an operating and safety manual for the 1617EVS and 1617EVSPK covering setup, operation, cleaning, ventilation, bit and collet handling, maintenance, and service. It is not an owner-repair manual and routes service to Bosch factory or authorized service facilities.',
    display_value = 'Official operating and maintenance manual is available; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf'),
    verified_date = '2026-09-26',
    reverify_days = 180
WHERE product_id = 9 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The official manual documents owner cleaning with compressed air, ventilation upkeep, bit installation and removal, and collet care. It routes internal service to Bosch factory or authorized service facilities rather than documenting owner disassembly and repair.',
    display_value = 'Owner care covers cleaning, ventilation, bit changes, and collet care; internal repair is routed to authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf'),
    verified_date = '2026-09-26',
    reverify_days = 180
WHERE product_id = 9 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Bosch provides a one-year limited warranty to the original purchaser of corded portable and benchtop power tools for defects in material or workmanship. Current exclusions and claim requirements apply.',
    display_value = '1-year limited warranty for the original purchaser; current Bosch terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty/'),
    verified_date = '2026-09-26',
    reverify_days = 180
WHERE product_id = 9 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-09-26'
WHERE product_id = 9 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  9,
  '1-year limited warranty.',
  'Defects in material or workmanship for the original purchaser of Bosch corded portable and benchtop power tools.',
  'Misuse, careless handling, unauthorized misrepair, and accessory items are excluded; current Bosch terms and claim requirements apply.',
  (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty/'),
  '2026-09-26'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/1617evspk-3601F75710',
    repair_manual_available = 0,
    repair_manual_url = 'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf'),
    verified_date = '2026-09-26'
WHERE product_id = 9;

UPDATE affiliate_links
SET verified_date = '2026-09-26'
WHERE product_id = 9
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B00005RHPD?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '24');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-26');

COMMIT;
