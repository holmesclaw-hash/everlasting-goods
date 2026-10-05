PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/XCV24ZX', 'Makita XCV24ZX official discontinued product page', 'manufacturer', '2026-10-05'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XCV/b58f6877-de2d-4939-96c0-2ea531cdeddd_XCV24_IM.pdf', 'Makita XCV21 and XCV24 instruction manual', 'manufacturer', '2026-10-05'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XCV/2c7a26bd-5cec-457d-87d5-c35c68b0d626_XCV24_PB_Breakdown_XCV24ZX_03-22.pdf', 'Makita XCV24ZX parts breakdown', 'manufacturer', '2026-10-05'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XCV/f0459c40-0721-4500-849e-c26581c4f5ef_XCV24ZX_NTFE.pdf', 'Makita XCV24ZX new-tool overview', 'manufacturer', '2026-10-05'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-10-05'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA service-center support', 'manufacturer', '2026-10-05'),
  ('https://makitatools.com/company/press-releases/2022/makita-expands-dust-extraction-system-with-two-new-hepa-dry-vacuums', 'Makita XCV21 and XCV24 launch release', 'manufacturer', '2026-10-05'),
  ('https://www.ereplacementparts.com/models/canister-vacuum/makita/id1348887/xcv24zx/', 'eReplacementParts XCV24ZX OEM-parts snapshot', 'other', '2026-10-05'),
  ('https://www.amazon.com/dp/B09SNVX392', 'Amazon exact Makita XCV24ZX destination', 'other', '2026-10-05'),
  ('https://toolup.com/products/makita-xcv24zx-36v-18v-x2-lxt-hepa-filter-dry-dust-extractor-4-gal-tool-only', 'Toolup XCV24ZX commercial corroboration', 'other', '2026-10-05');

UPDATE sources SET title = 'Makita USA warranty policy', retrieved_date = '2026-10-05'
WHERE url = 'https://www.makitatools.com/service/warranty';
UPDATE sources SET title = 'Makita USA service-center support', retrieved_date = '2026-10-05'
WHERE url = 'https://www.makitatools.com/service/service-centers';

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  31,
  'makita-xcv24zx',
  'Makita',
  'XCV24ZX',
  'XCV24ZX',
  'dust-extractors',
  'tools-shop',
  'XCV24ZX is the four-gallon dry dust extractor sold as a tool-only package; Makita now labels its official product page discontinued. Batteries and charger are not included. XCV21ZX and XCV21PTX are separate 2.1-gallon packages, XCV25ZX is a separate 18V four-gallon AWS vacuum, and XCV23Z is a separate wet/dry package. Evidence from those sibling products is not transferred.',
  'T2',
  'not-yet-verified',
  'Makita introduced XCV24ZX in 2022 and still publishes the exact owner manual, exploded parts breakdown, service paths, and warranty policy, but the current official product page is marked discontinued. A third-party OEM-parts snapshot shows mixed availability rather than complete support, and no qualifying exact-SKU owner report with ownership duration was located. Expected service life, repair economics, and a buy or repair recommendation remain unverified.',
  '2026-10-05'
);

