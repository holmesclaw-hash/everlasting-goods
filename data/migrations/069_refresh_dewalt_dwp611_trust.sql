PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router', 'DEWALT DWP611 official product page', 'manufacturer', '2026-11-22'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf', 'DEWALT DWP611 Type 1 instruction and maintenance manual N336740', 'manufacturer', '2026-11-22'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611', 'DEWALT ServiceNet DWP611 Type 1 parts catalog', 'manufacturer', '2026-11-22'),
  ('https://www.dewalt.com/en-us/support/warranty', 'DEWALT current warranty policy', 'manufacturer', '2026-11-22'),
  ('https://www.reddit.com/r/XCarve/comments/1gfuiml/best_spindlerouter_for_original_xcarve', 'Reddit XCarve thread with a five-year DWP611 brush-replacement report', 'owner-report', '2026-11-22'),
  ('https://www.reddit.com/r/Tools/comments/4clk9r/dewalt_dwp611_router_problems', 'Reddit Tools thread with an eighteen-month DWP611 speed-control and sparking failure report', 'owner-report', '2026-11-22'),
  ('https://www.reddit.com/r/CNC/comments/1ket792/dewalt_dwp611_help', 'Reddit CNC thread with an eight-year four-unit DWP611 report', 'owner-report', '2026-11-22'),
  ('https://www.amazon.com/dp/B0048EFUV8', 'Amazon exact DEWALT DWP611 destination', 'other', '2026-11-22')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router' AS url,
         'current exact fixed-base identity, construction, package contents, specifications, and product-specific warranty program' AS purpose
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf',
         'Type 1 operation, maintenance, 100-hour inspection, brush-service, and qualified-repair boundaries'
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611',
         'current Type 1 component catalog, purchasability, and internally inconsistent stock snapshot'
  UNION ALL SELECT 'https://www.dewalt.com/en-us/support/warranty',
         'current three-year limited warranty, first-year service, seller eligibility, exclusions, and proof requirements'
  UNION ALL SELECT 'https://www.reddit.com/r/XCarve/comments/1gfuiml/best_spindlerouter_for_original_xcarve',
         'anecdotal exact-model five-year medium-use report with one brush replacement'
  UNION ALL SELECT 'https://www.reddit.com/r/Tools/comments/4clk9r/dewalt_dwp611_router_problems',
         'anecdotal exact-model variable-speed and sparking failure report after eighteen months'
  UNION ALL SELECT 'https://www.reddit.com/r/CNC/comments/1ket792/dewalt_dwp611_help',
         'anecdotal exact-model report covering four CNC-mounted routers over about eight years, with one overload-related failure described'
  UNION ALL SELECT 'https://www.amazon.com/dp/B0048EFUV8',
         'exact-model commercial destination; current page identifies DWP611 and exposes a new-item buying path'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'dewalt-dwp611';

UPDATE products
SET variant_notes = 'DWP611 is the exact U.S. corded fixed-base Type 1 package with the DWP611 motor, standard fixed base, wrench, and instruction manual. DWP611PK is the separate combination kit that adds a plunge base and is not this record.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'DEWALT currently identifies DWP611 as the corded fixed-base variable-speed compact router and publishes the Type 1 instruction manual plus a current ServiceNet catalog. The exact catalog exposed 58 component entries on 2026-11-22 and marked 57 purchasable, including the armature, field, brushes, switch, collet, bearings, cordset, housing, and base assembly. Every component carried an in-stock status, but two entries—the LED light and field case—reported stock level zero, so the snapshot is internally inconsistent and does not guarantee checkout success, complete revision coverage, or future supply. Exact-model owner evidence is mixed: one report describes five years of regular medium use with one brush replacement; another says four DWP611 routers had been used for CNC carving over about eight years, with the only described failure following an oversized bit plowing hard oak; a separate owner reported variable-speed malfunction and sparking after eighteen months. These anecdotes do not establish representative expected service life or failure rate, so annual maintenance cost, repair economics, and a buy-or-repair recommendation remain unverified.',
    last_reviewed_date = '2026-11-22'
