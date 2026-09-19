PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.boschtools.com/ca/en/products/4100xc-10-0601B13016', 'Bosch 4100XC-10 parts lookup and manufacturer-hosted owner reviews', 'other', '2026-09-19');

UPDATE sources
SET retrieved_date = '2026-09-19'
WHERE url IN (
  'https://www.boschtools.com/us/en/products/4100xc-10-0601B13016',
  'https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf',
  'https://www.boschtools.com/us/en/service/product-warranty/'
);

UPDATE products
SET variant_notes = 'The 4100XC-10 package uses saw part number 3601L13015 and includes the GTA47W Gravity-Rise wheeled stand. Parts and service evidence must match the ten-digit part number on the tool.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports exact-model parts lookup, routine owner maintenance, and authorized repair. One manufacturer-hosted exact-model owner reports that after 2 to 3 years the saw still runs and cuts, but the stand collapsed after five or six uses; Bosch replied that it changed the tubing and offered a replacement part. A single owner report is not representative durability evidence, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-09-19'
WHERE id = 7 AND slug = 'bosch-4100xc-10';

INSERT OR IGNORE INTO product_sources
SELECT 7, id, 'exact-model parts lookup, part-number match, and manufacturer-hosted owner evidence' FROM sources
WHERE url = 'https://www.boschtools.com/ca/en/products/4100xc-10-0601B13016';

UPDATE product_fields
SET raw_value = 'Bosch 4100XC-10 is a corded 10-inch worksite table saw with a 15-amp motor, 3,650 rpm no-load speed, 30-inch right rip capacity, and included GTA47W Gravity-Rise wheeled stand.',
    display_value = 'Corded 10-inch worksite table saw with 30-inch right rip capacity and GTA47W wheeled stand.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/4100xc-10-0601B13016'),
    verified_date = '2026-09-19',
    reverify_days = 180
WHERE product_id = 7 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Bosch maps 4100XC-10 part number 3601L13015 to an official spare-parts catalog. The catalog endpoint was temporarily unavailable during review, so individual component availability was not verified.',
    display_value = 'Partial: 3601L13015 maps to an official spare-parts catalog; individual availability remains unverified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/ca/en/products/4100xc-10-0601B13016'),
    verified_date = '2026-09-19',
    reverify_days = 90
WHERE product_id = 7 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Bosch publishes an exact-model operating and safety manual with setup, alignment, blade replacement, maintenance, lubrication, and troubleshooting instructions. It routes electrical and mechanical repairs to trained repair personnel and is not an owner-repair manual.',
    display_value = 'Official operating and maintenance manual is available; it is not an owner-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf'),
    verified_date = '2026-09-19',
    reverify_days = 180
WHERE product_id = 7 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The exact-model manual documents owner procedures for blade replacement, blade and fence alignment, dust removal, and occasional lubrication of the sliding rails and table locking cams. Electrical and mechanical repairs are routed to trained repair personnel.',
    display_value = 'User-serviceable for blade replacement, alignment, dust removal, and rail/cam lubrication; repairs are routed to trained service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf'),
    verified_date = '2026-09-19',
    reverify_days = 180
WHERE product_id = 7 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Bosch provides a one-year limited warranty to the original purchaser of corded portable and benchtop power tools for defects in material or workmanship. Current exclusions and claim requirements apply.',
    display_value = '1-year limited warranty for the original purchaser; current Bosch terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty/'),
    verified_date = '2026-09-19',
    reverify_days = 180
WHERE product_id = 7 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-09-19'
WHERE product_id = 7 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  7,
  '1-year limited warranty.',
  'Defects in material or workmanship for the original purchaser of Bosch corded portable and benchtop power tools.',
  'Misuse, careless handling, unauthorized misrepair, and accessory items are excluded; current Bosch terms and claim requirements apply.',
  (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty/'),
  '2026-09-19'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/4100xc-10-3601L13015',
    repair_manual_available = 0,
    repair_manual_url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf',
    serviceability = 'user-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf'),
    verified_date = '2026-09-19'
WHERE product_id = 7;

UPDATE affiliate_links
SET verified_date = '2026-09-19'
WHERE product_id = 7
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B0851KL858?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '15');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-19');

COMMIT;
