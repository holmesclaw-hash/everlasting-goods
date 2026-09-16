BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.boschtools.com/us/en/products/gsr18v-800cn-06019K6010', 'Bosch GSR18V-800CN official product page', 'manufacturer', '2026-09-14'),
  ('https://ocsmedia.boschtools.com/binary/manualsmedia/o256028v2_2610070413_GSR18V800C_202308.pdf', 'Bosch GSR18V-800C operating and safety manual', 'manufacturer', '2026-09-14'),
  ('https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-800cn-3601JK6010', 'Bosch GSR18V-800C exact-tool-number spare-parts catalog', 'manufacturer', '2026-09-14'),
  ('https://www.boschtools.com/us/en/service/product-warranty', 'Bosch 18V limited warranty', 'manufacturer', '2026-09-14'),
  ('https://us.bosch-press.com/pressportal/us/en/press-release-24768.html', 'Bosch 2024 GSR18V-800C product announcement', 'manufacturer', '2026-09-14');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  20,
  'bosch-gsr18v-800cn',
  'Bosch',
  'GSR18V-800CN',
  '06019K6010',
  'drill-drivers',
  'tools-shop',
  'Current US bare-tool configuration: Bosch order number 06019K6010 includes the GSR18V-800C drill/driver and belt clip; battery, charger, case, and GCY42 connectivity module are not included.',
  'T2',
  'not-yet-verified',
  'Manufacturer documentation verifies the current bare-tool identity, an operating and safety manual, an exact tool-number spare-parts catalog route, and a five-year limited warranty for qualifying purchases. It does not establish an owner-repair procedure, long-term individual-parts availability, multi-year exact-model owner history, expected service life, or a recommendation.',
  '2026-09-14'
);

INSERT INTO product_sources
SELECT 20, id, 'identity, included items, and construction' FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/gsr18v-800cn-06019K6010';
INSERT INTO product_sources
SELECT 20, id, 'operating and safety instructions' FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o256028v2_2610070413_GSR18V800C_202308.pdf';
INSERT INTO product_sources
SELECT 20, id, 'exact tool-number parts support' FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-800cn-3601JK6010';
INSERT INTO product_sources
SELECT 20, id, 'warranty terms' FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty';
INSERT INTO product_sources
SELECT 20, id, 'model introduction and bare-tool execution' FROM sources WHERE url = 'https://us.bosch-press.com/pressportal/us/en/press-release-24768.html';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (20, 'identity', 'GSR18V-800CN is Bosch order number 06019K6010, a bare 18V brushless connected-ready 1/2-inch drill/driver with 565 in.-lb. maximum torque, an all-metal chuck, KickBack Control, and a belt clip; battery, charger, case, and GCY42 module are excluded.', 'GSR18V-800CN bare tool (order 06019K6010): 18V brushless 1/2-inch drill/driver with 565 in.-lb. maximum torque, all-metal chuck, KickBack Control, and belt clip.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/gsr18v-800cn-06019K6010'), '2026-09-14', 180),
  (20, 'warranty', 'For purchases dated June 1, 2023 or later, Bosch warrants 18V cordless power tools to the original end-user purchaser for five years against defects in material or workmanship, subject to the published exclusions and territorial limits.', '5-year limited warranty for the original end-user purchaser on qualifying purchases dated June 1, 2023 or later; Bosch exclusions and territorial limits apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'), '2026-09-14', 180),
  (20, 'repair_manual', 'Bosch publishes a model-family operating and safety manual for GSR18V-800C and GSB18V-800C. It provides operating, maintenance, and safety instructions but is not an owner-repair manual.', 'Official GSR18V-800C operating and safety manual is available; it is not an owner-repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o256028v2_2610070413_GSR18V800C_202308.pdf'), '2026-09-14', 180),
  (20, 'parts_availability', 'Bosch publishes an exact tool-number 3601JK6010 spare-parts catalog route for the GSR18V-800C; the current depth and continued availability of individual parts were not independently established.', 'Partial: Bosch publishes an exact tool number 3601JK6010 parts catalog, but individual-part depth and continued availability are not yet verified.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-800cn-3601JK6010'), '2026-09-14', 180),
  (20, 'serviceability', 'The operating manual directs servicing to qualified repair personnel using identical replacement parts, and the warranty excludes damage caused by repairs outside Bosch or a Bosch Authorized Service Center.', 'Shop-serviceable through Bosch or authorized service; no owner-repair procedure is documented.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'), '2026-09-14', 180),
  (20, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-14', 180),
  (20, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-14', 30),
  (20, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-14', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  20,
  '5 years from purchase for qualifying purchases dated June 1, 2023 or later.',
  'Defects in material or workmanship for the original end-user purchaser; Bosch provides repair or replacement of covered defective parts.',
  'Published exclusions include damage from non-genuine Bosch parts, abuse, misuse, careless handling, and repairs outside Bosch or a Bosch Authorized Service Center; territorial terms also apply.',
  (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'),
  '2026-09-14'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  20,
  'partial',
  'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-800cn-3601JK6010',
  0,
  'https://ocsmedia.boschtools.com/binary/manualsmedia/o256028v2_2610070413_GSR18V800C_202308.pdf',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-800cn-3601JK6010'),
  '2026-09-14'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (20, 'Amazon Associates', 'https://www.amazon.com/dp/B0CRMB2TPF?tag=everlastin08f-20', 1, '2026-09-14');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '10');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-14');

COMMIT;
