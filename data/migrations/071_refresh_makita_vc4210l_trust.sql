PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.makitatools.com/products/details/VC4210L', 'Makita VC4210L official U.S. product page', 'manufacturer', '2026-11-24'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/VC4/5fb7ef75-dbeb-446e-a746-1b5dd0569c35_VC4210L_IM.pdf', 'Makita VC4210L operating and maintenance manual 107418274', 'manufacturer', '2026-11-24'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/VC4/1b731b99-245e-4fac-a87c-5aa08ecda139_VC4210L_US_en-US.pdf', 'Makita current VC4210L U.S. parts breakdown', 'manufacturer', '2026-11-24'),
  ('https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx', 'Makita USA parts pricing effective October 15 2026', 'manufacturer', '2026-11-24'),
  ('https://www.makitatools.com/service/warranty', 'Makita USA current warranty policy', 'manufacturer', '2026-11-24'),
  ('https://www.amazon.com/dp/B07ZMN75V2', 'Amazon exact Makita VC4210L destination', 'other', '2026-11-24')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://www.makitatools.com/products/details/VC4210L' AS url,
         'current exact U.S. identity, specifications, automatic filter cleaning, tool-activated outlet, AWS-capable boundary, included items, and separately listed exact-model filters and accessories' AS purpose
  UNION ALL SELECT 'https://cdn.makitatools.com/apps/cms/doc/prod/VC4/5fb7ef75-dbeb-446e-a746-1b5dd0569c35_VC4210L_IM.pdf',
         'official operation, filter and bag replacement, cooling-air and seal cleaning, annual inspection, maintenance, and qualified-service boundaries'
  UNION ALL SELECT 'https://cdn.makitatools.com/apps/cms/doc/prod/VC4/1b731b99-245e-4fac-a87c-5aa08ecda139_VC4210L_US_en-US.pdf',
         'current exact-model illustrated U.S. parts breakdown linked by the manufacturer'
  UNION ALL SELECT 'https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx',
         'dated U.S. component-listing snapshot for 38 exact VC4210 entries and their discontinued-marker status'
  UNION ALL SELECT 'https://www.makitatools.com/service/warranty',
         'current general-product one-year coverage, authorized-service path, and published limitations and exclusions'
  UNION ALL SELECT 'https://www.amazon.com/dp/B07ZMN75V2',
         'exact-model commercial destination whose page title identifies Makita VC4210L 11 Gallon Wet/Dry HEPA Filter Dust Extractor/Vacuum'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'makita-vc4210l';

UPDATE products
SET variant_notes = 'VC4210L is the exact United States corded 110-120 V, 11-gallon wet/dry HEPA dust extractor package. It is AWS-capable only when used with the separate WUT02U wireless adapter, sold separately; other Makita vacuum models and regional electrical configurations are outside this record.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Makita currently identifies VC4210L as the U.S. 11-gallon corded HEPA extractor and links an exact operating manual plus a current illustrated U.S. parts breakdown. Makita USA''s parts-pricing file effective October 15, 2026 contains 38 entries whose descriptions explicitly name VC4210; none is marked discontinued in that file. The entries include the motor, auto-on/off PCBA, rotary switch, potentiometer, solenoid kit, power cord, reed sensor, container, control panel, covers, seals, handles, and wheels. This dated list-price snapshot does not prove live stock, checkout success, compatibility with every production revision, or future supply. The current product page separately lists exact-model HEPA and flat filters, motor filter, bags, hose, cuffs, and other accessories. No qualifying exact-model owner report with a stated multi-year ownership duration and repair history was accepted during this review. Expected service life, representative failure rate, annual maintenance cost, repair economics, and a buy-or-repair recommendation remain unverified.',
    last_reviewed_date = '2026-11-24'
WHERE slug = 'makita-vc4210l';

