PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://makitatools.com/products/details/XFD14Z', 'Makita USA XFD14Z official product page', 'manufacturer', '2026-11-21'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf', 'Makita XFD14 cordless driver-drill instruction manual', 'manufacturer', '2026-11-21'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf', 'Makita XFD14T and XFD14Z illustrated parts breakdown dated February 2021', 'manufacturer', '2026-11-21'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA warranty policy', 'manufacturer', '2026-11-21'),
  ('https://www.makitatools.com/service/service-centers', 'Makita USA factory and authorized service-center page', 'manufacturer', '2026-11-21'),
  ('https://cdn.makitatools.com/apps/PriceManagement/upload/Nov%202026%20Parts%20Price%20List_2026_11_16_0956AM.xlsx', 'Makita USA November 2026 parts price list effective November 16, 2026', 'manufacturer', '2026-11-21'),
  ('https://www.reddit.com/r/Tools/comments/1adxfhh/makita_drills_xfd16_ddf489_vs_xfd14_ddf486_vs', 'Reddit Tools thread with an exact XFD14 one-year workplace failure report', 'owner-report', '2026-11-21'),
  ('https://www.reddit.com/r/Makita/comments/12wids0/xgt_df001g_bit_the_dust', 'Reddit Makita thread with an XFD14 and DDF486 workplace use report without duration', 'owner-report', '2026-11-21'),
  ('https://www.reddit.com/r/Makita/comments/1reavmq/should_i_buy_a_used_makita_dhp486_in_2026', 'Reddit Makita thread with a regional DDF486 four-year electronics-repair report', 'owner-report', '2026-11-21'),
  ('https://www.amazon.com/dp/B093QS3VJR', 'Amazon exact Makita XFD14Z tool-only destination', 'other', '2026-11-21')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://makitatools.com/products/details/XFD14Z' AS url,
         'current exact U.S. tool-only identity, specifications, included-package boundary, and product-specific warranty statement' AS purpose
  UNION ALL SELECT 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf',
         'operation, inspection, maintenance, and authorized-service boundaries'
  UNION ALL SELECT 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf',
         'illustrated XFD14T and XFD14Z component breakdown dated February 2021'
  UNION ALL SELECT 'https://www.makitatools.com/service/warranty',
         'current Makita lithium-ion tool warranty term and exclusions'
  UNION ALL SELECT 'https://www.makitatools.com/service/service-centers',
         'current factory and authorized service routes plus the current parts-list download'
  UNION ALL SELECT 'https://cdn.makitatools.com/apps/PriceManagement/upload/Nov%202026%20Parts%20Price%20List_2026_11_16_0956AM.xlsx',
         'November 2026 manufacturer parts-list entries and alternate-part chains for breakdown components'
  UNION ALL SELECT 'https://www.reddit.com/r/Tools/comments/1adxfhh/makita_drills_xfd16_ddf489_vs_xfd14_ddf486_vs',
         'anecdotal exact XFD14 workplace report describing gear slipping from new and failure after about one year'
  UNION ALL SELECT 'https://www.reddit.com/r/Makita/comments/12wids0/xgt_df001g_bit_the_dust',
         'anecdotal workplace XFD14 and DDF486 report describing heavy abuse without problems but no ownership duration'
  UNION ALL SELECT 'https://www.reddit.com/r/Makita/comments/1reavmq/should_i_buy_a_used_makita_dhp486_in_2026',
         'anecdotal regional DDF486 report describing electronics replacement after four years'
  UNION ALL SELECT 'https://www.amazon.com/dp/B093QS3VJR',
         'exact-model commercial destination; automated retrieval reached Amazon continuation validation'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'makita-xfd14z';

UPDATE products
SET variant_notes = 'XFD14Z is the exact U.S. 18V LXT brushless 1/2-inch driver-drill tool-only package; battery and charger are not included. XFD14T is the separate kit shown in the shared parts breakdown with batteries, charger, and bag. XPH14 is a separate hammer driver-drill and is not this record.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Makita currently identifies XFD14Z as the U.S. tool-only 18V LXT brushless 1/2-inch driver-drill and publishes an instruction manual plus an illustrated XFD14T/Z breakdown. The November 2026 parts price list contains 22 of 23 selected component numbers from that breakdown. Six original entries are marked discontinued: four map through alternate-part chains, while the pole complete and left arm show no alternate; the breakdown chuck number is absent. List presence does not prove live stock, successful ordering, compatibility with every revision, or future supply. One exact XFD14 workplace owner report describes gear slipping from new and failure after about one year. A separate workplace commenter says an XFD14/DDF486 had been abused a lot with no problem but gives no duration. A regional DDF486 owner reports electronics replacement after four years; DDF486 is treated only as regional sibling evidence, not proof for the U.S. XFD14Z package. These conflicting anecdotes do not establish representative service life or failure rate, so maintenance cost, repair economics, and a Buy-It-for-Life recommendation remain unverified.',
    last_reviewed_date = '2026-11-21'
