PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/MAC5200', 'Makita MAC5200 official product page', 'manufacturer', '2026-10-05'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/MAC/6c053afe-5af8-4199-9800-542d3ad26216_MAC5200_IM.pdf', 'Makita MAC5200 oil-lubricated air-compressor owner manual', 'manufacturer', '2026-10-05'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/MAC/22580537-bd3c-41b9-ac3f-25cdf10bbfc0_MAC5200_PB.pdf', 'Makita MAC5200 exact-model parts breakdown', 'manufacturer', '2026-10-05'),
  ('https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx', 'Makita USA September 2026 parts price list', 'manufacturer', '2026-10-05'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-10-05'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA service-center support', 'manufacturer', '2026-10-05'),
  ('https://www.makitatools.com/service/directrepair', 'Makita USA Direct Repair terms and shipping limits', 'manufacturer', '2026-10-05'),
  ('https://www.makitatools.com/recall', 'Makita USA current safety notices', 'manufacturer', '2026-10-05'),
  ('https://www.amazon.com/dp/B0001Q2VPU', 'Amazon exact Makita MAC5200 destination', 'other', '2026-10-05');

UPDATE sources SET title = 'Makita USA warranty policy', retrieved_date = '2026-10-05'
WHERE url = 'https://www.makitatools.com/service/warranty';
UPDATE sources SET title = 'Makita USA service-center support', retrieved_date = '2026-10-05'
WHERE url = 'https://www.makitatools.com/service/service-centers';

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  33,
  'makita-mac5200',
  'Makita',
  'MAC5200',
  'MAC5200',
  'air-compressors',
  'tools-shop',
  'MAC5200 identifies the United States 120V, 5.2-gallon oil-lubricated Big Bore compressor package with two 1/4-inch universal quick couplers and compressor oil. Makita does not list an air hose or air tool as included. The MAC2400 and MAC700 are separate lower-output Big Bore compressor models; their package and owner evidence are not transferred.',
  'T2',
  'not-yet-verified',
  'Makita publishes the exact MAC5200 owner manual, a component-level parts breakdown, a current parts price list, warranty terms, and factory or authorized service paths. The manual supports substantial owner maintenance and an external check-valve procedure, while electrical, motor, pressure-control, and tank work retain safety or qualified-service boundaries. No qualifying exact-model owner report with verifiable ownership duration was accepted, so expected service life, repair economics, and a buy or repair recommendation remain unverified.',
  '2026-10-05'
);

