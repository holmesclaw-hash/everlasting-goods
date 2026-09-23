PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/RF1101', 'Makita RF1101 official product page', 'manufacturer', '2026-09-23'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/RF1/71c406df-49e6-4f04-8ffa-2fe5cf660011_RF1101_IM.pdf', 'Makita RF1101 instruction manual', 'manufacturer', '2026-09-23'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/RF1/d592ab2b-3110-437b-b4b1-963239e0f331_RF1101_PB.pdf', 'Makita RF1101 parts breakdown', 'manufacturer', '2026-09-23'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-09-23'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA service-center support', 'manufacturer', '2026-09-23'),
  ('https://mimf.com/phpbb/viewtopic.php?t=2845', 'Several-year Makita RF1101 owner report', 'owner-report', '2026-09-23'),
  ('https://www.lumberjocks.com/threads/makita-router-question-rf1101-varible-speed.42433/', 'Seven-year Makita RF1101 speed-control report', 'owner-report', '2026-09-23');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  22,
  'makita-rf1101',
  'Makita',
  'RF1101',
  'RF1101',
  'routers',
  'tools-shop',
  'Standalone fixed-base package with RF1101 motor, 1/4-inch and 1/2-inch collets, and wrench. It is not RF1101KIT2, the separate kit that adds a plunge base. The product page also contains a conflicting Base: Plunge specification line, so that line is not treated as package evidence.',
  'T2',
  'not-yet-verified',
  'Manufacturer documentation establishes exact identity, an operating manual with an owner carbon-brush procedure, an exact parts breakdown, factory and authorized service routes, and current warranty terms. Exact-model owner reports include several years without problems and a separate speed-control fault after seven years and substantial router-table use; those anecdotes do not establish representative service life, so expected lifespan and a buy or repair recommendation remain unverified.',
  '2026-09-23'
);

INSERT INTO product_sources
SELECT 22, id, 'identity, package, construction, and current accessories' FROM sources WHERE url = 'https://www.makitatools.com/products/details/RF1101';
INSERT INTO product_sources
SELECT 22, id, 'operating, maintenance, brush replacement, and safety instructions' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RF1/71c406df-49e6-4f04-8ffa-2fe5cf660011_RF1101_IM.pdf';
INSERT INTO product_sources
SELECT 22, id, 'exact-model parts identification' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RF1/d592ab2b-3110-437b-b4b1-963239e0f331_RF1101_PB.pdf';
INSERT INTO product_sources
SELECT 22, id, 'current warranty terms' FROM sources WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 22, id, 'factory and authorized service path' FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 22, id, 'positive exact-model owner evidence' FROM sources WHERE url = 'https://mimf.com/phpbb/viewtopic.php?t=2845';
INSERT INTO product_sources
SELECT 22, id, 'negative exact-model owner evidence' FROM sources WHERE url = 'https://www.lumberjocks.com/threads/makita-router-question-rf1101-varible-speed.42433/';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (22, 'identity', 'RF1101 is a corded fixed-base router with an 11-amp motor, 2-1/4 maximum horsepower, variable speed from 8,000 to 24,000 RPM, aluminum motor housing, all-ball-bearing construction, and 1/4-inch and 1/2-inch collet capacity.', 'Corded fixed-base 2-1/4 HP maximum router with 8,000–24,000 RPM variable speed and 1/4-inch and 1/2-inch collets.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/RF1101'), '2026-09-23', 180),
  (22, 'warranty', 'The exact product page displays Makita 1 Year-30 Day Warranty; the current general policy provides a one-year limited warranty against defects in workmanship and materials and a 30-day return or replacement guarantee, subject to published limitations.', '1-year general product limited warranty and 30-day return or replacement guarantee; current Makita terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'), '2026-09-23', 180),
  (22, 'repair_manual', 'Makita publishes an operating and safety manual that documents inspection and replacement of both externally accessible carbon brushes. It directs all other repairs, maintenance, or adjustment to Makita Authorized or Factory Service Centers and is not a full owner-repair manual.', 'Official operating manual documents carbon-brush replacement; it is not a full owner-repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RF1/71c406df-49e6-4f04-8ffa-2fe5cf660011_RF1101_IM.pdf'), '2026-09-23', 180),
  (22, 'parts_availability', 'Makita publishes an exact RF1101 parts breakdown with identifiers for the controller, switch, armature, bearings, carbon brushes, collets, base components, cord, and hardware. The current product page links several compatible accessories, but individual repair-part orderability was not verified.', 'Partial: exact RF1101 parts breakdown is published, but individual repair-part orderability is not verified.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RF1/d592ab2b-3110-437b-b4b1-963239e0f331_RF1101_PB.pdf'), '2026-09-23', 180),
  (22, 'serviceability', 'The manual gives an owner procedure for replacing both carbon brushes. It reserves all other repairs, maintenance, and adjustments for Makita Authorized or Factory Service Centers, and Makita maintains current factory and authorized service routes.', 'User-serviceable for documented carbon-brush replacement; deeper work is directed to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RF1/71c406df-49e6-4f04-8ffa-2fe5cf660011_RF1101_IM.pdf'), '2026-09-23', 180),
  (22, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-23', 180),
  (22, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-23', 30),
  (22, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-23', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  22,
  '1-year general product limited warranty; 30-day return or replacement guarantee.',
  'Defects in workmanship and materials during the one-year period, with repair or replacement after inspection through a Makita Factory or Authorized Service Center.',
  'Published exclusions include attempted third-party repair, normal wear, abuse, misuse, improper maintenance, and alteration; current terms and jurisdictional rights control.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-09-23'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  22,
  'partial',
  'https://cdn.makitatools.com/apps/cms/doc/prod/RF1/d592ab2b-3110-437b-b4b1-963239e0f331_RF1101_PB.pdf',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/RF1/71c406df-49e6-4f04-8ffa-2fe5cf660011_RF1101_IM.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RF1/71c406df-49e6-4f04-8ffa-2fe5cf660011_RF1101_IM.pdf'),
  '2026-09-23'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (22, 'Amazon Associates', 'https://www.amazon.com/dp/B00004YN3N?tag=everlastin08f-20', 1, '2026-09-23');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '19');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-23');

COMMIT;