WHERE slug = 'makita-xfd14z';

UPDATE product_fields
SET raw_value = 'Makita identifies XFD14Z as the U.S. tool-only 18V LXT brushless cordless 1/2-inch driver-drill. It publishes 1,250 in.lbs. maximum torque, a two-speed 0-550 and 0-2,100 RPM transmission, a 7-inch tool length, an all-metal self-ratcheting chuck, and a tool-only package with battery and charger not included.',
    display_value = 'Exact U.S. Makita XFD14Z tool-only 18V LXT brushless 1/2-inch driver-drill; 1,250 in.lbs., 0-550 / 0-2,100 RPM, and 7-inch tool length; battery and charger not included.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://makitatools.com/products/details/XFD14Z'),
    verified_date = '2026-11-21',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The November 2026 Makita price list contains 22 of 23 selected component numbers from the February 2021 XFD14T/Z breakdown. Six original entries are marked discontinued. The speed-change lever, gear assembly, grip assembly, and stator map through alternate-part chains to later entries; the pole complete and left arm show no alternate. Breakdown chuck part 763252-1 does not appear. Price-list presence is not proof of live stock, checkout success, revision compatibility, or future supply.',
    display_value = 'Partial: the November 2026 list contains 22 of 23 selected breakdown numbers; 6 originals are discontinued, 4 map through alternate chains, 2 show no alternate, and the breakdown chuck number is absent. Stock and continued supply are unverified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Nov%202026%20Parts%20Price%20List_2026_11_16_0956AM.xlsx'),
    verified_date = '2026-11-21',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Makita publishes an XFD14 instruction manual covering operation, inspection, battery and accessory care, and maintenance. The separate illustrated breakdown identifies components. Neither document is a comprehensive internal diagnostic or repair manual.',
    display_value = 'Official instruction manual and illustrated breakdown are available; the instruction manual is not an internal repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf'),
    verified_date = '2026-11-21',
    reverify_days = 365
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The instruction manual directs repairs, other maintenance, and adjustment to Makita Authorized or Factory Service Centers using Makita replacement parts. Owner guidance covers inspection, ordinary accessory procedures, and safe cleaning; internal repair procedures are not supplied.',
    display_value = 'Shop-serviceable through Makita Authorized or Factory Service Centers using Makita replacement parts; owner guidance does not cover internal repair.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf'),
    verified_date = '2026-11-21',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Makita publishes a three-year limited warranty for lithium-ion tools against defects in workmanship and materials, subject to its current terms and exclusions, including normal wear, misuse, improper maintenance, alterations, and attempted third-party repair.',
    display_value = '3-year limited warranty for Makita lithium-ion tools; current terms and exclusions apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
    verified_date = '2026-11-21',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-21',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z')
  AND name IN ('expected_service_life', 'annual_maintenance_cost');

UPDATE product_fields
SET verified_date = '2026-11-21',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Nov%202026%20Parts%20Price%20List_2026_11_16_0956AM.xlsx',
    repair_manual_available = 0,
    repair_manual_url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Nov%202026%20Parts%20Price%20List_2026_11_16_0956AM.xlsx'),
    verified_date = '2026-11-21'
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z');

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
  '3-year limited warranty for Makita lithium-ion tools',
  'Makita states that covered lithium-ion tools are warranted against defects in workmanship and materials for three years from original purchase and may be repaired or replaced after inspection.',
  'Published exclusions include normal wear, abuse, misuse, improper maintenance or operation, alterations, non-genuine batteries, and attempted third-party repair; current terms govern.',
  s.id,
  '2026-11-21'
FROM products p
JOIN sources s ON s.url = 'https://www.makitatools.com/service/warranty'
WHERE p.slug = 'makita-xfd14z'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-21'
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-xfd14z')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B093QS3VJR?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '68');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-21');

COMMIT;
