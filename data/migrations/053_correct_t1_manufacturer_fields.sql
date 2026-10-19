PRAGMA foreign_keys = ON;
BEGIN;

-- T1 is reserved for evidence supplied by Daniel or the shop. Manufacturer
-- product pages, manuals, parts catalogs, and warranty documents are T2.
UPDATE product_fields
SET evidence_tier = 'T2'
WHERE evidence_tier = 'T1'
  AND source_id IN (
    SELECT id
    FROM sources
    WHERE source_type = 'manufacturer'
  );

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '53');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-19');

COMMIT;
