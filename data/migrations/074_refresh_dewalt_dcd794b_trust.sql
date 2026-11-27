PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dcd794b/atomic-20v-max-brushless-cordless-12-drilldriver-tool-only', 'DEWALT DCD794B official product page', 'manufacturer', '2026-11-27'),
  ('https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-COMPACT-DRILL-DRIVER-BARE/p/DCD794B_1', 'DEWALT ServiceNet DCD794B Type 1 parts catalog', 'manufacturer', '2026-11-27'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Instruction_Manual/EN/NA597019_DCD794_DCD799_NA_NBC.pdf', 'DEWALT DCD794 and DCD799 Type 1 North America instruction manual', 'manufacturer', '2026-11-27'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Exploded_Diagram/EN/DCD794_B_C1_D1_T1.svg', 'DEWALT DCD794B Type 1 exploded diagram', 'manufacturer', '2026-11-27'),
  ('https://www.dewalt.com/en-us/support/warranty', 'DEWALT current warranty terms', 'manufacturer', '2026-11-27'),
  ('https://www.reddit.com/r/Dewalt/comments/1uzcdvm/in_love_with_the_dcd794_3_month_review/', 'Reddit: DCD794 short-duration continuous-use and one-year home-use reports', 'owner-report', '2026-11-27'),
  ('https://www.reddit.com/r/Dewalt/comments/16dtzsj/drill_making_clicking_sound_when_stopping/', 'Reddit: early DCD794 clicking and gearbox warranty report', 'owner-report', '2026-11-27'),
  ('https://www.reddit.com/r/Dewalt/comments/1w1qjlt/anyone_have_experience_turning_in_a_faulty_drill/', 'Reddit: September 2026 DCD794 wobble and warranty-turn-in report', 'owner-report', '2026-11-27'),
  ('https://www.youtube.com/watch?v=Cxw9j8wbx6I', 'WorkshopAddict: launch-period DCD794 gearbox failure during testing', 'owner-report', '2026-11-27'),
  ('https://www.youtube.com/watch?v=gtK2VAAOluY', 'WorkshopAddict: replacement DCD794 and DCD799 hands-on review', 'owner-report', '2026-11-27'),
  ('https://www.dewalt.com/en-us/support/safety-notices-and-recalls', 'DEWALT safety notices and recalls', 'manufacturer', '2026-11-27'),
  ('https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD794', 'SaferProducts exact-title DCD794 recall API query', 'other', '2026-11-27'),
  ('https://www.amazon.com/dp/B0BY1QMH24', 'Amazon exact DCD794B tool-only destination', 'other', '2026-11-27')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://www.dewalt.com/en-us/product/dcd794b/atomic-20v-max-brushless-cordless-12-drilldriver-tool-only' AS url,
         'current exact DCD794B tool-only identity, dimensions, weight, speed, clutch settings, package contents, and product-specific warranty program' AS purpose
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-COMPACT-DRILL-DRIVER-BARE/p/DCD794B_1',
         'current Type 1 catalog snapshot with 19 related entries, 17 purchasable entries, and 15 purchasable tool-specific components'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Instruction_Manual/EN/NA597019_DCD794_DCD799_NA_NBC.pdf',
         'Type 1 operation, weekly cleaning, maintenance, troubleshooting, and factory-or-authorized-service boundary'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Exploded_Diagram/EN/DCD794_B_C1_D1_T1.svg',
         'current Type 1 exploded assembly documentation'
  UNION ALL SELECT 'https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool',
         'manufacturer spare-parts ordering and ServiceNet path retained from prior verified support evidence'
  UNION ALL SELECT 'https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams',
         'manufacturer manuals, parts-list, and diagram support path retained from prior verified support evidence'
  UNION ALL SELECT 'https://support.dewalt.com/hc/en-us/articles/360056765252-Where-can-my-product-be-repaired-under-warranty',
         'manufacturer warranty-repair service-center path retained from prior verified support evidence'
  UNION ALL SELECT 'https://www.dewalt.com/en-us/support/warranty',
         'current three-year limited warranty, one-year free service, 90-day money-back guarantee, purchaser, defect, normal-wear, and abuse boundaries'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/1uzcdvm/in_love_with_the_dcd794_3_month_review/',
         'July 2026 exact-model anecdotes after two to three months of continuous use and about one year of home maintenance and repair use'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/16dtzsj/drill_making_clicking_sound_when_stopping/',
         'September 2023 exact-model anecdote reporting clicking after a few days and a commenter reporting gearbox warranty replacement in about two weeks'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/1w1qjlt/anyone_have_experience_turning_in_a_faulty_drill/',
         'September 2026 exact-model anecdote reporting wobble and a planned warranty turn-in without ownership duration'
  UNION ALL SELECT 'https://www.youtube.com/watch?v=Cxw9j8wbx6I',
         'launch-period hands-on test report describing an internal gearbox issue in the first DCD794 test unit'
  UNION ALL SELECT 'https://www.youtube.com/watch?v=gtK2VAAOluY',
         'launch-period hands-on follow-up describing strong replacement-unit testing while acknowledging the first-unit failure'
  UNION ALL SELECT 'https://www.dewalt.com/en-us/support/safety-notices-and-recalls',
         'bounded current manufacturer safety-notice review'
  UNION ALL SELECT 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD794',
         'exact-title recall API query returned an empty result on 2026-11-27; not a universal safety clearance'
  UNION ALL SELECT 'https://www.amazon.com/dp/B0BY1QMH24',
         'exact commercial destination whose current page title identifies the DCD794B tool-only drill/driver'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'dewalt-dcd794b';

