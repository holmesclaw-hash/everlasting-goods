PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.victorinox.com/en-US/p/5.2063.20', 'Victorinox Fibrox Chef’s Knife Extra Wide 5.2063.20 official product page', 'manufacturer', '2026-10-06'),
  ('https://www.victorinox.com/en-US/Cutlery/Information/How-to-Sharpen-Your-Kitchen-Knife/cms/how-to-sharpen-your-kitchen-knife/', 'Victorinox knife sharpening and honing guidance', 'manufacturer', '2026-10-06'),
  ('https://www.victorinox.com/en-US/Cutlery-Warranties/cms/service-cutlery-warranties/', 'Victorinox US cutlery warranty terms', 'manufacturer', '2026-10-06'),
  ('https://barbecuefaq.com/victorinox-knives-review/', 'Barbecue FAQ Victorinox review from a 15-plus-year owner', 'owner-report', '2026-10-06'),
  ('https://commons.wikimedia.org/wiki/File:Victorinox_Fibrox_5.2063.20_chef%27s_knife.jpg', 'Wikimedia Commons Victorinox Fibrox 5.2063.20 image and license record', 'other', '2026-10-06'),
  ('https://www.amazon.com/dp/B008M5U1C2', 'Amazon exact Victorinox Fibrox Pro 8-inch destination', 'other', '2026-10-06');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning,
  image_url, image_source_url, image_license_basis, last_reviewed_date,
  image_license_url, image_attribution, image_alt
) VALUES (
  34,
  'victorinox-fibrox-5-2063-20',
  'Victorinox',
  'Fibrox Chef’s Knife Extra Wide, 8 in',
  '5.2063.20',
  'chef-knives',
  'kitchen',
  'This record is for Victorinox item 5.2063.20, the black, extra-wide approximately 8-inch Fibrox chef’s knife, and exact ASIN B008M5U1C2. Other blade lengths, colors, handles, sets, and retail packages are separate configurations; their facts are not transferred.',
  'T2',
  'not-yet-verified',
  'Victorinox documents the exact item identity, a renewable plain edge, user honing and sharpening, optional professional sharpening, and lifetime coverage for material or manufacturer defects during normal use subject to purchase requirements. One owner report describes 15-plus years with Victorinox knives and shows a Fibrox chef knife, but it does not establish the exact current SKU’s expected service life, a population-level failure rate, or a repair-versus-replace recommendation.',
  '/images/products/victorinox-fibrox-5-2063-20.jpg',
  'https://commons.wikimedia.org/wiki/File:Victorinox_Fibrox_5.2063.20_chef%27s_knife.jpg',
  'The open-license record identifies the photographed knife as the exact model, Victorinox Fibrox 5.2063.20; it supports visual model identity but does not independently establish the current Amazon commercial destination.',
  '2026-10-06',
  'https://creativecommons.org/licenses/by-sa/4.0',
  'Francis Flinch / Wikimedia Commons',
  'Victorinox Fibrox Chef’s Knife Extra Wide, 8 in, item 5.2063.20, with a black textured TPE handle on a white background'
);

