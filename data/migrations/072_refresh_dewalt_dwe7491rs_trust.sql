PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dwe7491rs/10-jobsite-table-saw-and-rolling-stand', 'DEWALT DWE7491RS official product page', 'manufacturer', '2026-11-25'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_1', 'DEWALT ServiceNet DWE7491RS Type 1 parts catalog', 'manufacturer', '2026-11-25'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_2', 'DEWALT ServiceNet DWE7491RS Type 2 parts catalog', 'manufacturer', '2026-11-25'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_3', 'DEWALT ServiceNet DWE7491RS Type 3 parts catalog', 'manufacturer', '2026-11-25'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_10', 'DEWALT ServiceNet DWE7491RS Type 10 parts catalog', 'manufacturer', '2026-11-25'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11', 'DEWALT ServiceNet DWE7491RS Type 11 parts catalog', 'manufacturer', '2026-11-25'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_20', 'DEWALT ServiceNet DWE7491RS Type 20 parts catalog', 'manufacturer', '2026-11-25'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/20/Instruction_Manual/EN/NA810782_DWE7491_NA.318547.pdf', 'DEWALT DWE7491RS Type 20 instruction and maintenance manual NA810782', 'manufacturer', '2026-11-25'),
  ('https://www.dewalt.com/en-us/support/warranty', 'DEWALT current warranty policy', 'manufacturer', '2026-11-25'),
  ('https://www.amazon.com/dp/B00F2CGXGG', 'Amazon exact DEWALT DWE7491RS destination', 'other', '2026-11-25')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://www.dewalt.com/en-us/product/dwe7491rs/10-jobsite-table-saw-and-rolling-stand' AS url,
         'current exact package identity, 15-amp motor and 32-1/2-inch rip capacity, included rolling stand, product-page download boundary, and product-specific warranty label' AS purpose
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_1',
         'Type 1 discontinued-status and dated component-catalog snapshot'
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_2',
         'Type 2 discontinued-status and dated component-catalog snapshot'
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_3',
         'Type 3 discontinued-status and dated component-catalog snapshot'
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_10',
         'Type 10 live-status and dated component-catalog snapshot'
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_11',
         'Type 11 live-status and dated component-catalog snapshot'
  UNION ALL SELECT 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_20',
         'current Type 20 live-status, 208-entry component catalog, purchasability, stock-status inconsistency, and guaranteed-repair-cost snapshot'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/20/Instruction_Manual/EN/NA810782_DWE7491_NA.318547.pdf',
         'current Type 20 specifications, operation, alignment, cleaning, lubrication, maintenance, and qualified-repair boundaries'
  UNION ALL SELECT 'https://www.dewalt.com/en-us/support/warranty',
         'current three-year limited warranty, first-year service, seller eligibility, exclusions, and proof requirements'
  UNION ALL SELECT 'https://www.reddit.com/r/Dewalt/comments/1ilj1dt/do_not_purchase_the_dwe7491_table_saw/',
         'previously accepted anecdotal exact-model report describing close to seven years without general problems and gradual fence drift'
  UNION ALL SELECT 'https://www.amazon.com/dp/B00F2CGXGG',
         'exact-model commercial destination for the DEWALT DWE7491RS rolling-stand package'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'dewalt-dwe7491rs';

UPDATE products
SET variant_notes = 'DWE7491RS is the exact U.S. corded 10-inch jobsite table saw package with the rolling stand. ServiceNet requires owners to match the saw type before ordering: Type 20 is the newest current live catalog, Types 10 and 11 also remain live, and Types 1, 2, and 3 are marked discontinued. The official product page still exposes Type 2 downloads, so its download panel must not be treated as proof of the owner''s production revision.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'DEWALT currently identifies DWE7491RS as the 15-amp, 10-inch jobsite table saw package with a rolling stand and publishes revision-specific ServiceNet support. The newest Type 20 catalog was marked live on October 23, 2026 and exposed 208 entries on 2026-11-25, with 206 marked purchasable. Major assemblies and wear parts included the armature, field, brush assembly, switch, cordset, bearings, gears, fence assembly, fence beam, and rails. All 208 entries carried an in-stock status, but 12 reported stock level zero, so the snapshot is internally inconsistent and does not guarantee checkout success, compatibility across revisions, or future supply. One previously accepted exact-model owner report describes close to seven years without general problems while also reporting gradual fence drift. Current Reddit retrieval was blocked, and one anecdote is not representative durability evidence. Expected service life, representative failure rate, annual maintenance cost, repair economics, and a buy-or-repair recommendation remain unverified.',
    last_reviewed_date = '2026-11-25'
