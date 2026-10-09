PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only', 'DEWALT DCD800B current product and downloads page', 'manufacturer', '2026-10-09'),
  ('https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QUCA/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf', 'DEWALT DCD800 and DCD805 Type 1 North America instruction manual', 'manufacturer', '2026-10-09'),
  ('https://www.toolservicenet.com/en/p/DCD800B', 'DEWALT ServiceNet DCD800B Type 1 parts catalog', 'manufacturer', '2026-10-09'),
  ('https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif', 'DEWALT DCD800 Type 1 exploded diagram', 'manufacturer', '2026-10-09'),
  ('https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams', 'DEWALT manuals, parts lists, and diagrams support', 'manufacturer', '2026-10-09'),
  ('https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool', 'DEWALT spare-parts support', 'manufacturer', '2026-10-09'),
  ('https://support.dewalt.com/hc/en-us/articles/8159827713293-USA-CAN-DeWalt-Warranty', 'DEWALT USA and Canada warranty terms', 'manufacturer', '2026-10-09'),
  ('https://support.dewalt.com/hc/en-us/articles/360056765252-Where-can-my-product-be-repaired-under-warranty', 'DEWALT warranty repair path', 'manufacturer', '2026-10-09'),
  ('https://www.reddit.com/r/Dewalt/comments/1gtj46k/ntd_i_finally_got_a_dcd800', 'DCD800 owner report after a couple of years of daily cabinet and millwork use', 'owner-report', '2026-10-09'),
  ('https://www.reddit.com/r/Dewalt/comments/1kp2tha/my_brand_new_drill_and_driver', 'DCD800 owner intermittent-operation report after just over two years', 'owner-report', '2026-10-09'),
  ('https://www.reddit.com/r/Dewalt/comments/1cfmgcn/dcd800', 'DCD800 owner use and early chuck-replacement discussion', 'owner-report', '2026-10-09'),
  ('https://www.reddit.com/r/Dewalt/comments/1i0ti8r/will_the_dcd800_drill_be_upgraded_like_the_1007', 'DCD800 owner frozen-chuck report', 'owner-report', '2026-10-09'),
  ('https://www.amazon.com/dp/B09ZQ4VTXK', 'Amazon DCD800B exact-model destination', 'other', '2026-10-09');

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b');

INSERT INTO product_sources
SELECT p.id, s.id, 'exact tool-only identity, included belt hook, specifications, and current downloads'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.dewalt.com/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only';
INSERT INTO product_sources
SELECT p.id, s.id, 'operation, maintenance, cleaning, battery care, and repair boundary'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QUCA/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf';
INSERT INTO product_sources
SELECT p.id, s.id, 'current exact Type 1 component catalog and orderability snapshot'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.toolservicenet.com/en/p/DCD800B';
INSERT INTO product_sources
SELECT p.id, s.id, 'exact Type 1 exploded diagram'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif';
INSERT INTO product_sources
SELECT p.id, s.id, 'model and type specific document lookup'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://support.dewalt.com/hc/en-us/articles/360012666378-Where-can-I-find-manuals-part-lists-and-diagrams';
INSERT INTO product_sources
SELECT p.id, s.id, 'manufacturer replacement-parts ordering routes'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool';
INSERT INTO product_sources
SELECT p.id, s.id, 'current warranty coverage and exclusions'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://support.dewalt.com/hc/en-us/articles/8159827713293-USA-CAN-DeWalt-Warranty';
INSERT INTO product_sources
SELECT p.id, s.id, 'factory and authorized warranty-repair route'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://support.dewalt.com/hc/en-us/articles/360056765252-Where-can-my-product-be-repaired-under-warranty';
INSERT INTO product_sources
SELECT p.id, s.id, 'anecdotal exact-model report after a couple of years of daily cabinet and millwork use'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.reddit.com/r/Dewalt/comments/1gtj46k/ntd_i_finally_got_a_dcd800';
INSERT INTO product_sources
SELECT p.id, s.id, 'anecdotal exact-model intermittent-operation report after just over two years'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.reddit.com/r/Dewalt/comments/1kp2tha/my_brand_new_drill_and_driver';
INSERT INTO product_sources
SELECT p.id, s.id, 'anecdotal exact-model use and early chuck-replacement reports'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.reddit.com/r/Dewalt/comments/1cfmgcn/dcd800';
INSERT INTO product_sources
SELECT p.id, s.id, 'anecdotal exact-model frozen-chuck report'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.reddit.com/r/Dewalt/comments/1i0ti8r/will_the_dcd800_drill_be_upgraded_like_the_1007';
INSERT INTO product_sources
SELECT p.id, s.id, 'exact-model commercial destination; automated retrieval reached Amazon validation'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://www.amazon.com/dp/B09ZQ4VTXK';

