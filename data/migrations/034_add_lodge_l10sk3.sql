PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.lodgecastiron.com/products/round-cast-iron-classic-skillet?variant=51685752242548', 'Lodge Classic Cast Iron Skillet official 12-inch product-family page', 'manufacturer', '2026-10-05'),
  ('https://www.lodgecastiron.com/pages/lodge-promise', 'Lodge Made Right limited lifetime warranty', 'manufacturer', '2026-10-05'),
  ('https://www.lodgecastiron.com/pages/how-to-clean', 'Lodge cast-iron cleaning and rust-recovery guidance', 'manufacturer', '2026-10-05'),
  ('https://www.lodgecastiron.com/pages/how-to-season', 'Lodge cast-iron seasoning guidance', 'manufacturer', '2026-10-05'),
  ('https://commons.wikimedia.org/wiki/File:Lodge_skillet.jpg', 'Wikimedia Commons Lodge 12-inch skillet image and license record', 'other', '2026-10-05'),
  ('https://www.centurylife.org/in-depth-product-review-lodge-12-inch-cast-iron-skillet-10sk-l10sk3ashh41b', 'CenturyLife Lodge 10SK and L10SK3 12-inch skillet review', 'owner-report', '2026-10-05'),
  ('https://permies.com/t/21138/Lodge-good-skillet-brand', 'Permies Lodge 12-inch skillet owner discussion', 'owner-report', '2026-10-05'),
  ('https://www.reddit.com/r/BuyItForLife/comments/etysnu', 'Reddit BuyItForLife Lodge 10SK 12-inch owner report', 'owner-report', '2026-10-05'),
  ('https://www.amazon.com/dp/B00006JSUB', 'Amazon exact standalone Lodge 12-inch skillet destination', 'other', '2026-10-05');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning,
  image_url, image_source_url, image_license_basis, last_reviewed_date,
  image_license_url, image_attribution, image_alt
) VALUES (
  32,
  'lodge-l10sk3',
  'Lodge',
  '12-Inch Classic Cast Iron Skillet',
  'L10SK3',
  'skillets',
  'kitchen',
  'This record is for the standalone Lodge 12-inch seasoned skillet associated with SKU L10SK3 and exact ASIN B00006JSUB. The 10.25-inch B00006JSUA variant and packages that add a silicone handle holder or other accessories are separate configurations; their package facts are not transferred.',
  'T2',
  'not-yet-verified',
  'Lodge documents a solid cast-iron body, renewable seasoning, cleaning and rust recovery, and a limited lifetime warranty with explicit exclusions. Independent reports describe meaningful weight, heating, and surface tradeoffs, and one exact-family owner report spans 12 years, but the evidence does not establish a population-level expected service life, failure rate, or repair-versus-replace recommendation.',
  '/images/products/lodge-l10sk3-12-inch-skillet.jpg',
  'https://commons.wikimedia.org/wiki/File:Lodge_skillet.jpg',
  'The open-license record identifies the exact model as a Lodge 12-inch cast-iron skillet; it supports the exact named 12-inch product model but does not independently establish the current L10SK3 SKU.',
  '2026-10-05',
  'https://creativecommons.org/licenses/by-sa/3.0',
  'Jim Heaphy (Cullen328) / Wikimedia Commons',
  'Lodge 12-Inch Classic Cast Iron Skillet viewed from above, showing the seasoned cooking surface, long handle, helper handle, and pour spouts'
);