INSERT INTO product_sources
SELECT 34, id, 'exact item identity, dimensions, origin, construction, edge, handle, care statement, and product warranty status' FROM sources WHERE url = 'https://www.victorinox.com/en-US/p/5.2063.20';
INSERT INTO product_sources
SELECT 34, id, 'manufacturer honing, sharpening, and professional sharpening guidance' FROM sources WHERE url = 'https://www.victorinox.com/en-US/Cutlery/Information/How-to-Sharpen-Your-Kitchen-Knife/cms/how-to-sharpen-your-kitchen-knife/';
INSERT INTO product_sources
SELECT 34, id, 'lifetime defect coverage and purchase requirements' FROM sources WHERE url = 'https://www.victorinox.com/en-US/Cutlery-Warranties/cms/service-cutlery-warranties/';
INSERT INTO product_sources
SELECT 34, id, 'dated long-term Victorinox owner report with a shown Fibrox chef knife and stated limitations' FROM sources WHERE url = 'https://barbecuefaq.com/victorinox-knives-review/';
INSERT INTO product_sources
SELECT 34, id, 'open-license exact-model photograph and rights record' FROM sources WHERE url = 'https://commons.wikimedia.org/wiki/File:Victorinox_Fibrox_5.2063.20_chef%27s_knife.jpg';
INSERT INTO product_sources
SELECT 34, id, 'exact black Victorinox Fibrox Pro 8-inch Amazon destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B008M5U1C2';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (34, 'identity', 'Victorinox identifies item 5.2063.20 as the Fibrox Chef’s Knife Extra Wide in black. The page lists a 7.9-inch blade, Swiss origin, non-forged construction, a straight edge, and a thermoplastic-elastomer handle.', 'Approximately 8-inch Swiss-made, non-forged chef’s knife with a straight edge, extra-wide blade, and black TPE handle.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.victorinox.com/en-US/p/5.2063.20'), '2026-10-06', 180),
  (34, 'warranty', 'Victorinox states that the product has its lifetime warranty. The US cutlery warranty covers material or manufacturer defects appearing during normal use for the lifetime of the product and requires proof of purchase from an authorised Victorinox store or retailer.', 'Lifetime coverage for material or manufacturer defects during normal use; proof of purchase from an authorised Victorinox store or retailer is required.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.victorinox.com/en-US/Cutlery-Warranties/cms/service-cutlery-warranties/'), '2026-10-06', 180),
  (34, 'repair_manual', 'Victorinox publishes general knife honing and sharpening instructions and offers professional sharpening through stores. This supports edge maintenance but is not a model-specific structural repair manual.', 'Official sharpening and honing guidance is available for edge maintenance; it is not a model-specific structural repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.victorinox.com/en-US/Cutlery/Information/How-to-Sharpen-Your-Kitchen-Knife/cms/how-to-sharpen-your-kitchen-knife/'), '2026-10-06', 180),
  (34, 'parts_availability', 'The reviewed exact product, sharpening, and warranty pages do not document a model-specific replacement blade, molded handle, or field-parts program for item 5.2063.20.', 'No model-specific replacement blade or handle is documented in the reviewed manufacturer sources.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.victorinox.com/en-US/p/5.2063.20'), '2026-10-06', 180),
  (34, 'serviceability', 'Owners can hone the edge regularly and sharpen it when honing no longer restores performance. Victorinox also describes an in-store professional sharpening option.', 'User-serviceable through honing and sharpening, with professional sharpening also documented by Victorinox.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.victorinox.com/en-US/Cutlery/Information/How-to-Sharpen-Your-Kitchen-Knife/cms/how-to-sharpen-your-kitchen-knife/'), '2026-10-06', 180),
  (34, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-06', 180),
  (34, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-06', 30),
  (34, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-06', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  34,
  'Lifetime warranty for covered Victorinox products.',
  'Victorinox covers material or manufacturer defects that appear during normal use for the lifetime of the product, subject to its current terms and purchase requirements.',
  'Coverage is limited to material or manufacturer defects during normal use. Proof of purchase from an authorised Victorinox store or retailer is required; the reviewed page does not state that ordinary edge dulling is covered.',
  (SELECT id FROM sources WHERE url = 'https://www.victorinox.com/en-US/Cutlery-Warranties/cms/service-cutlery-warranties/'),
  '2026-10-06'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  34,
  'none',
  NULL,
  0,
  NULL,
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.victorinox.com/en-US/Cutlery/Information/How-to-Sharpen-Your-Kitchen-Knife/cms/how-to-sharpen-your-kitchen-knife/'),
  '2026-10-06'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (34, 'Amazon Associates', 'https://www.amazon.com/dp/B008M5U1C2?tag=everlastin08f-20', 1, '2026-10-06');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '36');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-06');

COMMIT;
