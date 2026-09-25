PRAGMA foreign_keys = ON;
BEGIN;

UPDATE sources
SET retrieved_date = '2026-09-25'
WHERE url IN (
  'https://www.milwaukeetool.com/products/details/m18-fuel-1-2-hammer-drill-driver-cordless-power-tool/2904-20',
  'https://documents.milwaukeetool.com/58-14-9998d1.pdf',
  'https://documents.milwaukeetool.com/54-24-2990R.pdf',
  'https://www.milwaukeetool.com/support/registration-and-warranty'
);

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.reddit.com/r/MilwaukeeTool/comments/1sa31uk/warranty_disappointment_saga/', '2904-20 owner report: unresolved chuck wobble after service', 'owner-report', '2026-09-25'),
  ('https://www.reddit.com/r/MilwaukeeTool/comments/1su3pj4/milwaukee_5_year_warranty_is_not_a_joke/', '2904-20 owner report: replacement after failure under warranty', 'owner-report', '2026-09-25'),
  ('https://www.reddit.com/r/MilwaukeeTool/comments/16g1f1f/', '2904 owner report: replacement chuck resolved binding', 'owner-report', '2026-09-25'),
  ('https://www.amazon.com/dp/B0BB854SJ8', 'Amazon exact Milwaukee 2904-20 destination', 'other', '2026-09-25');

DELETE FROM product_sources WHERE product_id = 2;

INSERT INTO product_sources
SELECT 2, id, 'exact catalog identity, package contents, and current product documentation' FROM sources
WHERE url = 'https://www.milwaukeetool.com/products/details/m18-fuel-1-2-hammer-drill-driver-cordless-power-tool/2904-20';
INSERT INTO product_sources
SELECT 2, id, 'operating, owner-maintenance, inspection, warranty, and authorized-service boundaries' FROM sources
WHERE url = 'https://documents.milwaukeetool.com/58-14-9998d1.pdf';
INSERT INTO product_sources
SELECT 2, id, 'May 2025 exact-model service parts and assembly procedures' FROM sources
WHERE url = 'https://documents.milwaukeetool.com/54-24-2990R.pdf';
INSERT INTO product_sources
SELECT 2, id, 'current Milwaukee power-tool warranty terms' FROM sources
WHERE url = 'https://www.milwaukeetool.com/support/registration-and-warranty';
INSERT INTO product_sources
SELECT 2, id, 'qualified exact-model unresolved chuck-wobble owner report' FROM sources
WHERE url = 'https://www.reddit.com/r/MilwaukeeTool/comments/1sa31uk/warranty_disappointment_saga/';
INSERT INTO product_sources
SELECT 2, id, 'qualified exact-model 2.5-year failure and replacement owner report' FROM sources
WHERE url = 'https://www.reddit.com/r/MilwaukeeTool/comments/1su3pj4/milwaukee_5_year_warranty_is_not_a_joke/';
INSERT INTO product_sources
SELECT 2, id, 'qualified exact-model replacement-chuck owner report' FROM sources
WHERE url = 'https://www.reddit.com/r/MilwaukeeTool/comments/16g1f1f/';
INSERT INTO product_sources
SELECT 2, id, 'exact-model commercial destination' FROM sources
WHERE url = 'https://www.amazon.com/dp/B0BB854SJ8';

UPDATE products
SET variant_notes = 'Catalog 2904-20 is the M18 FUEL 1/2-inch Hammer Drill/Driver cordless power-tool package. Milwaukee lists one 2904-20 tool, one side handle, and one belt clip in the box; no battery or charger is listed for this catalog number.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports the exact 2904-20 package, owner cleaning and inspection, a May 2025 component-level service-parts list, authorized repair, and a five-year limited power-tool warranty whose normal-wear exclusions specifically include chucks. One exact-model owner reports a failure after about 2.5 years followed by no-cost warranty replacement; another reports chuck wobble after a few months and an unresolved outcome after multiple service attempts; a third says a replacement chuck resolved binding. These reports are anecdotal and conflicting, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-09-25'
WHERE id = 2 AND slug = 'milwaukee-2904-20';

