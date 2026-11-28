PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dcd801b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only', 'DEWALT DCD801B official product page', 'manufacturer', '2026-11-28'),
  ('https://www.dewalt.com/en-us/product/dcd801qq2/20v-max-xr-brushless-cordless-12-drilldriver-2-4ah-powerpack-batteries', 'DEWALT DCD801QQ2 kit product page', 'manufacturer', '2026-11-28'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Instruction_Manual/EN/NA283252_man_cordless_drill_drivers_DCD801_DCD806_NA.pdf', 'DEWALT DCD801 and DCD806 Type 1 North America instruction manual', 'manufacturer', '2026-11-28'),
  ('https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-XR-DRILL-DRIVER---BARE/p/DCD801B_1', 'DEWALT ServiceNet DCD801B Type 1 parts catalog', 'manufacturer', '2026-11-28'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Exploded_Diagram/EN/NA370838-SRD1_DCD801_.svg', 'DEWALT DCD801B Type 1 exploded diagram', 'manufacturer', '2026-11-28'),
  ('https://www.dewalt.com/en-us/support/warranty', 'DEWALT current warranty terms', 'manufacturer', '2026-11-28'),
  ('https://www.reddit.com/r/Dewalt/comments/1vj2fpl/dcd801qq2_hd_in_store_clearance_135/', 'Reddit: several-month DCD801 report from a DCD801QQ2 kit', 'owner-report', '2026-11-28'),
  ('https://www.youtube.com/watch?v=Bq5epMgLdQk', 'Black and Yellow Tool: new DCD801 repair and return-to-service report', 'other', '2026-11-28'),
  ('https://www.dewalt.com/en-us/support/safety-notices-and-recalls', 'DEWALT safety notices and recalls', 'manufacturer', '2026-11-28'),
  ('https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD801', 'SaferProducts exact-title DCD801 recall API query', 'other', '2026-11-28'),
  ('https://www.amazon.com/dp/B0F94FMBYW', 'Amazon exact DCD801B tool-only destination', 'other', '2026-11-28')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://www.dewalt.com/en-us/product/dcd801b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only' AS url,
         'current exact DCD801B tool-only identity, speed settings, chuck, worklight, package contents, optional chip boundary, and product-specific warranty program' AS purpose
  UNION ALL SELECT 'https://www.dewalt.com/en-us/product/dcd801qq2/20v-max-xr-brushless-cordless-12-drilldriver-2-4ah-powerpack-batteries',
         'confirmation that the owner-report DCD801QQ2 kit contains a DCD801 drill/driver while remaining a separate package from DCD801B'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Instruction_Manual/EN/NA283252_man_cordless_drill_drivers_DCD801_DCD806_NA.pdf',
         'Type 1 operation, weekly cleaning, maintenance, and factory-or-authorized-service boundary'
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-XR-DRILL-DRIVER---BARE/p/DCD801B_1',
         'current Type 1 catalog snapshot with 22 purchasable entries, 19 positive numeric stock levels, and three zero-level rows still marked in stock'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Exploded_Diagram/EN/NA370838-SRD1_DCD801_.svg',
         'current Type 1 exploded assembly documentation'
  UNION ALL SELECT 'https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool',
         'manufacturer spare-parts ordering and ServiceNet path retained from prior verified support evidence'
  UNION ALL SELECT 'https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams',
         'manufacturer manuals, parts-list, and diagram support path retained from prior verified support evidence'
  UNION ALL SELECT 'https://support.dewalt.com/hc/en-us/articles/360056765252-Where-can-my-product-be-repaired-under-warranty',
         'manufacturer warranty-repair service-center path retained from prior verified support evidence'
  UNION ALL SELECT 'https://www.dewalt.com/en-us/support/warranty',
         'current three-year limited warranty, one-year free service, 90-day money-back guarantee, purchaser, authorized-seller, proof, normal-wear, and abuse boundaries'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/1vj2fpl/dcd801qq2_hd_in_store_clearance_135/',
         'August 2026 short-duration report after several months using the DCD801 included in a separate DCD801QQ2 kit for woodworking projects'
  UNION ALL SELECT 'https://www.youtube.com/watch?v=Bq5epMgLdQk',
         'November 2025 exact-model repair-channel report whose title describes a new DCD801 and a return to service without ownership duration or DCD801B package identity'
  UNION ALL SELECT 'https://www.dewalt.com/en-us/support/safety-notices-and-recalls',
         'bounded current manufacturer safety-notice review'
  UNION ALL SELECT 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD801',
         'exact-title recall API query returned an empty result on 2026-11-28; not a universal safety clearance'
  UNION ALL SELECT 'https://www.amazon.com/dp/B0F94FMBYW',
         'exact commercial destination whose current page title identifies the DCD801B tool-only drill/driver'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'dewalt-dcd801b';

UPDATE products
SET variant_notes = 'DCD801B is the exact U.S. 20V MAX XR brushless 1/2-inch drill/driver tool-only package. DEWALT includes the DCD801 drill/driver and belt hook; battery, charger, and optional TOOL CONNECT chip are sold separately. The current support evidence is for DCD801B Type 1. Do not transfer these findings to DCD801QQ2 or DCD801H1 kits, the DCD806 hammer drill, DCD800 or DCD805 tools, regional packages, combo kits, batteries, chargers, or another type or revision.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'DEWALT currently identifies the exact DCD801B tool-only drill/driver and publishes Type 1 documentation. The November 28, 2026 ServiceNet snapshot exposed 22 related entries and marked all 22 purchasable and in stock; 19 had positive numeric stock levels. The sensor, selector, forward/reverse actuator, housing, motor-and-switch assembly, and transmission all showed positive numeric stock. One compression spring and two label rows showed zero while remaining marked in stock, so the catalog is internally inconsistent and remains a volatile snapshot rather than proof of continued support. An August 8, 2026 Reddit post says its author bought the DCD801QQ2 kit several months earlier and had thoroughly enjoyed the included DCD801 for woodworking projects. That report concerns a kit rather than the DCD801B tool-only package and gives no repair history. A November 5, 2025 repair-channel video title describes a new DCD801 as repaired and returned to service, but accessible metadata does not identify the DCD801B package, ownership duration, workload, or a representative failure pattern. No qualifying long-term exact-model ownership history was found. The exact-title SaferProducts recall query returned an empty result on November 28, 2026; that narrow check is not safety clearance. Expected service life, representative failure rate, annual maintenance cost, repair economics, street price, and a Buy-It-for-Life recommendation remain unverified.',
    expected_service_life_basis = 'Not yet verified. Current exact-tool evidence consists of one several-month DCD801 report from a separate DCD801QQ2 kit and one repair-channel report describing a new DCD801 without ownership duration; no qualifying long-term exact-model ownership history was found.',
    last_reviewed_date = '2026-11-28'
WHERE slug = 'dewalt-dcd801b';

UPDATE product_fields
SET raw_value = 'DEWALT identifies DCD801B as the U.S. 20V MAX XR brushless cordless 1/2-inch drill/driver tool-only package. The current page lists the ANTI-ROTATION system, no-load speed settings of 0-650 and 0-2,000 RPM, a 1/2-inch metal ratcheting chuck, a three-position 70-lumen worklight, and optional TOOL CONNECT chip-ready functionality. The package includes the DCD801 drill/driver and belt hook; battery, charger, and chip are sold separately.',
    display_value = 'DCD801B 20V MAX XR brushless 1/2-inch drill/driver, tool-only: ANTI-ROTATION, 0-650/0-2,000 RPM, metal ratcheting chuck, 70-lumen worklight, and belt hook; battery, charger, and optional chip sold separately.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcd801b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only'),
    verified_date = '2026-11-28',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact DCD801B Type 1 ServiceNet catalog exposed 22 related entries on November 28, 2026. All 22 were marked purchasable and in stock. Nineteen reported positive numeric stock levels, including the sensor, selector, forward/reverse actuator, cover, housing, motor-and-switch assembly, and transmission assembly. One compression spring and two label rows reported zero while retaining an in-stock status. Catalog controls and stock metadata do not prove successful checkout, complete component coverage, revision fit, or future support.',
    display_value = 'Partial: the Type 1 catalog marked 22 entries purchasable and in stock, with 19 positive numeric stock levels including the housing, motor-and-switch assembly, transmission, sensor, and selector; three rows still showed zero, and this dated snapshot does not guarantee future support.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-XR-DRILL-DRIVER---BARE/p/DCD801B_1'),
    verified_date = '2026-11-28',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'DEWALT publishes the NA283252 Type 1 DCD801 and DCD806 instruction manual covering operation, adjustment, weekly cleaning, maintenance, and safety. It is not a comprehensive internal owner-repair manual and directs repairs, maintenance, and adjustment to a DEWALT factory or authorized service center.',
    display_value = 'No comprehensive internal repair manual verified. The Type 1 owner manual covers operation, adjustment, maintenance, cleaning, and safety, then routes internal repairs to factory or authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Instruction_Manual/EN/NA283252_man_cordless_drill_drivers_DCD801_DCD806_NA.pdf'),
    verified_date = '2026-11-28',
    reverify_days = 365
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The Type 1 manual documents owner care through blowing dirt and dust from air vents with clean, dry compressed air at least weekly and cleaning nonmetallic surfaces with a water-and-mild-soap cloth. It directs repairs, maintenance, and adjustment to a DEWALT factory or authorized service center even though ServiceNet currently lists major assemblies.',
    display_value = 'Shop-serviceable through DEWALT service centers: owners clean vents with clean, dry air at least weekly and use mild soap on nonmetallic surfaces; internal repairs go to factory or authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Instruction_Manual/EN/NA283252_man_cordless_drill_drivers_DCD801_DCD806_NA.pdf'),
    verified_date = '2026-11-28',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'The exact DCD801B product page publishes a 3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee. DEWALT''s current terms extend the limited warranty to the original end-user purchaser for covered defects in materials or workmanship and exclude normal wear and tool abuse; authorized-seller eligibility, proof, and full current terms apply.',
    display_value = 'Three-year limited warranty, one-year free service, and 90-day money-back guarantee for the original end-user purchaser; normal wear, abuse, authorized-seller eligibility, proof, and current DEWALT terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
    verified_date = '2026-11-28',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-28',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b')
  AND name IN ('expected_service_life', 'annual_maintenance_cost');

UPDATE product_fields
SET verified_date = '2026-11-28',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-XR-DRILL-DRIVER---BARE/p/DCD801B_1',
    repair_manual_available = 0,
    repair_manual_url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Instruction_Manual/EN/NA283252_man_cordless_drill_drivers_DCD801_DCD806_NA.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-XR-DRILL-DRIVER---BARE/p/DCD801B_1'),
    verified_date = '2026-11-28'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b');

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
  '3-year limited warranty; 1-year free service; 90-day money-back guarantee',
  'For products stating this package, DEWALT covers the original end-user purchaser for defects due to faulty materials or workmanship for three years and provides one year of free service.',
  'Normal wear and tool abuse are excluded; authorized-seller eligibility, proof, product, regional, and current claim terms must be confirmed with DEWALT.',
  s.id,
  '2026-11-28'
FROM products p
JOIN sources s ON s.url = 'https://www.dewalt.com/en-us/support/warranty'
WHERE p.slug = 'dewalt-dcd801b'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-28'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd801b')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B0F94FMBYW?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '75');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-28');

COMMIT;