INSERT INTO product_sources
SELECT 31, id, 'exact tool-only identity, discontinued status, specifications, included maintenance items, and package boundary' FROM sources WHERE url = 'https://www.makitatools.com/products/details/XCV24ZX';
INSERT INTO product_sources
SELECT 31, id, 'owner operation, filter and tank maintenance, battery care, and authorized-service boundary' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/b58f6877-de2d-4939-96c0-2ea531cdeddd_XCV24_IM.pdf';
INSERT INTO product_sources
SELECT 31, id, 'exact exploded diagram and internal component part numbers' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/2c7a26bd-5cec-457d-87d5-c35c68b0d626_XCV24_PB_Breakdown_XCV24ZX_03-22.pdf';
INSERT INTO product_sources
SELECT 31, id, 'exact specifications, UPC, standard equipment, and tool-only battery boundary' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/f0459c40-0721-4500-849e-c26581c4f5ef_XCV24ZX_NTFE.pdf';
INSERT INTO product_sources
SELECT 31, id, 'current lithium-ion tool, battery, and charger warranty terms' FROM sources WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 31, id, 'factory, authorized, and direct-repair service paths' FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 31, id, 'February 2022 introduction and XCV21-versus-XCV24 package distinctions' FROM sources WHERE url = 'https://makitatools.com/company/press-releases/2022/makita-expands-dust-extraction-system-with-two-new-hepa-dry-vacuums';
INSERT INTO product_sources
SELECT 31, id, 'dated third-party snapshot showing mixed OEM-part availability, not manufacturer-wide availability' FROM sources WHERE url = 'https://www.ereplacementparts.com/models/canister-vacuum/makita/id1348887/xcv24zx/';
INSERT INTO product_sources
SELECT 31, id, 'exact Amazon model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B09SNVX392';
INSERT INTO product_sources
SELECT 31, id, 'independent SKU, UPC, package contents, and tool-only corroboration' FROM sources WHERE url = 'https://toolup.com/products/makita-xcv24zx-36v-18v-x2-lxt-hepa-filter-dry-dust-extractor-4-gal-tool-only';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (31, 'identity', 'Makita identifies XCV24ZX as its 36V (18V X2) LXT brushless four-gallon HEPA dry dust extractor, tool only. The package includes an anti-static hose, HEPA filter, damper, pre-filter, disposal bags, three cuff adapters, and storage caddy; batteries and charger are not included. Makita specifies UPC 088381898959 and now labels the official product page discontinued.', '36V (18V X2) brushless four-gallon dry HEPA extractor, tool-only; batteries and charger not included; UPC 088381898959; official product page marked discontinued.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/XCV24ZX'), '2026-10-05', 90),
  (31, 'warranty', 'Makita currently warrants lithium-ion tools, batteries, and chargers against defects in workmanship and materials for three years from original purchase, subject to current terms and exclusions. XCV24ZX is sold without batteries or charger, so package contents and warranty coverage must not be conflated.', 'Three-year limited warranty for the lithium-ion tool; separately purchased Makita batteries and chargers have their own three-year coverage under current terms.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'), '2026-10-05', 180),
  (31, 'repair_manual', 'Makita publishes a shared XCV21 and XCV24 instruction manual covering setup, operation, battery care, filter installation and cleaning, tank and bag emptying, hose care, storage, and troubleshooting. It directs repairs and other maintenance or adjustment to Makita Authorized or Factory Service Centers, so it is not an internal repair manual.', 'Official owner manual covers filter, tank, bag, hose, and battery maintenance; it is not an internal repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/b58f6877-de2d-4939-96c0-2ea531cdeddd_XCV24_IM.pdf'), '2026-10-05', 180),
  (31, 'parts_availability', 'Makita publishes an exact XCV24ZX parts breakdown identifying the motor assembly, rotor, stator, controllers, switches, terminals, HEPA and pre-filters, dampers, tank, casters, hose, cuffs, and storage box. A dated third-party OEM-parts snapshot shows mixed availability, including some stocked or special-order hardware and at least one damper marked no longer available. This snapshot does not establish manufacturer-wide orderability for every component.', 'Partial: the exact XCV24 parts breakdown identifies the motor, rotor, stator, controllers, filters, tank, and accessories; a dated reseller snapshot shows mixed orderability rather than complete support.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/2c7a26bd-5cec-457d-87d5-c35c68b0d626_XCV24_PB_Breakdown_XCV24ZX_03-22.pdf'), '2026-10-05', 90),
  (31, 'serviceability', 'The manual documents owner filter cleaning and replacement, tank and bag emptying, hose care, battery care, caster operation, and basic troubleshooting. It directs internal repair and all other maintenance or adjustment to Makita Authorized or Factory Service Centers using Makita replacement parts.', 'Owner maintenance covers filters, bags, hose, batteries, and tank; internal work is directed to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/b58f6877-de2d-4939-96c0-2ea531cdeddd_XCV24_IM.pdf'), '2026-10-05', 180),
  (31, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 180),
  (31, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 30),
  (31, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  31,
  'Three-year limited warranty for the lithium-ion tool; batteries and charger are not included in XCV24ZX.',
  'Repair or replacement after inspection when trouble during the three-year period is caused by defective workmanship or material; separately purchased lithium-ion batteries and chargers have their own coverage under the policy.',
  'Published exclusions include third-party repair attempts, normal wear, abuse, misuse, improper maintenance or operation, non-genuine batteries, and alteration; current terms and jurisdictional rights control.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-10-05'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  31,
  'partial',
  'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/2c7a26bd-5cec-457d-87d5-c35c68b0d626_XCV24_PB_Breakdown_XCV24ZX_03-22.pdf',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/b58f6877-de2d-4939-96c0-2ea531cdeddd_XCV24_IM.pdf',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/b58f6877-de2d-4939-96c0-2ea531cdeddd_XCV24_IM.pdf'),
  '2026-10-05'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (31, 'Amazon Associates', 'https://www.amazon.com/dp/B09SNVX392?tag=everlastin08f-20', 1, '2026-10-05');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '33');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-05');

COMMIT;
