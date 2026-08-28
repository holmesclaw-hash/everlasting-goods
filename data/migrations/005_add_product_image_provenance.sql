BEGIN;

ALTER TABLE products ADD COLUMN image_license_url TEXT;
ALTER TABLE products ADD COLUMN image_attribution TEXT;
ALTER TABLE products ADD COLUMN image_alt TEXT;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('product_image_revision', '5');

COMMIT;
