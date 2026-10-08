PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/LS1219L', 'Makita LS1219L official US product page', 'manufacturer', '2026-10-08'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/LS1/9ccf5578-d40a-4390-b1fb-7deae44ee2ec_LS1219L_NTFE.pdf', 'Makita LS1219L US new-tool flyer', 'manufacturer', '2026-10-08'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/LS1/b54a9ea9-3bbb-491a-befd-b66075fc70e3_LS1219L_IM__885618A943_C1920.pdf', 'Makita LS1219 and LS1219L North American owner manual', 'manufacturer', '2026-10-08'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/LS1/d654a02d-1035-4495-9ada-4eb6b6bcc3b9_LS1219L_PB_Breakdown_LS1219L_01-18.pdf', 'Makita LS1219L exact-model parts breakdown', 'manufacturer', '2026-10-08'),
  ('https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx', 'Makita USA September 2026 parts price list', 'manufacturer', '2026-10-08'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-10-08'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA service-center support', 'manufacturer', '2026-10-08'),
  ('https://www.makitatools.com/service/directrepairfaq', 'Makita USA Direct Repair FAQ', 'manufacturer', '2026-10-08'),
  ('https://www.makitatools.com/recall', 'Makita USA current safety notices', 'manufacturer', '2026-10-08'),
  ('https://www.cpsc.gov/s3fs-public/recall-data/recalls_recall_listing.csv', 'CPSC public recall listing dataset', 'other', '2026-10-08'),
  ('https://www.reddit.com/r/Tools/comments/wrk0p0/ntd_bought_my_dream_saw_makita_ls1219l/', 'Makita LS1219L owner discussion with mixed duration reports', 'owner-report', '2026-10-08'),
  ('https://www.amazon.com/dp/B07B3WF2Y2', 'Amazon exact Makita LS1219L destination', 'other', '2026-10-08');

UPDATE sources SET title = 'Makita USA warranty policy', retrieved_date = '2026-10-08'
WHERE url = 'https://www.makitatools.com/service/warranty';
UPDATE sources SET title = 'Makita USA service-center support', retrieved_date = '2026-10-08'
WHERE url = 'https://www.makitatools.com/service/service-centers';
UPDATE sources SET title = 'Makita USA current safety notices', retrieved_date = '2026-10-08'
WHERE url = 'https://www.makitatools.com/recall';
UPDATE sources SET title = 'Makita USA September 2026 parts price list', retrieved_date = '2026-10-08'
WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx';

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  36,
  'makita-ls1219l',
  'Makita',
  'LS1219L',
  'LS1219L',
  'miter-saws',
  'tools-shop',
  'This record is for the current standalone U.S. LS1219L configuration with a 1-inch arbor. The exact parts breakdown lists a 12-inch 60-tooth blade, dust bag, vertical vise, triangular rule, 6 mm hex wrench, and 2.5 mm hex wrench as standard equipment; a stand is not included. LS1219LX is a separate commercial package that combines the LS1219L saw with a WST06 stand. LS1219 is the separate non-laser model covered by the shared manual. Regional voltages, suffixes, accessories, warranty terms, and package claims are not transferred to this U.S. record.',
  'T2',
  'not-yet-verified',
  'Makita publishes a current exact U.S. product page, a shared North American owner manual that identifies LS1219L-specific laser procedures, an exact-model parts breakdown, a dated September 2026 parts price list, warranty terms, and factory or authorized service routes. The owner manual documents blade work, alignment, laser adjustment and lens cleaning, carbon-brush replacement, cleaning, and limited lubrication, but it is not an internal repair manual. Exact-model owner reports are anecdotal and mixed, ranging from short-term complaints to multi-year service claims without controlled usage or representative sampling, so expected service life, failure rate, repair economics, and a buy or repair recommendation remain unverified.',
  '2026-10-08'
);

