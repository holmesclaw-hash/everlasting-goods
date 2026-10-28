PRAGMA foreign_keys = ON;
BEGIN;

UPDATE sources
SET retrieved_date = '2026-10-28'
WHERE url IN (
  'https://www.estwing.com/product/drilling-hammer/',
  'https://www.estwing.com/resources/warranty/',
  'https://www.garagejournal.com/forum/threads/estwing-sledgehammer.522660/',
  'https://www.practicalmachinist.com/forum/threads/ot-estwing-hammers-worth-the-extra.145239/',
  'https://commons.wikimedia.org/wiki/File:Estwing_3-lb._drilling_hammer.jpg'
);

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.estwing.com/wp-content/uploads/2026/03/Estwing-Catalog.pdf', 'Estwing 2026 catalog and B3-3LB specification table', 'manufacturer', '2026-10-28'),
  ('https://www.garagejournal.com/forum/threads/good-estwing-customer-service-experience.219369/', 'Garage Journal: exact-model B3-3LB defect and replacement report', 'owner-report', '2026-10-28'),
  ('https://www.amazon.com/dp/B00002N5NI', 'Amazon exact Estwing B3-3LB destination', 'other', '2026-10-28'),
  ('https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=B3-3LB', 'SaferProducts recall API exact-title query for B3-3LB', 'other', '2026-10-28');

INSERT OR IGNORE INTO product_sources
SELECT 17, id, 'current catalog identity, variant boundary, dimensions, head weight, and UPC' FROM sources
WHERE url = 'https://www.estwing.com/wp-content/uploads/2026/03/Estwing-Catalog.pdf';
INSERT OR IGNORE INTO product_sources
SELECT 17, id, 'historical exact-model defect and manufacturer replacement report with current-handling limits' FROM sources
WHERE url = 'https://www.garagejournal.com/forum/threads/good-estwing-customer-service-experience.219369/';
INSERT OR IGNORE INTO product_sources
SELECT 17, id, 'exact-model commercial identity' FROM sources
WHERE url = 'https://www.amazon.com/dp/B00002N5NI';
INSERT OR IGNORE INTO product_sources
SELECT 17, id, 'exact-title recall query returned no matching federal records on review date' FROM sources
WHERE url = 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=B3-3LB';

UPDATE products
SET variant_notes = 'B3-3LB is the US-made 3-lb, 11-inch drilling hammer with blue Shock Reduction Grip, smooth faces, and UPC 034139620211. Keep it separate from B3-2LB, B3-4LB, and the long-handle B3-4LBL.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'The current product page and 2026 catalog verify the exact B3-3LB identity, one-piece forged construction, 3-lb head, 11-inch length, and variant boundaries. Estwing explicitly says its warranty is not a lifetime warranty and that used striking tools cannot be repaired, re-gripped, or refurbished. Exact-model owner evidence covers fit tradeoffs and one 2013 bent-head replacement report, while broader family reports describe long ownership and vibration complaints. These anecdotes do not establish representative failure rates, expected service life, current claim handling, annual maintenance cost, repair economics, or a buy-or-repair recommendation. The October 28, 2026 exact-title federal recall query returned no records, but the narrow query is not a universal no-recall guarantee.',
    last_reviewed_date = '2026-10-28'
WHERE id = 17 AND slug = 'estwing-b3-3lb';

UPDATE product_fields
SET raw_value = 'Estwing B3-3LB is the US-made 3-lb drilling hammer in the B3 family. The current product page and 2026 catalog identify an 11-inch overall length, 48-ounce head, blue Shock Reduction Grip, smooth faces, one-piece forged steel construction, and UPC 034139620211.',
    display_value = 'B3-3LB US-made 3-lb drilling hammer; 11-inch length; 48-ounce head; one-piece forged steel; UPC 034139620211.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.estwing.com/wp-content/uploads/2026/03/Estwing-Catalog.pdf'),
    verified_date = '2026-10-28',
    reverify_days = 180
WHERE product_id = 17 AND name = 'identity';

UPDATE product_fields
SET verified_date = '2026-10-28'
WHERE product_id = 17 AND name IN (
  'warranty',
  'repair_manual',
  'parts_availability',
  'serviceability',
  'expected_service_life',
  'street_price',
  'annual_maintenance_cost'
);

UPDATE warranties
SET verified_date = '2026-10-28'
WHERE product_id = 17;

UPDATE repairability
SET verified_date = '2026-10-28'
WHERE product_id = 17;

UPDATE affiliate_links
SET verified_date = '2026-10-28'
WHERE product_id = 17
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B00002N5NI?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '62');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-28');

COMMIT;
