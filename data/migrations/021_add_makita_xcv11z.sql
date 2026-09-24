PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/XCV11Z', 'Makita XCV11Z official product page', 'manufacturer', '2026-09-24'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XCV/db17dbf5-e6dc-42f4-bed4-ee2ed457e129_XCV11_IM_885666A942_C6977.pdf', 'Makita XCV11 instruction manual', 'manufacturer', '2026-09-24'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XCV/45b60f26-d035-407f-959f-112510220571_XCV11_PB_Breakdown_XCV11Z_01-19.pdf', 'Makita XCV11Z parts breakdown', 'manufacturer', '2026-09-24'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-09-24'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA service-center support', 'manufacturer', '2026-09-24'),
  ('https://www.reddit.com/r/Makita/comments/1jhmkwv/bought_the_xcv11z_wetdry_vac_returned_it_less/', 'Mixed exact-model Makita XCV11Z owner reports', 'owner-report', '2026-09-24');

UPDATE sources
SET title = 'Makita USA warranty policy', retrieved_date = '2026-09-24'
WHERE url = 'https://www.makitatools.com/service/warranty';
UPDATE sources
SET title = 'Makita USA service-center support', retrieved_date = '2026-09-24'
WHERE url = 'https://www.makitatools.com/service/service-centers';

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  24,
  'makita-xcv11z',
  'Makita',
  'XCV11Z',
  'XCV11Z',
  'dust-extractors',
  'tools-shop',
  'Standalone XCV11Z tool-only package with flexible hose, wide nozzle, crevice nozzle, HEPA filter, and pre-filter. Battery, charger, and shoulder strap are not included. Evidence from the XCV11T two-battery kit and ADCV11Z Outdoor Adventure variant is not transferred to this record.',
  'T2',
  'not-yet-verified',
  'Makita documentation establishes exact tool-only identity, owner filter and tank maintenance, an exact parts breakdown with numbered components, factory and authorized service routes, and a three-year lithium-ion tool warranty. Exact-model owner reports conflict: one reports six years of frequent use and useful planer collection while acknowledging limited saw extraction, another reports years of hard use without complaint, and the thread author returned the unit immediately because of poor suction. These reports are anecdotal and do not establish representative service life or performance, so expected lifespan and a buy or repair recommendation remain unverified.',
  '2026-09-24'
);

INSERT INTO product_sources
SELECT 24, id, 'identity, tool-only package, included accessories, and current specifications' FROM sources WHERE url = 'https://www.makitatools.com/products/details/XCV11Z';
INSERT INTO product_sources
SELECT 24, id, 'owner maintenance, filter care, operating limits, and authorized-service boundary' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/db17dbf5-e6dc-42f4-bed4-ee2ed457e129_XCV11_IM_885666A942_C6977.pdf';
INSERT INTO product_sources
SELECT 24, id, 'exact-model exploded diagrams and numbered parts list' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/45b60f26-d035-407f-959f-112510220571_XCV11_PB_Breakdown_XCV11Z_01-19.pdf';
INSERT INTO product_sources
SELECT 24, id, 'current lithium-ion tool warranty terms' FROM sources WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 24, id, 'factory, authorized, and direct-repair service paths' FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 24, id, 'conflicting exact-model owner evidence including six-year use and an immediate return' FROM sources WHERE url = 'https://www.reddit.com/r/Makita/comments/1jhmkwv/bought_the_xcv11z_wetdry_vac_returned_it_less/';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (24, 'identity', 'XCV11Z is an 18V LXT brushless cordless two-gallon HEPA portable wet/dry dust extractor and vacuum sold as a tool-only package. Makita specifies 57 CFM, 27 inches of water lift, and included hose, wide nozzle, crevice nozzle, HEPA filter, and pre-filter; battery and charger are not included.', '18V LXT brushless 2-gallon HEPA portable wet/dry vacuum, tool-only, with 57 CFM and 27-inch water lift.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/XCV11Z'), '2026-09-24', 180),
  (24, 'warranty', 'Makita classifies XCV11Z as a lithium-ion tool and currently warrants lithium-ion tools against defects in workmanship and materials for three years from original purchase, subject to published limitations and exclusions.', '3-year limited warranty for Makita lithium-ion tools; current Makita terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'), '2026-09-24', 180),
  (24, 'repair_manual', 'Makita publishes an exact XCV11 operating, safety, and maintenance manual. It documents tank emptying and HEPA filter removal, cleaning, washing, drying, and replacement, but directs repairs and other maintenance or adjustment to Makita Authorized or Factory Service Centers and is not an owner-repair manual.', 'Official operating and maintenance manual is available; it is not an owner-repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/db17dbf5-e6dc-42f4-bed4-ee2ed457e129_XCV11_IM_885666A942_C6977.pdf'), '2026-09-24', 180),
  (24, 'parts_availability', 'Makita publishes an exact XCV11Z parts breakdown with part numbers for the switch, controller, stator, rotor, fan, seals, filter, tank, hose, and nozzles. The current product page identifies filter and accessory part numbers, but individual internal repair-part orderability was not verified.', 'Partial: exact XCV11Z parts breakdown and part numbers are published, but individual repair-part orderability is not verified.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/45b60f26-d035-407f-959f-112510220571_XCV11_PB_Breakdown_XCV11Z_01-19.pdf'), '2026-09-24', 180),
  (24, 'serviceability', 'The manual documents owner tank emptying and HEPA filter cleaning and replacement. It directs internal repair and other maintenance or adjustment to Makita Authorized or Factory Service Centers, and Makita maintains current factory, authorized, and direct-repair routes.', 'Owner maintenance covers the tank and filters; internal repair is directed to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/db17dbf5-e6dc-42f4-bed4-ee2ed457e129_XCV11_IM_885666A942_C6977.pdf'), '2026-09-24', 180),
  (24, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 180),
  (24, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 30),
  (24, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  24,
  '3-year limited warranty for Makita lithium-ion tools.',
  'Repair or replacement after inspection when trouble during the three-year period is caused by defective workmanship or material.',
  'Published exclusions include third-party repair attempts, normal wear, abuse, misuse, improper maintenance, non-genuine batteries, and alteration; current terms and jurisdictional rights control.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-09-24'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  24,
  'partial',
  'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/45b60f26-d035-407f-959f-112510220571_XCV11_PB_Breakdown_XCV11Z_01-19.pdf',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/db17dbf5-e6dc-42f4-bed4-ee2ed457e129_XCV11_IM_885666A942_C6977.pdf',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/db17dbf5-e6dc-42f4-bed4-ee2ed457e129_XCV11_IM_885666A942_C6977.pdf'),
  '2026-09-24'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (24, 'Amazon Associates', 'https://www.amazon.com/dp/B07M8JTDNS?tag=everlastin08f-20', 1, '2026-09-24');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '21');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-24');

COMMIT;
