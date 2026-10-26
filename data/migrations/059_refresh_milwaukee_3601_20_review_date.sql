PRAGMA foreign_keys = ON;

BEGIN IMMEDIATE;

UPDATE products
SET last_reviewed_date = '2026-10-26'
WHERE id = 50 AND slug = 'milwaukee-3601-20';

UPDATE sources
SET retrieved_date = '2026-10-26'
WHERE id BETWEEN 414 AND 420;

UPDATE product_fields
SET verified_date = '2026-10-26'
WHERE product_id = 50;

UPDATE repairability
SET verified_date = '2026-10-26'
WHERE product_id = 50;

UPDATE warranties
SET verified_date = '2026-10-26'
WHERE product_id = 50;

UPDATE affiliate_links
SET verified_date = '2026-10-26'
WHERE product_id = 50;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '59');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-26');

COMMIT;
