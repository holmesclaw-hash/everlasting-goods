PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/LS0816F', 'Makita LS0816F official US product page', 'manufacturer', '2026-10-07'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/LS0/5a667c69-f6b2-4cc6-89d1-683656871f48_LS0816F_IM_NA3-2311.pdf', 'Makita LS0816F North American owner manual', 'manufacturer', '2026-10-07'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/LS0/f3b24fa2-2e6e-451c-86a1-2497a27b408b_LS0816F_PB_Breakdown_LS0816F_11-24.pdf', 'Makita LS0816F US 120V exact-model parts breakdown', 'manufacturer', '2026-10-07'),
  ('https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx', 'Makita USA September 2026 parts price list', 'manufacturer', '2026-10-07'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-10-07'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA service-center support', 'manufacturer', '2026-10-07'),
  ('https://www.makitatools.com/service/directrepair', 'Makita USA Direct Repair terms', 'manufacturer', '2026-10-07'),
  ('https://www.makitatools.com/recall', 'Makita USA current safety notices', 'manufacturer', '2026-10-07'),
  ('https://www.cpsc.gov/s3fs-public/recall-data/recalls_recall_listing.csv', 'CPSC public recall listing dataset', 'other', '2026-10-07'),
  ('https://www.amazon.com/dp/B0CRHR8FBC', 'Amazon exact Makita LS0816F destination', 'other', '2026-10-07');

UPDATE sources SET title = 'Makita USA warranty policy', retrieved_date = '2026-10-07'
WHERE url = 'https://www.makitatools.com/service/warranty';
UPDATE sources SET title = 'Makita USA service-center support', retrieved_date = '2026-10-07'
WHERE url = 'https://www.makitatools.com/service/service-centers';
UPDATE sources SET title = 'Makita USA Direct Repair terms', retrieved_date = '2026-10-07'
WHERE url = 'https://www.makitatools.com/service/directrepair';
UPDATE sources SET title = 'Makita USA current safety notices', retrieved_date = '2026-10-07'
WHERE url = 'https://www.makitatools.com/recall';
UPDATE sources SET title = 'Makita USA September 2026 parts price list', retrieved_date = '2026-10-07'
WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx';

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  35,
  'makita-ls0816f',
  'Makita',
  'LS0816F',
  'LS0816F',
  'miter-saws',
  'tools-shop',
  'This record is for the current U.S. LS0816F 120V configuration with a 5/8-inch arbor. The listed package includes an 8-1/2-inch 40-tooth carbide-tipped blade, hex wrench, dust bag, and vertical vise; a stand is not included. LS0815F, LS0815FL, LS1019L, and regional 110V or 220V–240V LS0816F configurations with different arbors are separate products or configurations; their package, parts, and owner evidence are not transferred.',
  'T2',
  'not-yet-verified',
  'Makita publishes an exact North American owner manual, an exact U.S. 120V parts breakdown, a dated September 2026 parts price list, warranty terms, and factory or authorized service routes. The manual documents blade and carbon-brush replacement, alignment, cleaning, and limited lubrication, but it is not an internal repair manual and routes guard, brake, switch, and other service beyond those instructions to authorized service. No qualifying exact-model owner report with verifiable ownership duration was accepted, so expected service life, failure rate, repair economics, and a buy or repair recommendation remain unverified.',
  '2026-10-07'
);