WHERE slug = 'dewalt-dwp611';

UPDATE product_fields
SET raw_value = 'DEWALT identifies DWP611 as the U.S. corded fixed-base compact router with a 1.25 HP maximum motor, 7-amp input, variable speed from 16,000 to 27,000 RPM, aluminum motor housing and base, and an extended 1/4-inch collet. The package includes the motor, standard base, wrench, and instruction manual.',
    display_value = 'DWP611 corded fixed-base compact router: 1.25 HP maximum, 7-amp input, 16,000-27,000 RPM, aluminum housing and base, and 1/4-inch collet.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router'),
    verified_date = '2026-11-22',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact DWP611 Type 1 ServiceNet catalog exposed 58 component entries on 2026-11-22 and marked 57 purchasable. Major assemblies and wear parts with positive reported stock included the armature, field, brushes, brush holders, switch, collet, bearings, cordset, motor housing, and base assembly. All 58 entries carried an in-stock status, but the LED light and field case reported stock level zero. This internally inconsistent snapshot does not prove checkout success, compatibility with every revision, or future supply.',
    display_value = 'Partial: the Type 1 catalog exposed 58 entries and marked 57 purchasable, including armature, field, brush, switch, collet, bearing, cord, housing, and base parts; two entries paired in-stock status with zero stock, so the snapshot is internally inconsistent.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611'),
    verified_date = '2026-11-22',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'DEWALT publishes the N336740 Type 1 DWP611 instruction manual covering operation, cleaning, lubrication status, waxing the motor and base, a roughly 100-hour inspection interval, brush inspection, and repair routing. It is an operating and maintenance manual, not a comprehensive owner-repair manual.',
    display_value = 'Official Type 1 operating and maintenance manual is available; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf'),
    verified_date = '2026-11-22',
    reverify_days = 365
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The manual documents weekly dry-air vent cleaning, ordinary exterior cleaning, and waxing between the motor and base. Around 100 hours of use, DEWALT directs the tool to a factory or authorized service center for cleaning, inspection, worn-part replacement, fresh lubricant, new brushes, and performance testing. Brush inspection and replacement plus all deeper repairs are assigned to qualified service personnel.',
    display_value = 'Shop-serviceable: owner care covers cleaning and waxing; around 100 hours, brush work and deeper repairs are directed to DEWALT or other qualified service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf'),
    verified_date = '2026-11-22',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'The current DEWALT policy states that products carrying this package receive a three-year limited warranty against faulty materials or workmanship for the original end-user purchaser, a one-year free service contract covering maintenance and normal-use worn-part replacement, and a 90-day money-back guarantee. Current authorized-seller, proof, normal-wear, abuse, accessory, and unauthorized-repair terms apply.',
    display_value = '3-year limited warranty, 1-year free service, and 90-day money-back guarantee for the original end-user; current authorized-seller and exclusion terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
    verified_date = '2026-11-22',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-22',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611')
  AND name IN ('expected_service_life', 'annual_maintenance_cost');

UPDATE product_fields
SET verified_date = '2026-11-22',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611',
    repair_manual_available = 0,
    repair_manual_url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611'),
    verified_date = '2026-11-22'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611');

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
)
SELECT
  p.id,
  '3-year limited warranty; 1-year free service; 90-day money-back guarantee.',
  'For products stating this package, DEWALT covers defects due to faulty materials or workmanship for the original end-user purchaser and provides first-year maintenance plus replacement of worn parts caused by normal use.',
  'Current terms exclude normal-wear failures from the three-year defect warranty, tool abuse, accessories, unauthorized repair damage, and in many cases products from unauthorized sellers; proof requirements and applicable law control.',
  s.id,
  '2026-11-22'
FROM products p
JOIN sources s ON s.url = 'https://www.dewalt.com/en-us/support/warranty'
WHERE p.slug = 'dewalt-dwp611'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-22'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwp611')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B0048EFUV8?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '69');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-22');

COMMIT;
