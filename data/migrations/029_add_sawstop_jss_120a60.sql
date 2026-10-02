PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.sawstop.com/product/jobsite-saw-pro-jss-120a60', 'SawStop JSS-120A60 official product page', 'manufacturer', '2026-10-02'),
  ('https://www.sawstop.com/wp-content/uploads/2026/04/Jobsite-Saw-Pro-Owners-Manual.pdf', 'SawStop Jobsite Saw Pro owner''s manual', 'manufacturer', '2026-10-02'),
  ('https://www.sawstop.com/wp-content/uploads/2026/04/Parts-Lists-JSS-Pro-WEB-1.pdf', 'SawStop Jobsite Saw Pro parts lists', 'manufacturer', '2026-10-02'),
  ('https://www.sawstop.com/product-category/parts/jss/jss-120a60/', 'SawStop JSS-120A60 official parts store', 'manufacturer', '2026-10-02'),
  ('https://www.sawstop.com/wp-content/uploads/2025/10/Belt-Replacing-JSS-Belt-Motor.pdf', 'SawStop JSS belt replacement procedure', 'manufacturer', '2026-10-02'),
  ('https://www.sawstop.com/wp-content/uploads/2025/10/Switchbox-JSS-Switchbox-Replacement.pdf', 'SawStop JSS switch-box replacement procedure', 'manufacturer', '2026-10-02'),
  ('https://www.sawstop.com/support/warranty-information/', 'SawStop Jobsite Saw warranty information', 'manufacturer', '2026-10-02'),
  ('https://www.amazon.com/dp/B07WV5X277', 'Amazon exact SawStop JSS-120A60 destination', 'other', '2026-10-02'),
  ('https://www.mcguckin.com/2925123/product/Sawstop-JSS-120A60', 'McGuckin Hardware SawStop JSS-120A60 commercial corroboration', 'other', '2026-10-02');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  28,
  'sawstop-jss-120a60',
  'SawStop',
  'Jobsite Saw Pro',
  'JSS-120A60',
  'table-saws',
  'tools-shop',
  'JSS-120A60 is the United States 120V/60Hz Jobsite Saw Pro sold and shipped only as a full set with its mobile cart and high/low fence. The 230V JSS-230A50I, legacy JSS-MCA, and smaller CTS-120A60 Compact Table Saw remain separate models and configurations.',
  'T2',
  'not-yet-verified',
  'SawStop documentation establishes the exact JSS-120A60 package, owner maintenance and adjustments, model-specific exploded parts lists, current orderable replacement assemblies, official belt and switch-box service procedures, and current Jobsite Saw warranty terms. The used-sale discovery discussion did not establish ownership duration, and no qualifying exact-SKU duration evidence was verified, so expected service life and a buy or repair recommendation remain unverified.',
  '2026-10-02'
);

