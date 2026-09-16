PRAGMA foreign_keys = ON;
BEGIN;

DELETE FROM product_sources
WHERE product_id = 14
  AND source_id = (
    SELECT id
    FROM sources
    WHERE url = 'https://www.reddit.com/r/Tools/comments/iyaif5/california_air_compressors_any_good'
  );

DELETE FROM sources
WHERE url = 'https://www.reddit.com/r/Tools/comments/iyaif5/california_air_compressors_any_good'
  AND NOT EXISTS (
    SELECT 1
    FROM product_sources
    WHERE product_sources.source_id = sources.id
  );

UPDATE products
SET recommendation_reasoning = 'Manufacturer documentation supports routine user maintenance and troubleshooting plus an authorized service path. No dated exact-model owner evidence establishes longevity; the 8010 service life remains unverified, so no buy or repair recommendation is published.'
WHERE id = 14 AND slug = 'california-air-tools-8010';

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '12');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-16');

COMMIT;