INSERT INTO product_sources
SELECT 33, id, 'exact identity, construction, specifications, included oil and couplers, and package boundary' FROM sources WHERE url = 'https://www.makitatools.com/products/details/MAC5200';
INSERT INTO product_sources
SELECT 33, id, 'operation, break-in, duty cycle, oil and filter maintenance, tank draining, check-valve service, troubleshooting, and safety boundaries' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/6c053afe-5af8-4199-9800-542d3ad26216_MAC5200_IM.pdf';
INSERT INTO product_sources
SELECT 33, id, 'exact exploded diagram, component part numbers, and ring and gasket kits' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/22580537-bd3c-41b9-ac3f-25cdf10bbfc0_MAC5200_PB.pdf';
INSERT INTO product_sources
SELECT 33, id, 'dated current-catalog snapshot for repair-significant component numbers and supersession limits' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Sept%202026%20Parts%20Price%20List_2026_09_16_1425PM.xlsx';
INSERT INTO product_sources
SELECT 33, id, 'current general-product warranty coverage and exclusions' FROM sources WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 33, id, 'factory and authorized pneumatic-service paths' FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 33, id, 'factory repair path and 100-pound packaged-shipment limit' FROM sources WHERE url = 'https://www.makitatools.com/service/directrepair';
INSERT INTO product_sources
SELECT 33, id, 'current manufacturer safety-notice check; no exact MAC5200 notice listed' FROM sources WHERE url = 'https://www.makitatools.com/recall';
INSERT INTO product_sources
SELECT 33, id, 'exact Amazon model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B0001Q2VPU';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (33, 'identity', 'Makita identifies MAC5200 as a 120V, 3.0 maximum-horsepower Big Bore air compressor with a 5.2-gallon tank, oil-lubricated cast-iron pump, 6.5 CFM at 90 PSI, 140 PSI cut-out pressure, roll cage, folding handle, wheels, and two included 1/4-inch universal quick couplers. The owner manual lists 2.1 running horsepower, 13.8 amps at maximum pressure, and a recommended maximum 50 percent duty cycle.', '120V, 3.0 HP maximum, 5.2-gallon oil-lubricated compressor rated at 6.5 CFM at 90 PSI and 140 PSI, with two quick couplers.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/MAC5200'), '2026-10-05', 180),
  (33, 'warranty', 'Makita currently warrants general products against defects in workmanship and materials for one year from original purchase and may repair or replace after inspection. Published exclusions include third-party repair attempts, normal wear, abuse, misuse, improper maintenance or operation, and alterations.', 'One-year general-product limited warranty from original purchase; current Makita terms and exclusions apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'), '2026-10-05', 180),
  (33, 'repair_manual', 'The exact owner manual documents break-in, oil service every 300 operating hours or three months, tank draining, intake-filter care, safety-valve checks, annual pump-valve and check-valve inspection, external brass check-valve removal and replacement, and troubleshooting. It routes electrical work to qualified personnel and motor or capacitor faults to authorized service, so it is not a complete internal repair manual.', 'Exact owner manual covers oil, filter, tank, safety-valve, and external check-valve work; it is not a complete internal repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/6c053afe-5af8-4199-9800-542d3ad26216_MAC5200_IM.pdf'), '2026-10-05', 180),
  (33, 'parts_availability', 'Makita publishes an exact parts breakdown identifying the cylinder, piston, rings, crankshaft, connecting rod, motor and crankcase, tank and frame, regulator, gauges, check and safety valves, drain, switches, capacitors, ring kit, and gasket kit. Makita USA''s September 2026 parts price list still catalogs many repair-significant numbers, including the motor and crankcase 251209-E, tank and frame 401125-E, regulator 410029-E, ring kit RK5200-E, and gasket kit GK5200-E. Pressure switch 412025-E is marked discontinued with alternate 412024-E. The price list is a catalog snapshot, not proof of current stock or orderability for every component.', 'Partial: exact parts breakdown and current price list identify the motor, tank, regulator, ring and gasket kits; the pressure switch has an alternate, but stock and complete orderability are not verified.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/22580537-bd3c-41b9-ac3f-25cdf10bbfc0_MAC5200_PB.pdf'), '2026-10-05', 90),
  (33, 'serviceability', 'Owners can perform the documented oil fill and changes, tank draining, intake-filter replacement, leak checks, safety-valve checks, and external check-valve cleaning or replacement after unplugging and depressurizing the unit. Electrical work requires qualified service, motor or capacitor faults route to authorized service, and a leaking tank must be replaced rather than drilled, welded, or patched. Makita Direct Repair has a 100-pound packaged limit, while the product page lists a 107-pound shipping weight, so mail-in eligibility cannot be assumed.', 'User-serviceable for oil, filter, tank-drain, and external check-valve work; electrical faults go to authorized service, and a leaking tank must be replaced.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/6c053afe-5af8-4199-9800-542d3ad26216_MAC5200_IM.pdf'), '2026-10-05', 180),
  (33, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 180),
  (33, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 30),
  (33, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  33,
  'One-year general-product limited warranty.',
  'Defects in workmanship and materials; Makita may repair or replace after inspection under the current policy.',
  'Repairs made or attempted by others, normal wear and tear, abuse, misuse, improper maintenance or operation, and alterations are excluded; current Makita terms apply.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-10-05'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  33,
  'partial',
  'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/22580537-bd3c-41b9-ac3f-25cdf10bbfc0_MAC5200_PB.pdf',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/6c053afe-5af8-4199-9800-542d3ad26216_MAC5200_IM.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/6c053afe-5af8-4199-9800-542d3ad26216_MAC5200_IM.pdf'),
  '2026-10-05'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (33, 'Amazon Associates', 'https://www.amazon.com/dp/B0001Q2VPU?tag=everlastin08f-20', 1, '2026-10-05');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '35');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-05');

COMMIT;