WHERE slug = 'dewalt-dwe7491rs';

UPDATE product_fields
SET raw_value = 'DEWALT identifies DWE7491RS as the corded 10-inch jobsite table saw package with a rolling stand. The product page states a 15-amp motor and 32-1/2-inch rip capacity. The current Type 20 manual states a 10-inch blade, 4,800 RPM no-load speed, 3-1/8-inch maximum cut depth at 0 degrees, 2-1/4-inch depth at 45 degrees, and saw weight greater than 55.2 pounds.',
    display_value = 'DWE7491RS corded rolling-stand package: 15 A, 10-inch blade, 4,800 RPM, 32-1/2 in. rip capacity, and maximum cut depths of 3-1/8 in. at 0 degrees and 2-1/4 in. at 45 degrees.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/20/Instruction_Manual/EN/NA810782_DWE7491_NA.318547.pdf'),
    verified_date = '2026-11-25',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'ServiceNet marks Types 10, 11, and 20 live and Types 1, 2, and 3 discontinued. The newest Type 20 catalog was dated October 23, 2026 and exposed 208 component entries on 2026-11-25, with 206 marked purchasable. Listed major components included the armature, field, brush holder assembly, switch, cordset, bearings, gears, fence assembly, fence beam, and rails. Every entry carried an in-stock status, but 12 reported stock level zero. This internally inconsistent snapshot does not prove checkout success, compatibility with every revision, or future supply; owners must match the type number before ordering.',
    display_value = 'Partial: the live Type 20 catalog exposed 208 entries and marked 206 purchasable, including armature, field, brush, switch, cord, bearing, gear, fence, and rail parts; 12 entries paired zero stock with an in-stock status, so revision matching and checkout remain unverified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_20'),
    verified_date = '2026-11-25',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'DEWALT publishes the NA810782 Type 20 DWE7491 instruction manual. It covers setup, operation, guard and riving-knife use, fence and blade alignment, dust-system cleaning, lubrication, storage, transport, maintenance, and repair routing. It is an operating and maintenance manual, not a comprehensive owner-repair manual.',
    display_value = 'Official Type 20 operating and maintenance manual covers setup, alignment, cleaning, lubrication, and repair routing; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/20/Instruction_Manual/EN/NA810782_DWE7491_NA.318547.pdf'),
    verified_date = '2026-11-25',
    reverify_days = 365
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The Type 20 manual documents owner setup and adjustment for the rip fence, rip scale, rail lock, blade-to-slot alignment, bevel stops, riving knife, throat plate, and miter gauge. Owner maintenance includes dust-system clearing, weekly dry-air vent cleaning, exterior cleaning, and periodic cleaning and general-purpose greasing of the blade-height adjustment screw. DEWALT directs repairs, brush inspection and replacement, and deeper maintenance to a factory or authorized service center using identical replacement parts.',
    display_value = 'Shop-serviceable: owners can align the fence and rail lock, clear dust, clean vents, and lubricate the height-adjustment screw; brush work and deeper repairs go to qualified service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/20/Instruction_Manual/EN/NA810782_DWE7491_NA.318547.pdf'),
    verified_date = '2026-11-25',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'The DWE7491RS product page states the three-year limited warranty, one-year free service, and 90-day satisfaction program. The current policy says products carrying this package cover defects in materials or workmanship for the original end-user purchaser, provide first-year maintenance and normal-use worn-part replacement, and require current authorized-seller, proof, normal-wear, abuse, accessory, and unauthorized-repair terms to be satisfied.',
    display_value = '3-year limited warranty, 1-year free service, and 90-day money-back guarantee for the original end-user; current authorized-seller, proof, normal-wear, abuse, accessory, and repair exclusions apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
    verified_date = '2026-11-25',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-25',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs')
  AND name IN ('expected_service_life', 'annual_maintenance_cost');

UPDATE product_fields
SET verified_date = '2026-11-25',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_20',
    repair_manual_available = 0,
    repair_manual_url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/20/Instruction_Manual/EN/NA810782_DWE7491_NA.318547.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/UNIVERSAL-SAWS/10IN-JOBSITE-TABLE-SAW-WITH-32-1-2IN/p/DWE7491RS_20'),
    verified_date = '2026-11-25'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs');

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
  '2026-11-25'
FROM products p
JOIN sources s ON s.url = 'https://www.dewalt.com/en-us/support/warranty'
WHERE p.slug = 'dewalt-dwe7491rs'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-25'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dwe7491rs')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B00F2CGXGG?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '72');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-25');

COMMIT;