UPDATE products
SET variant_notes = 'DCD794B is the exact U.S. ATOMIC 20V MAX brushless 1/2-inch drill/driver tool-only package. DEWALT includes the DCD794 drill/driver and belt hook; battery and charger are sold separately. The current support evidence is for DCD794B Type 1. Do not transfer these findings to DCD794D1 or DCD794D2 kits, the DCD799 hammer drill, DCD800 or DCD805 tools, regional packages, combo kits, batteries, chargers, or another type or revision.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'DEWALT currently identifies the exact DCD794B tool-only drill/driver and publishes Type 1 documentation. The November 27, 2026 ServiceNet snapshot exposed 19 related entries, with 17 marked purchasable; after excluding battery and charger package entries, 15 purchasable tool-specific components included the chuck, clamshell, transmission, motor, selector, controls, hook, fasteners, and labels, all with positive numeric stock levels. This is a volatile snapshot and not proof of continued support. Launch-period WorkshopAddict testing reported an internal gearbox issue in a first DCD794 unit and strong follow-up testing of a replacement. A September 2023 Reddit owner reported clicking after a few days, while a commenter reported gearbox teeth ground flat and warranty replacement in about two weeks. July 2026 reports describe two to three months of continuous use and about one year of home maintenance and repair use. A September 2026 owner reported wobble and a planned warranty turn-in without stating ownership duration. These mixed anecdotes contain no qualifying long-term exact-model ownership history and are not representative evidence for service life or failure rate. The exact-title SaferProducts recall query returned an empty result on November 27, 2026; that narrow check is not safety clearance. Expected service life, representative failure rate, annual maintenance cost, repair economics, street price, and a Buy-It-for-Life recommendation remain unverified.',
    expected_service_life_basis = 'Not yet verified. Current exact-model evidence consists of launch testing, early failure and warranty reports, one report after two to three months of continuous use, and one report after about one year of home maintenance and repairs; no qualifying long-term exact-model ownership history was found.',
    last_reviewed_date = '2026-11-27'
WHERE slug = 'dewalt-dcd794b';

