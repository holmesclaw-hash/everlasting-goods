PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.sawstop.com/product/contractor-saw-cns175-tgp236', 'SawStop CNS175-TGP236 official product page', 'manufacturer', '2026-09-30'),
  ('https://www.sawstop.com/wp-content/uploads/2026/04/Contractor-Saw-Owners-Manual_US_EN-3-1.pdf', 'SawStop CNS175 Contractor Saw owner''s manual', 'manufacturer', '2026-09-30'),
  ('https://www.sawstop.com/wp-content/uploads/2026/04/Parts_Lists_CNS.pdf', 'SawStop CNS175 Contractor Saw parts lists', 'manufacturer', '2026-09-30'),
  ('https://sawstop.com/product-category/parts/cns', 'SawStop CNS Contractor Saw official parts store', 'manufacturer', '2026-09-30'),
  ('https://www.sawstop.com/support/warranty-information/', 'SawStop Contractor Saw warranty information', 'manufacturer', '2026-09-30'),
  ('https://www.amazon.com/dp/B006G36VHG', 'Amazon exact SawStop CNS175-TGP236 destination', 'other', '2026-09-30'),
  ('https://www.toolnut.com/products/sawstop-cns175-tgp236-110v-single-phase-1-75-hp-15-amp-10-contractor-saw-with-36-professional-series-t-glide-fence-system', 'Tool Nut SawStop CNS175-TGP236 commercial corroboration', 'other', '2026-09-30');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  27,
  'sawstop-cns175-tgp236',
  'SawStop',
  'Contractor Saw CNS175',
  'CNS175-TGP236',
  'table-saws',
  'tools-shop',
  'CNS175-TGP236 is the 1.75-hp CNS175 Contractor Saw configuration with the 36-inch Professional T-Glide fence and rail system. It is separate from the 30-inch Premium Fence, 52-inch T-Glide, T-Glide Advance, Professional Cabinet Saw, and Industrial Cabinet Saw configurations.',
  'T2',
  'not-yet-verified',
  'SawStop documentation establishes the exact CNS175-TGP236 configuration, a CNS175 owner maintenance manual, detailed CNS parts lists, a current official CNS parts store, and official CNS175 warranty terms. No qualifying exact-SKU duration evidence was verified, so expected service life and a buy or repair recommendation remain unverified.',
  '2026-09-30'
);

INSERT INTO product_sources
SELECT 27, id, 'exact configuration, specifications, included items, and warranty statement' FROM sources WHERE url = 'https://www.sawstop.com/product/contractor-saw-cns175-tgp236';
INSERT INTO product_sources
SELECT 27, id, 'CNS175 operation, safety, adjustment, maintenance, and service boundaries' FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2026/04/Contractor-Saw-Owners-Manual_US_EN-3-1.pdf';
INSERT INTO product_sources
SELECT 27, id, 'CNS175 exploded assemblies and part numbers' FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2026/04/Parts_Lists_CNS.pdf';
INSERT INTO product_sources
SELECT 27, id, 'current official CNS replacement-part listings' FROM sources WHERE url = 'https://sawstop.com/product-category/parts/cns';
INSERT INTO product_sources
SELECT 27, id, 'manufacturer warranty information landing page' FROM sources WHERE url = 'https://www.sawstop.com/support/warranty-information/';
INSERT INTO product_sources
SELECT 27, id, 'exact Amazon model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B006G36VHG';
INSERT INTO product_sources
SELECT 27, id, 'independent exact-SKU commercial corroboration' FROM sources WHERE url = 'https://www.toolnut.com/products/sawstop-cns175-tgp236-110v-single-phase-1-75-hp-15-amp-10-contractor-saw-with-36-professional-series-t-glide-fence-system';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (27, 'identity', 'SawStop identifies CNS175-TGP236 as the 1.75-hp 10-inch Contractor Saw configuration with the 36-inch Professional T-Glide fence system, two steel extension wings, blade, standard brake cartridge, riving knife, blade guard, miter gauge, push stick, and setup hardware.', '1.75-hp 10-inch CNS175 Contractor Saw with the 36-inch Professional T-Glide fence system.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/product/contractor-saw-cns175-tgp236'), '2026-09-30', 180),
  (27, 'warranty', 'The CNS175 owner manual warrants a new Contractor Saw purchased by the original retail purchaser from an authorized distributor against defects in material and workmanship for two years from purchase. It excludes normal wear, unauthorized repair or alteration, misuse, abuse, negligence, accidents, and lack of maintenance.', 'Two-year limited warranty for the eligible original retail purchaser; official SawStop terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2026/04/Contractor-Saw-Owners-Manual_US_EN-3-1.pdf'), '2026-09-30', 180),
  (27, 'repair_manual', 'SawStop publishes a CNS175 owner''s manual with operating, adjustment, troubleshooting, cartridge replacement, and maintenance procedures. It is an owner operation and maintenance manual, not a comprehensive internal repair manual.', 'Official CNS175 owner operation and maintenance manual is available; it is not a comprehensive repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2026/04/Contractor-Saw-Owners-Manual_US_EN-3-1.pdf'), '2026-09-30', 180),
  (27, 'parts_availability', 'SawStop publishes detailed CNS175 exploded parts lists and a current official CNS parts store with orderable assemblies and components including motors, contactor boxes, brake cartridges, and 36-inch T-Glide rail and table parts. Current orderability was not confirmed for every item in the parts lists.', 'Partial: official exploded parts lists and a current CNS parts store cover major assemblies and components, but not every listed part was confirmed orderable.', 'T2', (SELECT id FROM sources WHERE url = 'https://sawstop.com/product-category/parts/cns'), '2026-09-30', 90),
  (27, 'serviceability', 'The CNS175 manual documents owner inspection and replacement of the brake cartridge, cleaning and lubrication of elevation and tilt gearing, table rust prevention, and inspection and replacement of a worn or damaged motor belt. These procedures do not establish unrestricted internal owner repair.', 'User-serviceable for documented brake-cartridge, gearing, table, and motor-belt maintenance; broader internal repair is not established.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2026/04/Contractor-Saw-Owners-Manual_US_EN-3-1.pdf'), '2026-09-30', 180),
  (27, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-30', 180),
  (27, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-30', 30),
  (27, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-30', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  27,
  'Two years from purchase for an eligible new Contractor Saw.',
  'Original retail purchaser of a new Contractor Saw from an authorized SawStop distributor, subject to the official manual terms and proof of purchase.',
  'Misuse, abuse, negligence, accidents, normal wear, unauthorized repair or alteration, lack of maintenance, unauthorized modification, and operation outside the distributor country are excluded under the official manual terms.',
  (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2026/04/Contractor-Saw-Owners-Manual_US_EN-3-1.pdf'),
  '2026-09-30'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  27,
  'partial',
  'https://sawstop.com/product-category/parts/cns',
  0,
  'https://www.sawstop.com/wp-content/uploads/2026/04/Contractor-Saw-Owners-Manual_US_EN-3-1.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://sawstop.com/product-category/parts/cns'),
  '2026-09-30'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (27, 'Amazon Associates', 'https://www.amazon.com/dp/B006G36VHG?tag=everlastin08f-20', 1, '2026-09-30');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '27');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-30');

COMMIT;