INSERT INTO product_sources
SELECT 35, id, 'exact US identity, specifications, cutting capacities, included blade and accessories, and package boundary' FROM sources WHERE url = 'https://www.makitatools.com/products/details/LS0816F';
INSERT INTO product_sources
SELECT 35, id, 'North American operation, blade and carbon-brush replacement, alignment, cleaning, lubrication, and safety-service boundaries' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS0/5a667c69-f6b2-4cc6-89d1-683656871f48_LS0816F_IM_NA3-2311.pdf';
INSERT INTO product_sources
SELECT 35, id, 'exact US 120V exploded diagrams, component part numbers, and configuration boundary' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS0/f3b24fa2-2e6e-451c-86a1-2497a27b408b_LS0816F_PB_Breakdown_LS0816F_11-24.pdf';
INSERT INTO product_sources
SELECT 35, id, 'dated current-catalog snapshot for many exact repair-significant part numbers; not a live-stock check' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx';
INSERT INTO product_sources
SELECT 35, id, 'current general-product warranty coverage and exclusions' FROM sources WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 35, id, 'factory and authorized service paths' FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 35, id, 'factory mail-in repair path and current terms' FROM sources WHERE url = 'https://www.makitatools.com/service/directrepair';
INSERT INTO product_sources
SELECT 35, id, 'current manufacturer safety-notice check; no exact LS0816F notice listed' FROM sources WHERE url = 'https://www.makitatools.com/recall';
INSERT INTO product_sources
SELECT 35, id, 'current public recall-dataset check; no LS0816F text match found, which is not safety clearance' FROM sources WHERE url = 'https://www.cpsc.gov/s3fs-public/recall-data/recalls_recall_listing.csv';
INSERT INTO product_sources
SELECT 35, id, 'exact Amazon LS0816F model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B0CRHR8FBC';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (35, 'identity', 'Makita identifies LS0816F as a corded 8-1/2-inch slide compound miter saw with a 10.5 AMP direct-drive motor, 5,000 RPM no-load speed, miter range to 47 degrees left and right, bevel range to 47 degrees left and 2 degrees right, built-in LED shadow line-of-cut light, 30.6-pound net weight, and up to 12-inch crosscut capacity at 90 degrees. The current U.S. page lists a 40-tooth carbide blade, hex wrench, dust bag, and vertical vise as standard equipment.', '8-1/2-inch corded slide compound miter saw with 10.5 AMP motor, 5,000 RPM speed, 47° left/right miter, 47° left/2° right bevel, LED line-of-cut light, 30.6-pound weight, and up to 12-inch crosscuts.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/LS0816F'), '2026-10-07', 180),
  (35, 'warranty', 'Makita currently warrants general products against defects in workmanship and materials for one year from original purchase and may repair or replace after inspection. Published exclusions include third-party repair attempts, normal wear and tear, abuse, misuse, improper maintenance or operation, alterations, and accessories.', 'One-year general-product limited warranty from original purchase; current Makita terms and exclusions apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'), '2026-10-07', 180),
  (35, 'repair_manual', 'The exact North American owner manual documents blade installation and removal, kerf-board and fence alignment, miter and bevel adjustment, carbon-brush inspection and replacement, cleaning, and limited oil or grease maintenance. It also states that blade guard, electric brake, and other maintenance or adjustment not described in the manual should be handled by Makita authorized service, so it is not a complete internal repair manual.', 'Exact owner manual covers blade and carbon brushes, alignment, cleaning, and lubrication; it is not a complete internal repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS0/5a667c69-f6b2-4cc6-89d1-683656871f48_LS0816F_IM_NA3-2311.pdf'), '2026-10-07', 180),
  (35, 'parts_availability', 'Makita publishes an exact U.S. 120V parts breakdown identifying the motor housing, field and armature assemblies, switch, controller and soft-start circuit, spindle, gears and bearings, blade and center covers, safety cover and guard link, brushes and brush holders, fences, turn base, slide pipes, bevel mechanism, and fasteners. The September 2026 Makita USA parts price list catalogs many exact repair-significant numbers from that breakdown. The list is a dated catalog snapshot, not proof of current stock or orderability for every diagrammed component.', 'Partial: exact parts breakdown and September 2026 price list cover the motor, switch, soft-start circuit, guards, and brushes, but live stock and complete orderability are not verified.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS0/f3b24fa2-2e6e-451c-86a1-2497a27b408b_LS0816F_PB_Breakdown_LS0816F_11-24.pdf'), '2026-10-07', 90),
  (35, 'serviceability', 'Owners can perform the documented blade and carbon-brush replacement, kerf-board and fence alignment, angle adjustments, cleaning, and limited lubrication. Blade-guard, switch, brake, controller, motor, and other internal service is not documented for owner repair and routes to Makita authorized service.', 'User-serviceable for blade, carbon brushes, alignment, cleaning, and lubrication; guard, switch, brake, and internal repairs route to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS0/5a667c69-f6b2-4cc6-89d1-683656871f48_LS0816F_IM_NA3-2311.pdf'), '2026-10-07', 180),
  (35, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-07', 180),
  (35, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-07', 30),
  (35, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-07', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  35,
  'One-year general-product limited warranty.',
  'Defects in workmanship and materials; Makita may repair or replace after inspection under the current policy.',
  'Repairs made or attempted by others, normal wear and tear, abuse, misuse, improper maintenance or operation, alterations, and accessories are excluded; current Makita terms apply.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-10-07'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  35,
  'partial',
  'https://cdn.makitatools.com/apps/cms/doc/prod/LS0/f3b24fa2-2e6e-451c-86a1-2497a27b408b_LS0816F_PB_Breakdown_LS0816F_11-24.pdf',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/LS0/5a667c69-f6b2-4cc6-89d1-683656871f48_LS0816F_IM_NA3-2311.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS0/5a667c69-f6b2-4cc6-89d1-683656871f48_LS0816F_IM_NA3-2311.pdf'),
  '2026-10-07'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (35, 'Amazon Associates', 'https://www.amazon.com/dp/B0CRHR8FBC?tag=everlastin08f-20', 1, '2026-10-07');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '37');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-07');

COMMIT;
