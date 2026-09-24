PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.boschtools.com/us/en/products/pr20evs-060160A71A', 'Bosch PR20EVS official product page', 'manufacturer', '2026-09-24'),
  ('https://ocsmedia.boschtools.com/binary/manualsmedia/o18973v2_2610021461_0612_PR1020E.pdf', 'Bosch PR10E and PR20EVS operating and safety manual', 'manufacturer', '2026-09-24'),
  ('https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/pr20evs-3601F0A710', 'Bosch PR20EVS exact spare-parts route', 'manufacturer', '2026-09-24'),
  ('https://www.boschtools.com/us/en/service/replacement-parts', 'Bosch replacement-parts support', 'manufacturer', '2026-09-24'),
  ('https://www.boschtools.com/us/en/service/product-warranty', 'Bosch corded power-tool warranty', 'manufacturer', '2026-09-24'),
  ('https://www.aconcordcarpenter.com/bosch-colt-router.html', 'Five-year Bosch PR20EVS owner report', 'owner-report', '2026-09-24'),
  ('https://www.lumberjocks.com/threads/bosch-colt-pr20evs-vs-gkf125cek.315259/', 'Several-year Bosch PR20EVS owner report and depth-adjustment limitations', 'owner-report', '2026-09-24');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  23,
  'bosch-pr20evs',
  'Bosch',
  'PR20EVS',
  '060160A71A',
  'routers',
  'tools-shop',
  'Standalone fixed-base PR20EVS package with PR001 base, 1/4-inch collet, shaft wrench, and collet wrench. Evidence from PR20EVSPK and PR20EVSNK package variants is not transferred to this record.',
  'T2',
  'not-yet-verified',
  'Bosch documentation establishes exact identity, an official operating and maintenance manual, an exact spare-parts route keyed to service number 3601F0A710, current replacement-parts support, and a one-year corded-tool warranty. One exact-model owner reports five years and hundreds of cuts; another reports several years of light use but recurring frustration with the depth adjustment and locking system. These owner reports are anecdotal and do not establish representative service life, so expected lifespan and a buy or repair recommendation remain unverified.',
  '2026-09-24'
);

INSERT INTO product_sources
SELECT 23, id, 'identity, standalone package, construction, and exact service identifier' FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/pr20evs-060160A71A';
INSERT INTO product_sources
SELECT 23, id, 'operating, maintenance, brush-inspection, and authorized-service boundaries' FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o18973v2_2610021461_0612_PR1020E.pdf';
INSERT INTO product_sources
SELECT 23, id, 'exact-model spare-parts route; temporarily unavailable at retrieval' FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/pr20evs-3601F0A710';
INSERT INTO product_sources
SELECT 23, id, 'current Bosch original-parts ordering path' FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/replacement-parts';
INSERT INTO product_sources
SELECT 23, id, 'current corded portable power-tool warranty terms' FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty';
INSERT INTO product_sources
SELECT 23, id, 'five-year exact-model owner evidence' FROM sources WHERE url = 'https://www.aconcordcarpenter.com/bosch-colt-router.html';
INSERT INTO product_sources
SELECT 23, id, 'several-year exact-model owner evidence and depth-adjustment limitations' FROM sources WHERE url = 'https://www.lumberjocks.com/threads/bosch-colt-pr20evs-vs-gkf125cek.315259/';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (23, 'identity', 'PR20EVS order number 060160A71A is a 120V corded fixed-base palm router with a 5.6-amp 1.0 maximum-horsepower motor, 16,000 to 35,000 RPM variable speed, aluminum PR001 base, and 1/4-inch collet.', 'Corded fixed-base 1.0 HP maximum palm router with 16,000–35,000 RPM variable speed and a 1/4-inch collet.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/pr20evs-060160A71A'), '2026-09-24', 180),
  (23, 'warranty', 'Bosch currently warrants corded portable power tools to the original purchaser against defects in material or workmanship for one year from purchase, with repair or replacement through Bosch or an authorized service station and published exclusions.', '1-year limited warranty for Bosch corded portable power tools; current Bosch terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'), '2026-09-24', 180),
  (23, 'repair_manual', 'Bosch publishes an exact PR20EVS operating, safety, and maintenance manual. It documents collet cleaning, brush inspection, and clamp-tension adjustment, but recommends that all tool service be performed by a Bosch Factory Service Center or Authorized Bosch Service Station.', 'Official operating and maintenance manual is available; it is not an owner-repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o18973v2_2610021461_0612_PR1020E.pdf'), '2026-09-24', 180),
  (23, 'parts_availability', 'Bosch links PR20EVS service identifier 3601F0A710 to an exact spare-parts route and maintains a current original replacement-parts ordering program. The exact catalog returned a maintenance page at retrieval, so individual component availability was not verified.', 'Partial: exact 3601F0A710 spare-parts route is linked, but the catalog was temporarily unavailable and individual component availability is unverified.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/pr20evs-060160A71A'), '2026-09-24', 90),
  (23, 'serviceability', 'The manual documents routine collet cleaning, brush inspection, and limited clamp adjustment. It recommends Bosch Factory or Authorized Service for tool service and bearing replacement, so internal repair is not characterized as owner-serviceable.', 'Shop-serviceable: owner brush inspection and routine cleaning are documented; internal work is directed to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o18973v2_2610021461_0612_PR1020E.pdf'), '2026-09-24', 180),
  (23, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 180),
  (23, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 30),
  (23, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-24', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  23,
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
  23,
  'partial',
  'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/pr20evs-3601F0A710',
  0,
  'https://ocsmedia.boschtools.com/binary/manualsmedia/o18973v2_2610021461_0612_PR1020E.pdf',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o18973v2_2610021461_0612_PR1020E.pdf'),
  '2026-09-24'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (23, 'Amazon Associates', 'https://www.amazon.com/dp/B01M0J08MF?tag=everlastin08f-20', 1, '2026-09-24');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '20');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-24');

COMMIT;