INSERT INTO product_sources
SELECT 36, id, 'current exact US identity, laser configuration, capacities, included-equipment summary, and standalone package' FROM sources WHERE url = 'https://www.makitatools.com/products/details/LS1219L';
INSERT INTO product_sources
SELECT 36, id, 'US UPC, motor, speed, angle ranges, capacities, dimensions, weight, and package distinctions' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/9ccf5578-d40a-4390-b1fb-7deae44ee2ec_LS1219L_NTFE.pdf';
INSERT INTO product_sources
SELECT 36, id, 'North American operation, blade and carbon-brush replacement, alignment, laser adjustment, cleaning, lubrication, and safety-service boundaries' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/b54a9ea9-3bbb-491a-befd-b66075fc70e3_LS1219L_IM__885618A943_C1920.pdf';
INSERT INTO product_sources
SELECT 36, id, 'exact exploded diagrams, component part numbers, standard equipment, and US 115V configuration evidence' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/d654a02d-1035-4495-9ada-4eb6b6bcc3b9_LS1219L_PB_Breakdown_LS1219L_01-18.pdf';
INSERT INTO product_sources
SELECT 36, id, 'dated catalog snapshot for repair-significant exact part numbers; not a live-stock check' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx';
INSERT INTO product_sources
SELECT 36, id, 'current general-product warranty coverage and exclusions' FROM sources WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 36, id, 'factory and authorized service paths' FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 36, id, 'general factory mail-in repair terms; exact-model eligibility was not independently confirmed' FROM sources WHERE url = 'https://www.makitatools.com/service/directrepairfaq';
INSERT INTO product_sources
SELECT 36, id, 'current manufacturer safety-notice check; no exact LS1219L notice listed' FROM sources WHERE url = 'https://www.makitatools.com/recall';
INSERT INTO product_sources
SELECT 36, id, 'current public recall-dataset check; no LS1219L text match found, which is not safety clearance' FROM sources WHERE url = 'https://www.cpsc.gov/s3fs-public/recall-data/recalls_recall_listing.csv';
INSERT INTO product_sources
SELECT 36, id, 'anecdotal exact-model owner reports with mixed experiences and durations; not representative lifespan evidence' FROM sources WHERE url = 'https://www.reddit.com/r/Tools/comments/wrk0p0/ntd_bought_my_dream_saw_makita_ls1219l/';
INSERT INTO product_sources
SELECT 36, id, 'exact Amazon LS1219L model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B07B3WF2Y2';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (36, 'identity', 'Makita identifies the current U.S. LS1219L as a corded 12-inch dual-bevel sliding compound miter saw with a built-in laser, 1-inch arbor, 15 AMP direct-drive motor, 3,200 RPM no-load speed, miter range to 60 degrees left and right, bevel range to 48 degrees left and right, 65-pound net weight, and up to 15-inch crosscut capacity at 90 degrees. The standalone package is separate from the LS1219LX saw-and-stand kit.', '12-inch corded dual-bevel sliding compound miter saw with 15 AMP motor, 3,200 RPM speed, 60° left/right miter, 48° left/right bevel, built-in laser, 65-pound weight, and up to 15-inch crosscuts.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/9ccf5578-d40a-4390-b1fb-7deae44ee2ec_LS1219L_NTFE.pdf'), '2026-10-08', 180),
  (36, 'warranty', 'Makita currently warrants general products against defects in workmanship and materials for one year from original purchase and may repair or replace after inspection. Published exclusions include third-party repair attempts, normal wear and tear, abuse, misuse, improper maintenance or operation, alterations, and accessories.', 'One-year general-product limited warranty from original purchase; current Makita terms and exclusions apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'), '2026-10-08', 180),
  (36, 'repair_manual', 'The North American owner manual shared by LS1219 and LS1219L documents blade installation and removal, miter and bevel alignment, LS1219L laser-line adjustment and lens cleaning, carbon-brush inspection and replacement, cleaning, and limited machine-oil lubrication. It also routes laser-unit failure, defective switch or brake, damaged guard, and all other repairs or undocumented maintenance to Makita authorized or factory service, so it is not a complete internal repair manual.', 'Exact owner manual covers blade work, alignment, laser adjustment, carbon brushes, cleaning, and lubrication; it is not a complete internal repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/b54a9ea9-3bbb-491a-befd-b66075fc70e3_LS1219L_IM__885618A943_C1920.pdf'), '2026-10-08', 180),
  (36, 'parts_availability', 'Makita publishes an exact LS1219L parts breakdown identifying the switch, controller, 115V field and armature, carbon brushes, gears and bearings, laser switch and circuit, guard components, dust system, synchronized belt, fences, kerf boards, turn base, slide mechanism, and fasteners. The September 2026 Makita USA parts price list contains exact repair-significant numbers including CB154, 510159-0, 590026-5, 638651-5, 225102-3, 451201-7, and 631863-9. The workbook is a dated catalog snapshot and does not prove live stock, active status, or complete orderability.', 'Partial: exact parts breakdown and September 2026 catalog cover brushes, armature, field, laser circuit, belt, kerf board, and controller, but live stock and complete orderability are not verified.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/d654a02d-1035-4495-9ada-4eb6b6bcc3b9_LS1219L_PB_Breakdown_LS1219L_01-18.pdf'), '2026-10-08', 90),
  (36, 'serviceability', 'Owners can perform documented blade work, miter and bevel alignment, laser-line adjustment and lens cleaning, carbon-brush replacement, cleaning, and limited lubrication. Guard, switch, brake, laser-unit, motor, controller, gearbox, and other internal repairs are not documented for owner repair and route to Makita authorized service.', 'User-serviceable for blade, alignment, laser cleaning and adjustment, carbon brushes, cleaning, and lubrication; guard, switch, brake, and internal repairs route to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/b54a9ea9-3bbb-491a-befd-b66075fc70e3_LS1219L_IM__885618A943_C1920.pdf'), '2026-10-08', 180),
  (36, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-08', 180),
  (36, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-08', 30),
  (36, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-08', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  36,
  'One-year general-product limited warranty.',
  'Defects in workmanship and materials; Makita may repair or replace after inspection under the current policy.',
  'Repairs made or attempted by others, normal wear and tear, abuse, misuse, improper maintenance or operation, alterations, and accessories are excluded; current Makita terms apply.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-10-08'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  36,
  'partial',
  'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/d654a02d-1035-4495-9ada-4eb6b6bcc3b9_LS1219L_PB_Breakdown_LS1219L_01-18.pdf',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/b54a9ea9-3bbb-491a-befd-b66075fc70e3_LS1219L_IM__885618A943_C1920.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/LS1/b54a9ea9-3bbb-491a-befd-b66075fc70e3_LS1219L_IM__885618A943_C1920.pdf'),
  '2026-10-08'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (36, 'Amazon Associates', 'https://www.amazon.com/dp/B07B3WF2Y2?tag=everlastin08f-20', 1, '2026-10-08');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '38');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-08');

COMMIT;
