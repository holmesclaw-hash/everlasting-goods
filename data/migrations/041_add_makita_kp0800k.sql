PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/KP0800K', 'Makita KP0800K official US product page', 'manufacturer', '2026-10-09'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/KP0/69b0a804-31cf-45e1-a370-0dfb478ff682_KP0800K_IM.pdf', 'Makita KP0800 owner manual linked from the US KP0800K page', 'manufacturer', '2026-10-09'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/KP0/99eafa22-ff0d-4654-9ef1-c525d875c5e6_KP0800K_PB.pdf', 'Makita KP0800 parts breakdown linked from the US KP0800K page', 'manufacturer', '2026-10-09'),
  ('https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx', 'Makita USA September 2026 parts price list', 'manufacturer', '2026-10-09'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-10-09'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA service-center support', 'manufacturer', '2026-10-09'),
  ('https://www.makitatools.com/service/directrepair', 'Makita USA Direct Repair service', 'manufacturer', '2026-10-09'),
  ('https://www.makitatools.com/recall', 'Makita USA current safety notices', 'manufacturer', '2026-10-09'),
  ('https://www.cpsc.gov/manufacturer/makita', 'CPSC Makita manufacturer recall index', 'other', '2026-10-09'),
  ('https://www.productreview.com.au/reviews/c9fb61e2-1546-5478-982c-9553c0d69fb4', 'Regional Makita KP0800K owner report published June 2022', 'owner-report', '2026-10-09'),
  ('https://www.makitatools.com/products/buy-online/KP0800K', 'Makita USA KP0800K authorized online-dealer destinations', 'manufacturer', '2026-10-09'),
  ('https://www.amazon.com/dp/B0033WSK5O', 'Amazon exact Makita KP0800K destination', 'other', '2026-10-09');

UPDATE sources SET retrieved_date = '2026-10-09'
WHERE url IN (
  'https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx',
  'https://www.makitatools.com/service/warranty',
  'https://www.makitatools.com/service/service-centers',
  'https://www.makitatools.com/recall'
);

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  37,
  'makita-kp0800k',
  'Makita',
  'KP0800K',
  'KP0800K',
  'handheld-planers',
  'tools-shop',
  'This record is for the current U.S. KP0800K cased kit. The tool inside is identified as the KP0800 planer by the owner manual and parts drawings. The current U.S. package lists a D-46246 two-blade pack, 123010-1 blade gauge, 782209-3 socket wrench, 165581-2 guide rule, and 824892-1 tool case. KP0800 tool-only listings, KP0800KX packages, UK suffix variants, the New Zealand 230V configuration, and other regional voltages, accessories, warranties, and package contents are not transferred to this U.S. record.',
  'T2',
  'not-yet-verified',
  'Makita publishes a current exact U.S. KP0800K kit page, an owner manual and parts breakdown for the KP0800 tool inside the kit, a dated September 2026 parts list, one-year general-product warranty terms, and factory or authorized service routes. The owner manual documents blade installation, conventional-blade sharpening, dust-bag cleaning, and carbon-brush replacement but is not an internal repair manual. One regional exact-name owner report says the tool was bought in July 2020; the report was published in June 2022 and describes extensive hardwood use without issues, but it is anecdotal, regionally configured, and not representative. Expected service life, failure rate, repair economics, and a buy or repair recommendation remain unverified.',
  '2026-10-09'
);