UPDATE product_fields
SET raw_value = 'DEWALT identifies DCD794B as the U.S. ATOMIC 20V MAX brushless cordless 1/2-inch drill/driver tool-only package. The current product page lists a 1,650 RPM maximum no-load speed, 15 clutch settings, a 6.7-inch assembled length, 2.75-pound assembled weight, keyless chuck, and the DCD794 drill/driver plus belt hook. Battery and charger are sold separately.',
    display_value = 'DCD794B ATOMIC 20V MAX brushless 1/2-inch drill/driver, tool-only: 1,650 RPM, 15 clutch settings, 6.7 in., 2.75 lb., and belt hook; battery and charger sold separately.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcd794b/atomic-20v-max-brushless-cordless-12-drilldriver-tool-only'),
    verified_date = '2026-11-27',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact DCD794B Type 1 ServiceNet catalog exposed 19 related entries on November 27, 2026. Seventeen were marked purchasable. Excluding the battery and charger entries associated with kit packages, 15 purchasable tool-specific components included the chuck, clamshell, transmission, motor, selector, forward/reverse actuator, belt hook, cap, spring, pin, screws, rating plate, and warning label. All 15 tool-specific purchasable rows reported an in-stock status and a positive numeric stock level. The two non-purchasable rows were a not-included placeholder and a DCB201 battery entry. Catalog controls and stock metadata do not prove successful checkout, complete component coverage, revision fit, or future support.',
    display_value = 'Partial: the Type 1 catalog exposed 19 related entries, with 17 marked purchasable and 15 purchasable tool-specific components including chuck, clamshell, transmission, motor, and selector; all 15 showed positive numeric stock, but this dated snapshot is not a guarantee of future support.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-COMPACT-DRILL-DRIVER-BARE/p/DCD794B_1'),
    verified_date = '2026-11-27',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'DEWALT publishes the NA597019 Type 1 DCD794 and DCD799 instruction manual covering operation, accessory and chuck procedures, troubleshooting, weekly dry-air vent cleaning, mild-soap exterior cleaning, and repair routing. It is not a comprehensive internal owner-repair manual, and it directs repairs, maintenance, and adjustment to a DEWALT factory or authorized service center.',
    display_value = 'No comprehensive internal repair manual verified. The Type 1 owner manual covers operation, maintenance, cleaning, and troubleshooting, then routes repairs to DEWALT factory or authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Instruction_Manual/EN/NA597019_DCD794_DCD799_NA_NBC.pdf'),
    verified_date = '2026-11-27',
    reverify_days = 365
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The Type 1 manual documents owner care through blowing dirt and dust from air vents with clean, dry compressed air at least weekly and cleaning nonmetallic surfaces with a water-and-mild-soap cloth. It directs repairs, maintenance, and adjustment to a DEWALT factory or authorized service center even though ServiceNet currently lists major assemblies.',
    display_value = 'Shop-serviceable through DEWALT''s service network: owners clean vents weekly with dry compressed air and use mild soap on nonmetallic surfaces; internal repairs go to factory or authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Instruction_Manual/EN/NA597019_DCD794_DCD799_NA_NBC.pdf'),
    verified_date = '2026-11-27',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'The exact DCD794B product page publishes a 3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee. DEWALT''s current terms extend the three-year limited warranty to the original end-user purchaser for covered defects in materials or workmanship and exclude normal wear and tool abuse; proof, eligibility, and full current terms still apply.',
    display_value = '3-year limited warranty, 1-year free service, and 90-day money-back guarantee for the original end-user purchaser; normal wear, abuse, proof, eligibility, and current DEWALT terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
    verified_date = '2026-11-27',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-27',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b')
  AND name IN ('expected_service_life', 'annual_maintenance_cost');

UPDATE product_fields
SET verified_date = '2026-11-27',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-COMPACT-DRILL-DRIVER-BARE/p/DCD794B_1',
    repair_manual_available = 0,
    repair_manual_url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Instruction_Manual/EN/NA597019_DCD794_DCD799_NA_NBC.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-COMPACT-DRILL-DRIVER-BARE/p/DCD794B_1'),
    verified_date = '2026-11-27'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b');

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
  'Normal wear and tool abuse are excluded; proof, eligibility, product, regional, and current claim terms must be confirmed with DEWALT.',
  s.id,
  '2026-11-27'
FROM products p
JOIN sources s ON s.url = 'https://www.dewalt.com/en-us/support/warranty'
WHERE p.slug = 'dewalt-dcd794b'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-27'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd794b')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B0BY1QMH24?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '74');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-27');

COMMIT;
