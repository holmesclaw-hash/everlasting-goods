PRAGMA foreign_keys = ON;
BEGIN;

UPDATE affiliate_links
SET verified_date = '2026-10-29'
WHERE program_name = 'Amazon Associates'
  AND exact_model = 1
  AND (
    (product_id = (SELECT id FROM products WHERE slug = 'moccamaster-kbgv-select-53948') AND url = 'https://www.amazon.com/dp/B093DXS54M?tag=everlastin08f-20')
    OR (product_id = (SELECT id FROM products WHERE slug = 'merkur-34c') AND url = 'https://www.amazon.com/dp/B002A8JO1Q?tag=everlastin08f-20')
    OR (product_id = (SELECT id FROM products WHERE slug = 'lodge-l10sk3') AND url = 'https://www.amazon.com/dp/B00006JSUB?tag=everlastin08f-20')
    OR (product_id = (SELECT id FROM products WHERE slug = 'estwing-b3-3lb') AND url = 'https://www.amazon.com/dp/B00002N5NI?tag=everlastin08f-20')
    OR (product_id = (SELECT id FROM products WHERE slug = 'victorinox-fibrox-5-2063-20') AND url = 'https://www.amazon.com/dp/B008M5U1C2?tag=everlastin08f-20')
  );

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '63');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-29');

COMMIT;
