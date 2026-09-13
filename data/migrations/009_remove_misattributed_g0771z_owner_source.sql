BEGIN;

DELETE FROM product_sources
WHERE product_id = 19
  AND source_id = (
    SELECT id
    FROM sources
    WHERE url = 'https://www.reddit.com/r/woodworking/comments/10ub8xc/dewalt_jobsite_or_grizzly_hybrid_table_saw/'
  );

UPDATE products
SET recommendation_reasoning = 'Manufacturer documentation verifies cast-iron tables and trunnions, a model-specific manual/update, revision-specific parts documentation, an exact-model parts catalog, and a one-year limited warranty. One exact-model repair report provides limited owner context but does not establish expected service life, recurring failure rates, or a recommendation.'
WHERE id = 19;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '9');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-12');

COMMIT;