UPDATE products
SET variant_notes = 'DCD800B is the U.S. tool-only package containing one DCD800 drill/driver and one belt hook; battery and charger are sold separately. DCD800 is the drill/driver, while DCD805 is the separate hammer-drill model covered by the shared instruction manual.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports the exact tool-only package, owner maintenance, an exact Type 1 exploded diagram, currently orderable ServiceNet assemblies, factory or authorized repair, and current warranty terms. One exact-model owner reports a couple of years of daily cabinet and millwork use without problems; another reports intermittent operation beginning just over two years after purchase, and separate reports describe early or frozen chuck problems. These reports are anecdotal and do not establish representative expected service life or failure rate, so repair economics and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-10-09'
WHERE slug = 'dewalt-dcd800b';

UPDATE product_fields
SET raw_value = 'DCD800B is the U.S. tool-only DCD800 20V MAX XR brushless cordless 1/2-inch drill/driver package. It has two speed settings of 0-650 and 0-2,000 RPM, a 6.37-inch tool-head length, a 1/2-inch metal ratcheting chuck, and includes one belt hook. Battery and charger are sold separately.',
    display_value = 'DCD800B tool-only 20V MAX XR brushless 1/2-inch drill/driver; 0-650 / 0-2,000 RPM and 6.37-inch tool-head length; battery and charger sold separately.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only'),
    verified_date = '2026-10-09',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The current DCD800B Type 1 ServiceNet catalog publishes an exploded diagram and marked 24 listed entries purchasable and in stock on 2026-10-09, including the housing, motor-and-switch assembly, transmission assembly, chuck, selector, and LED light. Stock is volatile, and the catalog does not prove that every possible internal component is separately orderable.',
    display_value = 'Partial: the Type 1 ServiceNet catalog currently lists major assemblies including motor and switch, transmission, and chuck as orderable; stock is volatile and complete component coverage is not verified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en/p/DCD800B'),
    verified_date = '2026-10-09',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'DEWALT publishes a Type 1 DCD800 and DCD805 instruction manual covering operation, weekly dry-air vent cleaning, mild-soap exterior cleaning, chuck and accessory procedures, and battery care. It directs repairs, maintenance, and adjustment to factory or authorized service and is not an owner-repair manual.',
    display_value = 'Official Type 1 operating and maintenance manual is available; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QUCA/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf'),
    verified_date = '2026-10-09',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The manual documents user maintenance through weekly dry-air vent cleaning, mild-soap exterior cleaning, and ordinary chuck, accessory, and battery procedures. Repairs, maintenance, and adjustment are routed to a DEWALT factory or authorized service center even though ServiceNet sells several assemblies.',
    display_value = 'User maintenance covers air-vent cleaning and ordinary accessory care; repairs go to DEWALT factory or authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QUCA/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf'),
    verified_date = '2026-10-09',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'DEWALT currently lists a 3-year limited warranty, 1-year free service, and 90-day money-back guarantee. Current terms cover faulty materials or workmanship for the original end-user purchaser, include first-year maintenance and normal-use worn-part replacement, and apply stated exclusions and proof requirements.',
    display_value = '3-year limited warranty, 1-year free service, and 90-day money-back guarantee; current DEWALT terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://support.dewalt.com/hc/en-us/articles/8159827713293-USA-CAN-DeWalt-Warranty'),
    verified_date = '2026-10-09',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-10-09'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
)
SELECT
  p.id,
  '3-year limited warranty; 1-year free service; 90-day money-back guarantee.',
  'Faulty materials or workmanship for the original end-user purchaser; first-year free service includes maintenance and replacement of worn parts caused by normal use.',
  'Normal wear, tool abuse, accessories, unauthorized repair damage, and unauthorized-seller limitations apply; proof of purchase may be required.',
  s.id,
  '2026-10-09'
FROM products p, sources s
WHERE p.slug = 'dewalt-dcd800b'
  AND s.url = 'https://support.dewalt.com/hc/en-us/articles/8159827713293-USA-CAN-DeWalt-Warranty'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.toolservicenet.com/en/p/DCD800B',
    repair_manual_available = 0,
    repair_manual_url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QUCA/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/i/DEWALT/GLOBALBOM/QUCA/DCD800B/1/Instruction_Manual/EN/NA229093_DCD800_DCD805_T1_NA.pdf'),
    verified_date = '2026-10-09'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b');

UPDATE affiliate_links
SET verified_date = '2026-10-09'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcd800b')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B09ZQ4VTXK?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '42');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-09');

COMMIT;
