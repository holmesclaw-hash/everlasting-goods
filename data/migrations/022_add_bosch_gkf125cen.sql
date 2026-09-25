PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.boschtools.com/us/en/products/gkf125cen-0601628010', 'Bosch GKF125CEN official product page', 'manufacturer', '2026-09-24'),
  ('https://ocsmedia.boschtools.com/binary/manualsmedia/o200941v2_2610052572_0918_GKF125CE.pdf', 'Bosch GKF125CE operating and safety manual', 'manufacturer', '2026-09-24'),
  ('https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gkf125cen-3601F28110', 'Bosch GKF125CEN exact spare-parts route', 'manufacturer', '2026-09-24'),
  ('https://www.boschtools.com/us/en/service/replacement-parts', 'Bosch replacement-parts support', 'manufacturer', '2026-09-24'),
  ('https://www.boschtools.com/us/en/service/product-warranty', 'Bosch corded power-tool warranty', 'manufacturer', '2026-09-24'),
  ('https://www.reddit.com/r/BeginnerWoodWorking/comments/1oucjav/router_choice/', 'Three-year Bosch GKF125CEN owner report', 'owner-report', '2026-09-24'),
  ('https://www.reddit.com/r/Tools/comments/gwrtmo/bosch_resale_value/', 'Light-use Bosch GKF125CEN owner report', 'owner-report', '2026-09-24');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  25,
  'bosch-gkf125cen',
  'Bosch',
  'GKF125CEN',
  '0601628010',
  'routers',
  'tools-shop',
  'Standalone fixed-base GKF125CEN package with GKF125CE motor, PR101 base, 1/4-inch self-releasing collet, and collet wrench. Evidence from the GKF125CEK fixed-base kit and GKF125CEPK combination kit is not transferred to this record.',
  'T2',
  'not-yet-verified',
  'Bosch documentation establishes exact identity, an official operating and maintenance manual, an exact spare-parts route keyed to service number 3601F28110, current replacement-parts support, and a one-year corded-tool warranty. One exact-model owner reports liking the router after three years; another described a very lightly used example after a few home-DIY projects. These reports are anecdotal and do not establish representative service life, so expected lifespan and a buy or repair recommendation remain unverified.',
  '2026-09-24'
);

INSERT INTO product_sources
SELECT 25, id, 'identity, standalone package, construction, and exact service identifier' FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/gkf125cen-0601628010';
INSERT INTO product_sources
SELECT 25, id, 'operating, collet-care, brush-inspection, bearing, and authorized-service boundaries' FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o200941v2_2610052572_0918_GKF125CE.pdf';
INSERT INTO product_sources
SELECT 25, id, 'exact-model spare-parts route; temporarily unavailable at retrieval' FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gkf125cen-3601F28110';
INSERT INTO product_sources
SELECT 25, id, 'current Bosch original-parts ordering path' FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/replacement-parts';
INSERT INTO product_sources
SELECT 25, id, 'current corded portable power-tool warranty terms' FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty';
INSERT INTO product_sources
SELECT 25, id, 'three-year exact-model owner evidence' FROM sources WHERE url = 'https://www.reddit.com/r/BeginnerWoodWorking/comments/1oucjav/router_choice/';
INSERT INTO product_sources
SELECT 25, id, 'light-use exact-model owner evidence without duration' FROM sources WHERE url = 'https://www.reddit.com/r/Tools/comments/gwrtmo/bosch_resale_value/';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (25, 'identity', 'GKF125CEN order number 0601628010 is a 120V corded fixed-base palm router with a 7.0-amp 1.25 maximum-horsepower motor, 16,000 to 35,000 RPM variable speed, aluminum PR101 base, and 1/4-inch collet.', 'Corded fixed-base 1.25 HP maximum palm router with 16,000–35,000 RPM variable speed and a 1/4-inch collet.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/gkf125cen-0601628010'), '2026-09-24', 180),
  (25, 'warranty', 'Bosch currently warrants corded portable power tools to the original purchaser against defects in material or workmanship for one year from purchase, with repair or replacement through Bosch or an authorized service station and published exclusions.', '1-year limited warranty for Bosch corded portable power tools; current Bosch terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'), '2026-09-24', 180),
  (25, 'repair_manual', 'Bosch publishes an exact GKF125CE-family operating, safety, and maintenance manual that names GKF125CEN in its included-accessory table. It documents collet cleaning and brush inspection but recommends that all tool service be performed by a Bosch Factory Service Center or Authorized Bosch Service Station.', 'Official operating and maintenance manual is available; it is not an owner-repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o200941v2_2610052572_0918_GKF125CE.pdf'), '2026-09-24', 180),
  (25, 'parts_availability', 'Bosch links GKF125CEN service identifier 3601F28110 to an exact spare-parts route and maintains a current original replacement-parts ordering program. The exact catalog returned a maintenance page at retrieval, so individual component availability was not verified.', 'Partial: exact 3601F28110 spare-parts route is linked, but the catalog was temporarily unavailable and individual component availability is unverified.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/gkf125cen-0601628010'), '2026-09-24', 90),
  (25, 'serviceability', 'The manual documents collet cleaning and examination of carbon brushes every two to six months. It recommends Bosch Factory or Authorized Service for tool service and immediate bearing replacement when noisy, so internal repair is not characterized as owner-serviceable.', 'Shop-serviceable: owner collet care and brush inspection are documented; internal work is directed to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o200941v2_2610052572_0918_GKF125CE.pdf'), '2026-09-24', 180),
  (25, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 180),
  (25, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 30),
  (25, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  25,
  '1-year limited warranty for corded portable power tools.',
  'Repair or replacement of parts defective in material or workmanship for the original purchaser during the one-year period.',
  'Published terms exclude misuse, careless handling, improper third-party repair, accessories, and consequential damages; current terms and jurisdictional rights control.',
  (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'),
  '2026-09-24'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  25,
  'partial',
  'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gkf125cen-3601F28110',
  0,
  'https://ocsmedia.boschtools.com/binary/manualsmedia/o200941v2_2610052572_0918_GKF125CE.pdf',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o200941v2_2610052572_0918_GKF125CE.pdf'),
  '2026-09-24'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (25, 'Amazon Associates', 'https://www.amazon.com/dp/B01AX4A95S?tag=everlastin08f-20', 1, '2026-09-24');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '22');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-24');

COMMIT;