UPDATE product_fields
SET raw_value = 'Catalog 2904-20 is Milwaukee’s M18 FUEL 1/2-inch Hammer Drill/Driver cordless power tool. The manufacturer lists the tool, side handle, and belt clip in the package; no battery or charger is listed.',
    display_value = '2904-20 M18 FUEL 1/2-inch Hammer Drill/Driver; package lists the tool, side handle, and belt clip without a battery or charger.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.milwaukeetool.com/products/details/m18-fuel-1-2-hammer-drill-driver-cordless-power-tool/2904-20'),
    verified_date = '2026-09-25',
    reverify_days = 180
WHERE product_id = 2 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Milwaukee’s May 2025 exact-model service-parts list identifies the keyless chuck, gearbox, rotor, electronic, housing, side-handle, and other service assemblies, and provides chuck removal and installation procedures. The document does not prove that every listed component is currently orderable.',
    display_value = 'Partial: a May 2025 exact-model list identifies chuck, gearbox, rotor, and electronic service parts; current individual orderability is not verified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://documents.milwaukeetool.com/54-24-2990R.pdf'),
    verified_date = '2026-09-25',
    reverify_days = 90
WHERE product_id = 2 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Milwaukee publishes a combined 2903-20 and 2904-20 operator manual covering operation, inspection, cleaning, battery-contact cleaning, and service intervals. It states that the tool should not be disassembled and directs all repairs to a Milwaukee service facility; the separate service-parts list is not presented as an owner-repair manual.',
    display_value = 'Official operator manual is available; it is not an owner-repair manual, and the separate service-parts list does not override the authorized-service direction.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://documents.milwaukeetool.com/58-14-9998d1.pdf'),
    verified_date = '2026-09-25',
    reverify_days = 180
WHERE product_id = 2 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The operator manual documents exterior cleaning, inspection for noise, misalignment, binding, or broken parts, and cleaning battery contacts. It recommends inspection after six months to one year depending on use, prohibits disassembly, and routes internal repairs to a Milwaukee service facility.',
    display_value = 'Owner care covers cleaning, inspection, and battery contacts; internal repairs are directed to a Milwaukee service facility.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://documents.milwaukeetool.com/58-14-9998d1.pdf'),
    verified_date = '2026-09-25',
    reverify_days = 180
WHERE product_id = 2 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Milwaukee’s current portable electric power-tool policy provides a five-year limited warranty for the original purchaser, subject to examination, claim requirements, exceptions, and exclusions. The policy identifies chucks among normal-wear parts not covered when normal use exhausts the part.',
    display_value = '5-year limited power-tool warranty; normal-wear exclusions specifically include chucks, and current Milwaukee terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.milwaukeetool.com/support/registration-and-warranty'),
    verified_date = '2026-09-25',
    reverify_days = 180
WHERE product_id = 2 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-09-25'
WHERE product_id = 2 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  2,
  '5-year limited power-tool warranty.',
  'For the original purchaser, Milwaukee may repair or replace parts it determines defective in material or workmanship, subject to current terms and exceptions.',
  'Unauthorized repair attempts, misuse, alterations, abuse, normal wear, lack of maintenance, and accidents are excluded; the policy specifically lists chucks among normal-wear parts.',
  (SELECT id FROM sources WHERE url = 'https://www.milwaukeetool.com/support/registration-and-warranty'),
  '2026-09-25'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://documents.milwaukeetool.com/54-24-2990R.pdf',
    repair_manual_available = 0,
    repair_manual_url = 'https://documents.milwaukeetool.com/58-14-9998d1.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://documents.milwaukeetool.com/58-14-9998d1.pdf'),
    verified_date = '2026-09-25'
WHERE product_id = 2;

UPDATE affiliate_links
SET verified_date = '2026-09-25'
WHERE product_id = 2
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B0BB854SJ8?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '23');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-25');

COMMIT;
