PRAGMA foreign_keys = OFF;
BEGIN;

-- The original serviceability enum had no accurate value for a manufacturer-
-- documented tool with no repair or refurbishment path.
CREATE TABLE repairability_v6 (
  product_id INTEGER PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE,
  parts_availability TEXT NOT NULL CHECK (parts_availability IN ('full','partial','none','not-yet-verified')),
  parts_url TEXT,
  repair_manual_available INTEGER NOT NULL CHECK (repair_manual_available IN (0,1)),
  repair_manual_url TEXT,
  serviceability TEXT NOT NULL CHECK (serviceability IN ('user-serviceable','shop-serviceable','non-serviceable','sealed','not-yet-verified')),
  ifixit_score REAL,
  source_id INTEGER REFERENCES sources(id),
  verified_date TEXT NOT NULL
);
INSERT INTO repairability_v6 SELECT * FROM repairability;
DROP TABLE repairability;
ALTER TABLE repairability_v6 RENAME TO repairability;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.estwing.com/product/drilling-hammer/', 'Estwing B3-3LB drilling-hammer product page', 'manufacturer', '2026-09-08'),
  ('https://www.estwing.com/resources/warranty/', 'Estwing warranty and striking-tool service policy', 'manufacturer', '2026-09-08'),
  ('https://www.garagejournal.com/forum/threads/estwing-sledgehammer.522660/', 'Garage Journal: Estwing sledgehammer? exact-product owner discussion', 'owner-report', '2026-09-08'),
  ('https://www.practicalmachinist.com/forum/threads/ot-estwing-hammers-worth-the-extra.145239/', 'Practical Machinist: long-term Estwing owner discussion', 'owner-report', '2026-09-08'),
  ('https://commons.wikimedia.org/wiki/File:Estwing_3-lb._drilling_hammer.jpg', 'Wikimedia Commons: Estwing 3-lb. drilling hammer', 'other', '2026-09-08');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning,
  image_url, image_source_url, image_license_basis, last_reviewed_date,
  image_license_url, image_attribution, image_alt
) VALUES (
  17,
  'estwing-b3-3lb',
  'Estwing',
  'B3-3LB',
  'B3-3LB',
  'hammers',
  'tools-shop',
  'Three-pound model in Estwing''s B3 drilling-hammer family; do not substitute the B3-2LB or B3-4LB variants.',
  'T2',
  'not-yet-verified',
  'Manufacturer documentation verifies one-piece forged construction but also says used striking tools cannot be repaired, re-gripped, or refurbished. Two owner discussions provide useful fit and longevity context but do not meet the three-source T3 threshold or establish expected service life.',
  '/images/products/estwing-b3-3lb-drilling-hammer.jpg',
  'https://commons.wikimedia.org/wiki/File:Estwing_3-lb._drilling_hammer.jpg',
  'Open-license photograph identifies the exact model class as an Estwing 3-lb drilling hammer; Estwing identifies B3-3LB as its 3-lb drilling-hammer model.',
  '2026-09-08',
  'https://creativecommons.org/licenses/by-sa/3.0',
  'J.C. Fields (Typhoon) / Wikimedia Commons',
  'Estwing B3-3LB 3-lb drilling hammer with one-piece steel body and blue molded grip'
);

INSERT INTO product_sources
SELECT 17, id, 'identity and construction' FROM sources WHERE url = 'https://www.estwing.com/product/drilling-hammer/';
INSERT INTO product_sources
SELECT 17, id, 'warranty and repairability' FROM sources WHERE url = 'https://www.estwing.com/resources/warranty/';
INSERT INTO product_sources
SELECT 17, id, 'exact-product owner context' FROM sources WHERE url = 'https://www.garagejournal.com/forum/threads/estwing-sledgehammer.522660/';
INSERT INTO product_sources
SELECT 17, id, 'long-term owner context' FROM sources WHERE url = 'https://www.practicalmachinist.com/forum/threads/ot-estwing-hammers-worth-the-extra.145239/';
INSERT INTO product_sources
SELECT 17, id, 'image rights and exact-product evidence' FROM sources WHERE url = 'https://commons.wikimedia.org/wiki/File:Estwing_3-lb._drilling_hammer.jpg';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (17, 'identity', 'B3-3LB; 3 lb / 1.3 kg head; 11 in / 279 mm overall length; head and handle forged in one piece.', 'B3-3LB 3-lb drilling hammer; 11-inch overall length; head and handle forged in one piece.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.estwing.com/product/drilling-hammer/'), '2026-09-08', 180),
  (17, 'warranty', 'Estwing says the warranty is not a lifetime warranty and warrants all-steel hammers against failure in normal use, excluding misuse, abuse, and wearing out.', 'Not a lifetime warranty; all-steel hammer failure in normal use is covered subject to Estwing''s exclusions.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.estwing.com/resources/warranty/'), '2026-09-08', 180),
  (17, 'repair_manual', 'Estwing says it cannot repair, re-grip, or refurbish any used striking or struck tool.', 'No repair manual or refurbishment path: Estwing says it cannot repair, re-grip, or refurbish used striking tools.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.estwing.com/resources/warranty/'), '2026-09-08', 180),
  (17, 'parts_availability', 'Estwing says it cannot repair, re-grip, or refurbish any used striking or struck tool.', 'None documented; Estwing says it cannot repair, re-grip, or refurbish used striking tools.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.estwing.com/resources/warranty/'), '2026-09-08', 180),
  (17, 'serviceability', 'Manufacturer-documented non-serviceable striking tool.', 'Non-serviceable under Estwing''s published striking-tool policy.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.estwing.com/resources/warranty/'), '2026-09-08', 180),
  (17, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-08', 180),
  (17, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-08', 30),
  (17, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-08', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  17,
  'No fixed lifetime term; Estwing explicitly says this is not a lifetime warranty.',
  'All-steel hammers are warranted against failure in normal use.',
  'Misuse, abuse, wearing out, unauthorized repairs, alterations, tampering, and listed damage are excluded or require disposal.',
  (SELECT id FROM sources WHERE url = 'https://www.estwing.com/resources/warranty/'),
  '2026-09-08'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  17,
  'none',
  'https://www.estwing.com/resources/warranty/',
  0,
  NULL,
  'non-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.estwing.com/resources/warranty/'),
  '2026-09-08'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (17, 'Amazon Associates', 'https://www.amazon.com/dp/B00002N5NI?tag=everlastin08f-20', 1, '2026-09-08');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '6');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-08');

COMMIT;
PRAGMA foreign_keys = ON;