INSERT INTO product_sources
SELECT 37, id, 'current exact US kit identity, UPC, specifications, current included equipment, and package' FROM sources WHERE url = 'https://www.makitatools.com/products/details/KP0800K';
INSERT INTO product_sources
SELECT 37, id, 'KP0800 tool operation, blade work, conventional-blade sharpening, dust collection, carbon-brush replacement, and authorized-service boundary' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/KP0/69b0a804-31cf-45e1-a370-0dfb478ff682_KP0800K_IM.pdf';
INSERT INTO product_sources
SELECT 37, id, 'dated KP0800 exploded diagrams, US 115V components, individual part numbers, and legacy standard equipment' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/KP0/99eafa22-ff0d-4654-9ef1-c525d875c5e6_KP0800K_PB.pdf';
INSERT INTO product_sources
SELECT 37, id, 'dated catalog evidence for frame, drum, belt, armature, field, switch, cord, and discontinued base components; not a live-stock check' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx';
INSERT INTO product_sources
SELECT 37, id, 'current general-product warranty coverage and exclusions' FROM sources WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 37, id, 'factory and authorized service paths' FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 37, id, 'general factory mail-in repair terms; exact-model eligibility was not independently confirmed' FROM sources WHERE url = 'https://www.makitatools.com/service/directrepair';
INSERT INTO product_sources
SELECT 37, id, 'current manufacturer safety-notice check; no exact KP0800 or KP0800K notice was found' FROM sources WHERE url = 'https://www.makitatools.com/recall';
INSERT INTO product_sources
SELECT 37, id, 'current CPSC manufacturer-index check; no exact KP0800 or KP0800K notice was found, which is not safety clearance' FROM sources WHERE url = 'https://www.cpsc.gov/manufacturer/makita';
INSERT INTO product_sources
SELECT 37, id, 'anecdotal regional exact-name ownership from July 2020 to a June 2022 report; not US configuration or population-level lifespan evidence' FROM sources WHERE url = 'https://www.productreview.com.au/reviews/c9fb61e2-1546-5478-982c-9553c0d69fb4';
INSERT INTO product_sources
SELECT 37, id, 'manufacturer dealer page that links the exact US KP0800K to Amazon ASIN B0033WSK5O' FROM sources WHERE url = 'https://www.makitatools.com/products/buy-online/KP0800K';
INSERT INTO product_sources
SELECT 37, id, 'exact Amazon KP0800K model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B0033WSK5O';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (37, 'identity', 'Makita identifies the current U.S. KP0800K, UPC 088381-603935, as a cased kit containing the corded KP0800 planer. The current product page specifies a 3-1/4-inch width, 3/32-inch maximum depth, 6.5 AMP motor, 17,000 RPM no-load speed, 11-1/4-inch overall length, and 5.7-pound tool weight.', '3-1/4-inch corded handheld planer with a 6.5 AMP motor, 17,000 RPM speed, 3/32-inch maximum planing depth, and 5.7-pound tool weight.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/KP0800K'), '2026-10-09', 180),
  (37, 'warranty', 'Makita currently warrants general products against defects in workmanship and materials for one year from original purchase and may repair or replace after inspection. Published exclusions include third-party repair attempts, normal wear and tear, abuse, misuse, improper maintenance or operation, alterations, and accessories.', 'One-year general-product limited warranty from original purchase; current Makita terms and exclusions apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'), '2026-10-09', 180),
  (37, 'repair_manual', 'The KP0800 owner manual linked from the U.S. KP0800K page documents removal, gauge alignment, installation, and clearance checks for mini and conventional blades; conventional-blade sharpening; dust-bag cleaning; and paired carbon-brush replacement. It routes repairs and other undocumented maintenance or adjustment to Makita authorized or factory service and does not provide motor, bearing, belt, switch, cord, base, or wiring repair procedures.', 'Exact owner manual covers blade work, conventional-blade sharpening, dust-bag cleaning, and carbon brushes; it is not an internal repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/KP0/69b0a804-31cf-45e1-a370-0dfb478ff682_KP0800K_IM.pdf'), '2026-10-09', 180),
  (37, 'parts_availability', 'Makita publishes a 2009 KP0800 parts breakdown identifying the 115V field and armature, main frame, drum, belt, switch, power cord, bases, bearings, pulleys, brushes, covers, and hardware. The September 2026 Makita USA workbook contains rows for the main frame, drum, belt, armature, field, switch, and cord, while both diagrammed base components are marked discontinued without alternates. The workbook is dated catalog evidence and does not prove live stock or complete orderability.', 'Partial: exact parts breakdown and September 2026 catalog cover motor, drum, belt, switch, and cord components, but both bases are discontinued and live stock and complete orderability are not verified.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/KP0/99eafa22-ff0d-4654-9ef1-c525d875c5e6_KP0800K_PB.pdf'), '2026-10-09', 90),
  (37, 'serviceability', 'Owners can perform documented blade removal, gauge setup and installation, conventional-blade sharpening, dust-bag cleaning, and paired carbon-brush replacement. The manual routes all other repairs and undocumented maintenance or adjustment to Makita authorized or factory service.', 'User-serviceable for blade setup, sharpening, cleaning, and carbon-brush replacement; internal repair routes to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/KP0/69b0a804-31cf-45e1-a370-0dfb478ff682_KP0800K_IM.pdf'), '2026-10-09', 180),
  (37, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-09', 180),
  (37, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-09', 30),
  (37, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-09', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  37,
  'One-year general-product limited warranty.',
  'Defects in workmanship and materials; Makita may repair or replace after inspection under the current policy.',
  'Repairs made or attempted by others, normal wear and tear, abuse, misuse, improper maintenance or operation, alterations, and accessories are excluded; current Makita terms apply.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-10-09'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  37,
  'partial',
  'https://cdn.makitatools.com/apps/cms/doc/prod/KP0/99eafa22-ff0d-4654-9ef1-c525d875c5e6_KP0800K_PB.pdf',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/KP0/69b0a804-31cf-45e1-a370-0dfb478ff682_KP0800K_IM.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/KP0/69b0a804-31cf-45e1-a370-0dfb478ff682_KP0800K_IM.pdf'),
  '2026-10-09'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (37, 'Amazon Associates', 'https://www.amazon.com/dp/B0033WSK5O?tag=everlastin08f-20', 1, '2026-10-09');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '41');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-09');

COMMIT;
