PRAGMA foreign_keys = ON;
BEGIN;

UPDATE sources
SET retrieved_date = '2026-11-18'
WHERE url IN (
  'https://www.boschtools.com/us/en/products/1617evspk-0601617577',
  'https://www.boschtools.com/us/en/service/replacement-parts/',
  'https://www.amazon.com/dp/B00005RHPD'
);

INSERT OR REPLACE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/1617evspk-06016176A1', 'Bosch 1617EVSPK current outbound spare-parts catalog route', 'manufacturer', '2026-11-18');

INSERT OR REPLACE INTO product_sources (product_id, source_id, purpose)
SELECT 9, id, 'current manufacturer-linked exact-model catalog route; returned HTTP 404 on 2026-11-18'
FROM sources
WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/1617evspk-06016176A1';

UPDATE products
SET recommendation_reasoning = 'Manufacturer documentation supports the exact fixed-base and plunge-base package, owner cleaning and bit or collet procedures, authorized service, a one-year limited warranty, and an exact-model spare-parts ordering entry. The current manufacturer-linked outbound parts catalog remains unavailable: it returned HTTP 404 on 2026-11-18, so individual component orderability remains unverified. In one exact-combo discussion, individual owners report about 15 to more than 20 years of use; another exact-model owner reported stiff plunge action on first use. These anecdotes do not establish representative service life or repair economics, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-11-18'
WHERE id = 9 AND slug = 'bosch-1617evspk';

UPDATE product_fields
SET raw_value = 'Bosch''s exact 1617EVSPK page identifies current part number 06016176A1 and presents a spare-parts ordering entry. Bosch''s replacement-parts page states that genuine replacement parts can be ordered online or by phone. The current manufacturer-linked exact-model catalog route for 06016176A1 returned HTTP 404 on 2026-11-18, so individual component orderability remains unverified.',
    display_value = 'Partial: Bosch''s exact product page exposes spare-parts ordering, but the outbound catalog is currently unavailable; individual component availability remains unverified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/1617evspk-0601617577'),
    verified_date = '2026-11-18',
    reverify_days = 30
WHERE product_id = 9 AND name = 'parts_availability';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.boschtools.com/us/en/products/1617evspk-0601617577',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/1617evspk-0601617577'),
    verified_date = '2026-11-18'
WHERE product_id = 9;

UPDATE affiliate_links
SET verified_date = '2026-11-18'
WHERE product_id = 9
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B00005RHPD?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '65');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-18');

COMMIT;
