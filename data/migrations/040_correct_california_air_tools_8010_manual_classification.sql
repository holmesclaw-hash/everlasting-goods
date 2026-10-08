PRAGMA foreign_keys = ON;
BEGIN;

UPDATE repairability
SET repair_manual_available = 0,
    verified_date = '2026-10-08'
WHERE product_id = 14
  AND EXISTS (
    SELECT 1
    FROM products
    WHERE id = 14
      AND slug = 'california-air-tools-8010'
  );

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '40');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-08');

COMMIT;
