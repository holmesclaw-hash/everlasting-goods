PRAGMA foreign_keys = ON;
BEGIN;

UPDATE sources
SET retrieved_date = '2026-10-22'
WHERE url IN (
  'https://www.makitatools.com/products/details/RT0701C',
  'https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf',
  'https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf',
  'https://www.makitatools.com/service/service-centers',
  'https://www.makitatools.com/service/warranty'
);

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx', 'Makita USA October 2026 complete parts MSRP list', 'manufacturer', '2026-10-22'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA factory, authorized, and direct-repair service routes', 'manufacturer', '2026-10-22'),
  ('https://www.amazon.com/dp/B00E7D3V4S', 'Amazon exact Makita RT0701C destination and owner reports', 'owner-report', '2026-10-22'),
  ('https://www.youtube.com/watch?v=29PIqz--MAM', 'Professional woodworker six-year Makita RT0700C sibling-model review', 'owner-report', '2026-10-22'),
  ('https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=RT0701C', 'CPSC recall API exact-title query for RT0701C', 'other', '2026-10-22');

DELETE FROM product_sources WHERE product_id = 8;

INSERT INTO product_sources
SELECT 8, id, 'exact U.S. fixed-base model identity, specifications, included items, and current accessories' FROM sources
WHERE url = 'https://www.makitatools.com/products/details/RT0701C';
INSERT INTO product_sources
SELECT 8, id, 'operating, maintenance, carbon-brush replacement, service, and warranty boundaries' FROM sources
WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf';
INSERT INTO product_sources
SELECT 8, id, 'illustrated component breakdown and exact component numbers' FROM sources
WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf';
INSERT INTO product_sources
SELECT 8, id, 'current manufacturer parts-list status for structural, electrical, and wear components' FROM sources
WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx';
INSERT INTO product_sources
SELECT 8, id, 'factory, authorized, and direct-repair service routes' FROM sources
WHERE url = 'https://www.makitatools.com/service/service-centers';
INSERT INTO product_sources
SELECT 8, id, 'current corded-tool warranty term and exclusions' FROM sources
WHERE url = 'https://www.makitatools.com/service/warranty';
INSERT INTO product_sources
SELECT 8, id, 'exact-model commercial identity and bounded owner-use reports' FROM sources
WHERE url = 'https://www.amazon.com/dp/B00E7D3V4S';
INSERT INTO product_sources
SELECT 8, id, 'six-year professional-use report for jointly documented RT0700C sibling model' FROM sources
WHERE url = 'https://www.youtube.com/watch?v=29PIqz--MAM';
INSERT INTO product_sources
SELECT 8, id, 'exact-title recall query returned no matching CPSC records on review date' FROM sources
WHERE url = 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=RT0701C';

UPDATE products
SET variant_notes = 'RT0701C is the U.S. corded fixed-base package. Makita lists one trimmer base, one 1/4-inch collet, one straight guide, and two spanner wrenches. It is not the RT0701CX3 multi-base kit and does not include a plunge, tilt, or offset base.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation verifies the exact fixed-base package, owner-replaceable carbon brushes, a component breakdown, current manufacturer-list entries for several electrical and structural components, and factory or authorized service. On the exact-ASIN page, one verified-purchase owner reports repeated 5-9 hour CNC jobs and no need yet for purchased replacement brushes, but gives no precise ownership duration; the same page exposes mixed durability excerpts rather than representative failure data. A professional woodworker separately reports six years and an estimated 1,500 hard hours on the jointly documented RT0700C sibling model. Sibling-model and anecdotal exact-model reports do not establish representative RT0701C expected service life, annual maintenance cost, repair economics, or a buy-or-repair recommendation, so those remain not yet verified.',
    last_reviewed_date = '2026-10-22'
WHERE id = 8 AND slug = 'makita-rt0701c';

UPDATE product_fields
SET raw_value = 'Makita RT0701C is a corded fixed-base compact router with a 6.5A motor, 10,000-30,000 RPM variable speed, electronic speed control, soft start, a heavy-duty aluminum motor housing, and a 1/4-inch collet. The U.S. package includes the trimmer base, straight guide, and two spanner wrenches.',
    display_value = 'RT0701C corded fixed-base compact router: 6.5A, 10,000-30,000 RPM, 1/4-inch collet, trimmer base, straight guide, and two wrenches.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/RT0701C'),
    verified_date = '2026-10-22',
    reverify_days = 180
WHERE product_id = 8 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Makita publishes an RT0701C component breakdown. Its October 2026 complete parts list carries the RT0701C armature assembly, controller, field, outer housing, and bearings, along with the switch, cord, carbon-brush set, collet nut, and related base components. Some older breakdown numbers are marked discontinued or substituted, and a list entry does not guarantee current on-hand stock or indefinite future supply.',
    display_value = 'Partial: the October 2026 manufacturer list carries the armature, controller, field, switch, cord, carbon-brush set, collet nut, housing, and base components; some older numbers are discontinued or substituted, and current stock is not guaranteed.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx'),
    verified_date = '2026-10-22',
    reverify_days = 90
WHERE product_id = 8 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'The joint RT0700C/RT0701C instruction manual covers operation, bit and base setup, overload limits, inspection, maintenance, and owner carbon-brush replacement. It does not provide component-level diagnosis, electrical testing, disassembly, or internal repair procedures.',
    display_value = 'Official instruction manual includes inspection and carbon-brush replacement, but it is not a component-level repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf'),
    verified_date = '2026-10-22',
    reverify_days = 180
WHERE product_id = 8 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The manual permits the owner to inspect the tool and replace both carbon brushes through the brush-holder caps. It directs repairs, other maintenance, and adjustment to Makita Authorized or Factory Service Centers using Makita replacement parts. Makita also publishes factory, authorized, and direct-repair routes.',
    display_value = 'Owner maintenance includes inspection and paired carbon-brush replacement; internal repair and adjustment are directed to Makita authorized or factory service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/service-centers'),
    verified_date = '2026-10-22',
    reverify_days = 180
WHERE product_id = 8 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'As a corded tool, RT0701C falls under Makita USA''s general product limited warranty: one year from original purchase against defects in workmanship and materials, plus a 30-day return or replacement guarantee. Published exclusions include repairs attempted by others, normal wear, abuse, misuse, improper maintenance, and alterations.',
    display_value = '1-year general product limited warranty for workmanship and materials, plus a 30-day return/replacement guarantee; normal wear, unauthorized repair, abuse, misuse, improper maintenance, and alterations are excluded.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
    verified_date = '2026-10-22',
    reverify_days = 180
WHERE product_id = 8 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-10-22'
WHERE product_id = 8 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  8,
  '1-year general product limited warranty; 30-day return/replacement guarantee.',
  'For the original purchase period, Makita may repair or replace a complete product when inspection finds defective workmanship or materials.',
  'Repairs attempted by others, normal wear, abuse, misuse, improper maintenance, and alterations are excluded; accessories and wear items have separate limits.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-10-22'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx',
    repair_manual_available = 0,
    repair_manual_url = 'https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx'),
    verified_date = '2026-10-22'
WHERE product_id = 8;

UPDATE affiliate_links
SET verified_date = '2026-10-22'
WHERE product_id = 8
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B00E7D3V4S?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '55');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-22');

COMMIT;
