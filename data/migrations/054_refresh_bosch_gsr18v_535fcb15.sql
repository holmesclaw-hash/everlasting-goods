PRAGMA foreign_keys = ON;
BEGIN;

UPDATE sources
SET retrieved_date = '2026-10-21'
WHERE url IN (
  'https://www.boschtools.com/us/en/products/gsr18v-535fcb15-06019G7114',
  'https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf',
  'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110',
  'https://www.boschtools.com/us/en/service/product-warranty'
);

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.finehomebuilding.com/2026/07/20/multi-head-drills', 'Fine Homebuilding long-term Bosch GSR18V-535FC use report', 'owner-report', '2026-10-21'),
  ('https://festoolownersgroup.com/threads/bosch-18v-cabinet-makers-drill.69974/', 'Bosch GSR18V-535FC owner thread covering attachment retention and continued use', 'owner-report', '2026-10-21'),
  ('https://www.amazon.com/dp/B07Z5QNBVS', 'Amazon exact Bosch GSR18V-535FCB15 destination', 'other', '2026-10-21');

DELETE FROM product_sources WHERE product_id = 4;

INSERT INTO product_sources
SELECT 4, id, 'exact kit identity, order number, included items, and manufacturer specifications' FROM sources
WHERE url = 'https://www.boschtools.com/us/en/products/gsr18v-535fcb15-06019G7114';
INSERT INTO product_sources
SELECT 4, id, 'operating, maintenance, and qualified-service boundaries' FROM sources
WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf';
INSERT INTO product_sources
SELECT 4, id, 'current exact-tool-number component catalog and order route' FROM sources
WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110';
INSERT INTO product_sources
SELECT 4, id, 'current 18V tool and battery warranty terms, exclusions, and service route' FROM sources
WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty';
INSERT INTO product_sources
SELECT 4, id, 'qualified exact-tool three-year use report covering thousands of holes and screws' FROM sources
WHERE url = 'https://www.finehomebuilding.com/2026/07/20/multi-head-drills';
INSERT INTO product_sources
SELECT 4, id, 'qualified exact-tool owner reports covering one-year attachment wear and contrasting multi-year use' FROM sources
WHERE url = 'https://festoolownersgroup.com/threads/bosch-18v-cabinet-makers-drill.69974/';
INSERT INTO product_sources
SELECT 4, id, 'exact-model commercial destination' FROM sources
WHERE url = 'https://www.amazon.com/dp/B07Z5QNBVS';

UPDATE products
SET sku = '06019G7114',
    variant_notes = 'GSR18V-535FCB15 is Bosch order number 06019G7114: a kit built around the GSR18V-535FC 18V FlexiClick drill/driver. Bosch lists one CORE18V 4 Ah battery, one 18V charger, a metal keyless chuck attachment, right-angle attachment, offset-angle attachment, belt clip, and carrying bag. The optional GFA18-H rotary-hammer attachment and GCY42 connectivity module are not included.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation verifies the exact kit, operating and maintenance guidance, a current component catalog for exact tool number 3601JG7110, authorized service, and limited warranty terms. A Fine Homebuilding reviewer reports using the GSR18V-535FC for a little over three years to drill thousands of holes and drive many screws. In a separate owner thread, one user reported attachment looseness and wear after about a year, while another later participant reported years of use without that complaint. These are anecdotal reports with different usage and no representative failure-rate data, so expected service life, annual maintenance cost, repair economics, and a buy-or-repair recommendation remain not yet verified.',
    last_reviewed_date = '2026-10-21'
WHERE id = 4 AND slug = 'bosch-gsr18v-535fcb15';

UPDATE product_fields
SET raw_value = 'Bosch GSR18V-535FCB15 is order number 06019G7114, an 18V brushless FlexiClick kit rated at up to 535 in.-lb. The package lists the GSR18V-535FC drill/driver, one CORE18V 4 Ah battery, one charger, metal keyless chuck, right-angle attachment, offset-angle attachment, belt clip, and carrying bag.',
    display_value = 'GSR18V-535FCB15 kit (order 06019G7114): 535 in.-lb. GSR18V-535FC drill/driver, one CORE18V 4 Ah battery, charger, and three included chuck/angle attachments.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/gsr18v-535fcb15-06019G7114'),
    verified_date = '2026-10-21',
    reverify_days = 180
WHERE product_id = 4 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Bosch currently publishes an exact tool-number 3601JG7110 catalog with component listings for the housing, gearbox, electronics module, printed-board assemblies, stator, DC motor, bit holder, switchover unit, keyless chuck attachment, right-angle attachment, and eccentric attachment. Catalog presence supports component-level parts access but does not prove perpetual stock or compatibility across every production revision.',
    display_value = 'Partial: the current 3601JG7110 catalog lists gearbox, electronics, motor, housing, and FlexiClick attachments; continued stock and every production revision are not guaranteed.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110'),
    verified_date = '2026-10-21',
    reverify_days = 90
WHERE product_id = 4 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Bosch publishes a GSR18V-535FC and GSR18V-535FCB15 operating and safety manual. It covers operation, battery handling, inspection, cleaning, and service safety, but it does not provide component-level owner disassembly or repair procedures.',
    display_value = 'Official operating and safety manual is available; it covers maintenance boundaries but is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf'),
    verified_date = '2026-10-21',
    reverify_days = 180
WHERE product_id = 4 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The manual limits owner care to safe battery removal, inspection, ventilation-slot and exterior cleaning, and accessory handling. It directs power-tool service to qualified repair personnel using identical replacement parts. Bosch warranty terms exclude damage caused by repairs outside Bosch or a Bosch Authorized Service Center.',
    display_value = 'Owner care covers inspection and cleaning; internal work is directed to qualified repair personnel through Bosch or an authorized service center.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'),
    verified_date = '2026-10-21',
    reverify_days = 180
WHERE product_id = 4 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Bosch warrants qualifying 18V cordless power tools to the original end-user purchaser for five years from purchase and 18V batteries for three years. Coverage is limited to defects in material or workmanship; published exclusions include non-genuine parts, repairs outside Bosch or an authorized service center, abuse, misuse, careless handling, and normal wear.',
    display_value = '5-year limited warranty for the 18V power tool and 3-year limited warranty for the battery, for the original end-user purchaser; current exclusions apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'),
    verified_date = '2026-10-21',
    reverify_days = 180
WHERE product_id = 4 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-10-21'
WHERE product_id = 4 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  4,
  '5 years for the 18V power tool; 3 years for the included 18V battery.',
  'For the original end-user purchaser, Bosch may repair or replace parts defective in material or workmanship under the current limited-warranty terms.',
  'Damage from non-genuine Bosch parts, repairs outside Bosch or an authorized service center, abuse, misuse, careless handling, and normal wear is excluded.',
  (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty'),
  '2026-10-21'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110',
    repair_manual_available = 0,
    repair_manual_url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110'),
    verified_date = '2026-10-21'
WHERE product_id = 4;

UPDATE affiliate_links
SET verified_date = '2026-10-21'
WHERE product_id = 4
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B07Z5QNBVS?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '54');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-21');

COMMIT;
