PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/XCV22PTU', 'Makita XCV22PTU official kit page', 'manufacturer', '2026-10-04'),
  ('https://makitatools.com/products/details/XCV22ZU', 'Makita XCV22ZU official tool-only page', 'manufacturer', '2026-10-04'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XCV/327ba01a-87b8-469b-b38e-6be962ae4f80_XCV22,XCV25_IM.pdf', 'Makita XCV22 and XCV25 instruction manual', 'manufacturer', '2026-10-04'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XCV/0334bc58-3f68-4102-9b70-b4ea1c4be548_XCV22_PB_Breakdown_XCV22PTU,ZU_03-22.pdf', 'Makita XCV22PTU and XCV22ZU parts breakdown', 'manufacturer', '2026-10-04'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-10-04'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA service-center support', 'manufacturer', '2026-10-04'),
  ('https://makitatools.com/company/press-releases/2022/makita-expands-dust-extraction-system-with-new-hepa-dry-vaccum', 'Makita XCV22 launch release', 'manufacturer', '2026-10-04'),
  ('https://www.amazon.com/dp/B0B52D7QP4', 'Amazon exact Makita XCV22PTU destination', 'other', '2026-10-04'),
  ('https://acmetools.com/makita-36v-18v-x2-lxt-21-gallon-hepa-dry-dust-extractor-vacuum-kit-aws-xcv22ptu/088381898867.html', 'Acme Tools XCV22PTU commercial corroboration', 'other', '2026-10-04');

UPDATE sources
SET title = 'Makita USA warranty policy', retrieved_date = '2026-10-04'
WHERE url = 'https://www.makitatools.com/service/warranty';
UPDATE sources
SET title = 'Makita USA service-center support', retrieved_date = '2026-10-04'
WHERE url = 'https://www.makitatools.com/service/service-centers';

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  30,
  'makita-xcv22ptu',
  'Makita',
  'XCV22PTU',
  'XCV22PTU',
  'dust-extractors',
  'tools-shop',
  'XCV22PTU is the complete kit containing the XCV22ZU vacuum, two BL1850B 5.0Ah batteries, a DC18RD dual-port charger, a 198901-5 AWS transmitter, filters, hoses, adapters, wand, nozzle, bags, and storage accessories. XCV22ZU is the separate tool-only package and its official page is currently labeled discontinued; the XCV22PTU kit page remains available without that label. Evidence from the larger XCV25, the separate XCV21, and other vacuum packages is not transferred.',
  'T2',
  'not-yet-verified',
  'Makita introduced XCV22 in 2022 and currently documents the exact XCV22PTU kit, owner filter and tank maintenance, an exact XCV22 exploded parts breakdown, authorized repair routes, and a three-year lithium-ion tool, battery, and charger warranty. No qualifying exact-SKU owner report with ownership duration was located, and the official tool-only XCV22ZU page is now marked discontinued while the kit page remains active. Those facts do not establish expected service life or long-term component orderability, so expected service life and a buy or repair recommendation remain unverified.',
  '2026-10-04'
);