INSERT INTO product_sources
SELECT 28, id, 'exact identity, full-set package, specifications, included mobile cart, and variant boundaries' FROM sources WHERE url = 'https://www.sawstop.com/product/jobsite-saw-pro-jss-120a60';
INSERT INTO product_sources
SELECT 28, id, 'operation, safety, owner maintenance, adjustments, and user-replaceable-parts boundaries' FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2026/04/Jobsite-Saw-Pro-Owners-Manual.pdf';
INSERT INTO product_sources
SELECT 28, id, 'model-specific exploded assemblies and part numbers' FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2026/04/Parts-Lists-JSS-Pro-WEB-1.pdf';
INSERT INTO product_sources
SELECT 28, id, 'current official JSS-120A60 replacement-part categories' FROM sources WHERE url = 'https://www.sawstop.com/product-category/parts/jss/jss-120a60/';
INSERT INTO product_sources
SELECT 28, id, 'official belt service procedure and service-kit boundary' FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2025/10/Belt-Replacing-JSS-Belt-Motor.pdf';
INSERT INTO product_sources
SELECT 28, id, 'official exact-model switch-box replacement procedure and safety boundary' FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2025/10/Switchbox-JSS-Switchbox-Replacement.pdf';
INSERT INTO product_sources
SELECT 28, id, 'current Jobsite Saw warranty terms and exclusions' FROM sources WHERE url = 'https://www.sawstop.com/support/warranty-information/';
INSERT INTO product_sources
SELECT 28, id, 'exact Amazon model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B07WV5X277';
INSERT INTO product_sources
SELECT 28, id, 'independent exact-SKU and UPC commercial corroboration' FROM sources WHERE url = 'https://www.mcguckin.com/2925123/product/Sawstop-JSS-120A60';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (28, 'identity', 'SawStop identifies JSS-120A60 as the United States 120 VAC, 60 Hz Jobsite Saw Pro with a 15-amp universal motor, 10-inch blade, 25-1/2-inch right rip capacity, high/low T-style fence, and collapsible mobile cart. SawStop states that this package is sold and shipped as a full set only, with no cartless option.', '120V, 15A 10-inch Jobsite Saw Pro with mobile cart and 25-1/2-inch rip capacity; full-set package only.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/product/jobsite-saw-pro-jss-120a60'), '2026-10-02', 180),
  (28, 'warranty', 'The current SawStop warranty page covers a new Jobsite Saw purchased by the original retail purchaser from an authorized distributor for two years from purchase with product registration, and a refurbished Jobsite Saw Pro for one year. Normal wear, misuse, abuse, negligence, accidents, unauthorized repair or alteration, and lack of maintenance are excluded under current terms.', 'Two-year limited warranty for an eligible new Jobsite Saw with product registration; current SawStop terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/support/warranty-information/'), '2026-10-02', 180),
  (28, 'repair_manual', 'The owner''s manual documents maintenance, user-replaceable parts, troubleshooting, and adjustments. SawStop separately publishes service procedures for belt replacement and for exact-model JSS-120A60 switch-box replacement, including required tools, safety warnings, disassembly, replacement, and reassembly.', 'Official owner''s manual plus service procedures for belt and switch-box replacement.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2025/10/Switchbox-JSS-Switchbox-Replacement.pdf'), '2026-10-02', 180),
  (28, 'parts_availability', 'SawStop publishes current JSS-120A60 exploded parts lists and an exact-model parts store. Current categories and listings include the 120V motor, switch box, arbor and belt assemblies, fence and rail components, mobile-cart parts, guards, inserts, and smaller hardware. Current orderability was not confirmed for every item in the exploded lists.', 'Partial: official current listings cover the motor, switch box, fence, cart, belt, guards, and other components, but not every listed part was confirmed orderable.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/product-category/parts/jss/jss-120a60/'), '2026-10-02', 90),
  (28, 'serviceability', 'The owner''s manual identifies owner maintenance, adjustments, and user-replaceable parts including the power cord and blade guard. Official service procedures document internal belt and switch-box replacement with safety warnings and substantial disassembly. This supports competent shop service rather than unrestricted novice internal repair.', 'Shop-serviceable: owner power-cord and blade-guard work plus official belt and switch-box procedures with safety and disassembly requirements.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2025/10/Switchbox-JSS-Switchbox-Replacement.pdf'), '2026-10-02', 180),
  (28, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-02', 180),
  (28, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-02', 30),
  (28, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-02', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  28,
  'Two years from purchase with product registration for an eligible new Jobsite Saw; one year for an eligible refurbished Jobsite Saw Pro.',
  'Original retail purchaser from an authorized SawStop distributor, subject to current terms and proof of purchase.',
  'Misuse, abuse, negligence, accidents, normal wear, unauthorized repair or alteration, lack of maintenance, unauthorized modification, and operation outside the distributor country are excluded under current terms.',
  (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/support/warranty-information/'),
  '2026-10-02'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  28,
  'partial',
  'https://www.sawstop.com/product-category/parts/jss/jss-120a60/',
  1,
  'https://www.sawstop.com/wp-content/uploads/2025/10/Switchbox-JSS-Switchbox-Replacement.pdf',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2025/10/Switchbox-JSS-Switchbox-Replacement.pdf'),
  '2026-10-02'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (28, 'Amazon Associates', 'https://www.amazon.com/dp/B07WV5X277?tag=everlastin08f-20', 1, '2026-10-02');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '29');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-02');

COMMIT;