UPDATE product_fields
SET raw_value = 'Makita identifies VC4210L as the corded 11-gallon wet/dry HEPA dust extractor for the U.S. market. The current page states a 12 A motor, 148 CFM airflow, 92 inches of water lift, 60 dB(A) working sound level, automatic filter cleaning, a tool-activated outlet, and AWS capability through the separate WUT02U adapter. The official manual identifies the CA, U.S., and Mexico configuration as 110-120 V.',
    display_value = 'VC4210L: U.S. 110-120 V corded 11-gallon HEPA extractor with 12 A motor, 148 CFM airflow, 92 in. water lift, 60 dB(A) working sound, and AWS-capable operation through a separately sold adapter.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/VC4210L'),
    verified_date = '2026-11-24',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Makita''s current U.S. product page links an exact VC4210L illustrated parts breakdown and separately lists exact-model HEPA and flat filters, a motor filter, filter and disposal bags, hose, cuffs, and other accessories. The Makita USA parts-pricing file effective October 15, 2026 contains 38 entries whose descriptions explicitly name VC4210; none carries the file''s discontinued marker. Listed components include the motor, auto-on/off PCBA, rotary switch, potentiometer, solenoid kit, power cord, reed sensor, container, control panel, covers, seals, handles, and wheels. The list-price file does not prove live stock, checkout success, compatibility with every production revision, or future supply.',
    display_value = 'Partial: the October 2026 U.S. file lists 38 exact VC4210 components not marked discontinued, including the motor, PCBA, switch, power cord, container, seals, handles, and wheels; current live stock and revision compatibility are not proven.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx'),
    verified_date = '2026-11-24',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Makita publishes the VC4210L operating manual 107418274. It covers setup, operation, automatic filter cleaning, wet and dry pickup, transport, storage, bag and filter replacement, motor cooling-air diffuser cleaning, gasket and floater cleaning, regular inspection, and maintenance. It is an operating and maintenance manual, not a comprehensive internal repair manual.',
    display_value = 'Official operating and maintenance manual covers use, cleaning, consumable replacement, and inspection; it is not an internal repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/VC4/5fb7ef75-dbeb-446e-a746-1b5dd0569c35_VC4210L_IM.pdf'),
    verified_date = '2026-11-24',
    reverify_days = 365
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The manual documents owner replacement of filter and disposal bags and the flat filter, plus cleaning of the motor cooling-air diffuser, gaskets, floater, container, and water-level device. It says damaged electrical or mechanical parts should be repaired by a competent service center or the manufacturer, and calls for suitably qualified personnel to perform regular servicing and inspection. At least once a year, a Makita technician or instructed person must inspect the filters, air tightness, and control mechanisms.',
    display_value = 'Shop-serviceable: owner filter and bag replacement plus cooling-air, gasket, floater, and container cleaning; deeper repair and at least annual technical inspection go to qualified personnel.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/VC4/5fb7ef75-dbeb-446e-a746-1b5dd0569c35_VC4210L_IM.pdf'),
    verified_date = '2026-11-24',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Makita''s current general-product limited warranty covers defects in workmanship and materials for one year from original purchase and directs the complete product to a Makita Factory or Authorized Service Center for inspection and repair or replacement. Published limitations exclude accessories and cases involving attempted third-party repair, normal wear and tear, abuse, misuse, improper maintenance or operation, or alterations.',
    display_value = '1-year general-product limited warranty from original purchase through Makita factory or authorized service; normal wear, misuse, improper maintenance, alterations, and attempted third-party repair are excluded.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
    verified_date = '2026-11-24',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-24',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l')
  AND name IN ('expected_service_life', 'annual_maintenance_cost');

UPDATE product_fields
SET verified_date = '2026-11-24',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://cdn.makitatools.com/apps/cms/doc/prod/VC4/1b731b99-245e-4fac-a87c-5aa08ecda139_VC4210L_US_en-US.pdf',
    repair_manual_available = 0,
    repair_manual_url = 'https://cdn.makitatools.com/apps/cms/doc/prod/VC4/5fb7ef75-dbeb-446e-a746-1b5dd0569c35_VC4210L_IM.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx'),
    verified_date = '2026-11-24'
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l');

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
  '1-year general product limited warranty.',
  'Makita states that its general products are covered against defects in workmanship and materials for one year from original purchase, with inspection and repair or replacement through a Makita Factory or Authorized Service Center.',
  'The published limitations exclude accessories and cases involving attempted third-party repair, normal wear and tear, abuse, misuse, improper maintenance or operation, or alterations.',
  s.id,
  '2026-11-24'
FROM products p
JOIN sources s ON s.url = 'https://www.makitatools.com/service/warranty'
WHERE p.slug = 'makita-vc4210l'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-24'
WHERE product_id = (SELECT id FROM products WHERE slug = 'makita-vc4210l')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B07ZMN75V2?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '71');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-24');

COMMIT;