INSERT INTO product_sources
SELECT 32, id, '12-inch product-family identity, solid cast-iron construction, seasoning, origin, and use surfaces' FROM sources WHERE url = 'https://www.lodgecastiron.com/products/round-cast-iron-classic-skillet?variant=51685752242548';
INSERT INTO product_sources
SELECT 32, id, 'limited lifetime warranty coverage and exclusions' FROM sources WHERE url = 'https://www.lodgecastiron.com/pages/lodge-promise';
INSERT INTO product_sources
SELECT 32, id, 'owner cleaning, drying, oiling, and rust-recovery path' FROM sources WHERE url = 'https://www.lodgecastiron.com/pages/how-to-clean';
INSERT INTO product_sources
SELECT 32, id, 'manufacturer re-seasoning process for renewable surface maintenance' FROM sources WHERE url = 'https://www.lodgecastiron.com/pages/how-to-season';
INSERT INTO product_sources
SELECT 32, id, 'open-license Lodge 12-inch product-class photograph and rights record' FROM sources WHERE url = 'https://commons.wikimedia.org/wiki/File:Lodge_skillet.jpg';
INSERT INTO product_sources
SELECT 32, id, 'exact-family independent review and ownership tradeoffs' FROM sources WHERE url = 'https://www.centurylife.org/in-depth-product-review-lodge-12-inch-cast-iron-skillet-10sk-l10sk3ashh41b';
INSERT INTO product_sources
SELECT 32, id, 'dated Lodge 12-inch owner-duration context' FROM sources WHERE url = 'https://permies.com/t/21138/Lodge-good-skillet-brand';
INSERT INTO product_sources
SELECT 32, id, 'exact 10SK 12-inch owner report spanning 2008 to 2020' FROM sources WHERE url = 'https://www.reddit.com/r/BuyItForLife/comments/etysnu';
INSERT INTO product_sources
SELECT 32, id, 'exact standalone 12-inch Amazon model destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B00006JSUB';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (32, 'identity', 'Lodge offers a 12-inch size in its Classic Cast Iron Skillet family. The manufacturer describes the skillet as solid cast iron, seasoned with natural vegetable oil, made in the USA, and usable on induction and other stovetops, in the oven, on a grill, or over a campfire.', '12-inch seasoned solid cast-iron skillet made in the USA for induction and other stovetops, ovens, grills, and campfires.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.lodgecastiron.com/products/round-cast-iron-classic-skillet?variant=51685752242548'), '2026-10-05', 180),
  (32, 'warranty', 'Lodge describes its Made Right coverage as a limited lifetime warranty for cast-iron cookware used normally in a household. Covered conditions include cracks, warping, specified casting defects, and shipping damage; exclusions include accidents, drops, mishandling, overheating, rust, pitting, roughness, sticky or flaking seasoning, odors, commercial use, and care inconsistent with the instructions.', 'Limited lifetime warranty covers specified cracks, warping, casting defects, and shipping damage; rust, pitting, seasoning condition, misuse, overheating, drops, and commercial use are excluded.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.lodgecastiron.com/pages/lodge-promise'), '2026-10-05', 180),
  (32, 'repair_manual', 'Lodge publishes official cleaning, drying, oiling, rust-removal, and re-seasoning guidance. These instructions support surface recovery but are not a model-specific structural repair manual.', 'Official cleaning, rust-recovery, and re-seasoning guidance is available; it is maintenance guidance, not a structural repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.lodgecastiron.com/pages/how-to-clean'), '2026-10-05', 180),
  (32, 'parts_availability', 'The product is a solid cast-iron skillet with integrated handles, and Lodge does not document replaceable product assemblies for this exact configuration. Routine surface wear or rust is addressed by cleaning, oiling, and re-seasoning rather than replacement parts.', 'No replaceable assemblies are documented; routine surface wear or rust is addressed through cleaning, oiling, and re-seasoning.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.lodgecastiron.com/products/round-cast-iron-classic-skillet?variant=51685752242548'), '2026-10-05', 180),
  (32, 'serviceability', 'Owners can perform Lodge-documented cleaning, rust removal, oiling, and re-seasoning. Structural cracks or warping are not documented as user repairs and instead fall within the warranty decision path when coverage conditions are met.', 'User-serviceable for cleaning, rust removal, and seasoning recovery; structural cracks or warping are not documented user repairs.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.lodgecastiron.com/pages/how-to-clean'), '2026-10-05', 180),
  (32, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 180),
  (32, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 30),
  (32, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-05', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  32,
  'Limited lifetime warranty for covered Lodge cast-iron cookware under normal household use.',
  'Lodge lists cracks, warping, specified casting defects, and shipping damage among covered conditions, subject to its claim process and current terms.',
  'Published exclusions include accidents, drops, mishandling, overheating, rust, pitting, roughness, sticky or flaking seasoning, odors, commercial use, and failure to follow care instructions.',
  (SELECT id FROM sources WHERE url = 'https://www.lodgecastiron.com/pages/lodge-promise'),
  '2026-10-05'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  32,
  'none',
  NULL,
  0,
  NULL,
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.lodgecastiron.com/pages/how-to-clean'),
  '2026-10-05'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (32, 'Amazon Associates', 'https://www.amazon.com/dp/B00006JSUB?tag=everlastin08f-20', 1, '2026-10-05');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '34');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-05');

COMMIT;