INSERT INTO product_sources
SELECT 30, id, 'exact kit identity, included vacuum, batteries, charger, AWS transmitter, accessories, specifications, and warranty statement' FROM sources WHERE url = 'https://www.makitatools.com/products/details/XCV22PTU';
INSERT INTO product_sources
SELECT 30, id, 'separate tool-only identity and current discontinued-page boundary' FROM sources WHERE url = 'https://makitatools.com/products/details/XCV22ZU';
INSERT INTO product_sources
SELECT 30, id, 'owner operation, filter and tank maintenance, troubleshooting, and authorized-service boundary' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/327ba01a-87b8-469b-b38e-6be962ae4f80_XCV22,XCV25_IM.pdf';
INSERT INTO product_sources
SELECT 30, id, 'exact XCV22 exploded diagram and component part numbers' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/0334bc58-3f68-4102-9b70-b4ea1c4be548_XCV22_PB_Breakdown_XCV22PTU,ZU_03-22.pdf';
INSERT INTO product_sources
SELECT 30, id, 'current lithium-ion tool, battery, and charger warranty terms' FROM sources WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 30, id, 'factory, authorized, and direct-repair service paths' FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 30, id, '2022 model introduction and kit-versus-tool-only package distinction' FROM sources WHERE url = 'https://makitatools.com/company/press-releases/2022/makita-expands-dust-extraction-system-with-new-hepa-dry-vaccum';
INSERT INTO product_sources
SELECT 30, id, 'exact Amazon model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B0B52D7QP4';
INSERT INTO product_sources
SELECT 30, id, 'independent SKU, UPC, kit contents, and accessory orderability corroboration' FROM sources WHERE url = 'https://acmetools.com/makita-36v-18v-x2-lxt-21-gallon-hepa-dry-dust-extractor-vacuum-kit-aws-xcv22ptu/088381898867.html';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (30, 'identity', 'Makita identifies XCV22PTU as its 36V (18V X2) LXT brushless 2.1-gallon HEPA dry dust extractor and vacuum kit with AWS. The package contains the XCV22ZU vacuum, two BL1850B 5.0Ah batteries, a DC18RD dual-port charger, a 198901-5 AWS transmitter, two anti-static hoses, adapters, wand, nozzle, HEPA filter, damper, pre-filter, bags, storage caddy, and wand hook. Makita specifies 120 CFM, 44 inches of water lift, and UPC 088381898867.', '36V (18V X2) brushless 2.1-gallon dry XCV22PTU kit: XCV22ZU vacuum, two 5.0Ah batteries, DC18RD charger, AWS transmitter, filters, hoses, and cleaning accessories.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/XCV22PTU'), '2026-10-04', 180),
  (30, 'warranty', 'Makita classifies this lithium-ion kit for a three-year limited warranty covering the tool, included lithium-ion batteries, and charger against defects in workmanship and materials from original purchase, subject to current terms and exclusions.', 'Three-year limited warranty for the lithium-ion tool, batteries, and charger; current Makita terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'), '2026-10-04', 180),
  (30, 'repair_manual', 'Makita publishes an XCV22 and XCV25 instruction manual covering setup, operation, wireless registration and troubleshooting, tank emptying, HEPA powder-filter, pre-filter, and damper cleaning, and filter replacement. The manual directs repairs and other maintenance or adjustment to Makita Authorized or Factory Service Centers, so it is not an owner-repair manual.', 'Official owner manual covers filter and tank maintenance plus troubleshooting; it is not an internal repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/327ba01a-87b8-469b-b38e-6be962ae4f80_XCV22,XCV25_IM.pdf'), '2026-10-04', 180),
  (30, 'parts_availability', 'Makita publishes an exact XCV22 parts breakdown for XCV22PTU and XCV22ZU with part numbers for the motor assembly, rotor, stator, controllers, switches, terminals, filters, dampers, tank, casters, hoses, nozzles, AWS unit, and storage caddy. The active kit page links current maintenance-accessory pages, but current orderability was not verified for each internal component.', 'Partial: the exact XCV22 parts breakdown identifies the motor, rotor, stator, controllers, switches, filters, tank, casters, and accessories, but internal component orderability is not verified.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/0334bc58-3f68-4102-9b70-b4ea1c4be548_XCV22_PB_Breakdown_XCV22PTU,ZU_03-22.pdf'), '2026-10-04', 90),
  (30, 'serviceability', 'The manual documents owner tank emptying, bag handling, filter, pre-filter, and damper cleaning, filter replacement, wireless troubleshooting, and battery-care practices. It directs internal repair and all other maintenance or adjustment to Makita Authorized or Factory Service Centers; Makita maintains current direct-repair and service-center routes.', 'Owner maintenance covers the filters, damper, bags, and tank; internal work is directed to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/327ba01a-87b8-469b-b38e-6be962ae4f80_XCV22,XCV25_IM.pdf'), '2026-10-04', 180),
  (30, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-04', 180),
  (30, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-04', 30),
  (30, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-04', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  30,
  'Three-year limited warranty for the lithium-ion tool, batteries, and charger from original purchase.',
  'Repair or replacement after inspection when trouble during the three-year period is caused by defective workmanship or material.',
  'Published exclusions include third-party repair attempts, normal wear, abuse, misuse, improper maintenance or operation, non-genuine batteries, and alteration; current terms and jurisdictional rights control.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-10-04'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  30,
  'partial',
  'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/0334bc58-3f68-4102-9b70-b4ea1c4be548_XCV22_PB_Breakdown_XCV22PTU,ZU_03-22.pdf',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/327ba01a-87b8-469b-b38e-6be962ae4f80_XCV22,XCV25_IM.pdf',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XCV/327ba01a-87b8-469b-b38e-6be962ae4f80_XCV22,XCV25_IM.pdf'),
  '2026-10-04'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (30, 'Amazon Associates', 'https://www.amazon.com/dp/B0B52D7QP4?tag=everlastin08f-20', 1, '2026-10-04');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '32');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-04');

COMMIT;
