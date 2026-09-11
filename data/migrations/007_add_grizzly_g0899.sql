BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.grizzly.com/products/grizzly-10-2-hp-115v-230v-cabinet-saw/g0899', 'Grizzly G0899 official product page', 'manufacturer', '2026-09-11'),
  ('https://cdn0.grizzly.com/manuals/g0899_m.pdf', 'Grizzly G0899 owner manual', 'manufacturer', '2026-09-11'),
  ('https://www.grizzly.com/products/g0899/parts', 'Grizzly G0899 exact-model parts catalog', 'manufacturer', '2026-09-11'),
  ('https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty', 'Grizzly limited warranty policy', 'manufacturer', '2026-09-11'),
  ('https://www.reddit.com/r/woodworking/comments/rdhckn/awful_experience_with_grizzly/', 'Reddit: G0899 owner quality and service report', 'owner-report', '2026-09-11'),
  ('https://www.reddit.com/r/woodworking/comments/1w68e2p/tablesaw_recommendations/', 'Reddit: current G0899 owner report', 'owner-report', '2026-09-11');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  18,
  'grizzly-g0899',
  'Grizzly',
  'G0899',
  'G0899',
  'table-saws',
  'tools-shop',
  'Current 10-inch 2 HP 115V/230V cabinet-saw configuration; verify the manufacture date against the matching manual revision before ordering service parts.',
  'T2',
  'not-yet-verified',
  'Manufacturer documentation verifies cast-iron tables and trunnions, a detailed owner-service manual, an exact-model parts catalog, and a one-year limited warranty. Two exact-model owner reports provide mixed quality context but do not establish expected service life or a recommendation.',
  '2026-09-11'
);

INSERT INTO product_sources
SELECT 18, id, 'identity and construction' FROM sources WHERE url = 'https://www.grizzly.com/products/grizzly-10-2-hp-115v-230v-cabinet-saw/g0899';
INSERT INTO product_sources
SELECT 18, id, 'maintenance and service manual' FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0899_m.pdf';
INSERT INTO product_sources
SELECT 18, id, 'parts availability' FROM sources WHERE url = 'https://www.grizzly.com/products/g0899/parts';
INSERT INTO product_sources
SELECT 18, id, 'warranty terms' FROM sources WHERE url = 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty';
INSERT INTO product_sources
SELECT 18, id, 'owner-reported initial quality and service context' FROM sources WHERE url = 'https://www.reddit.com/r/woodworking/comments/rdhckn/awful_experience_with_grizzly/';
INSERT INTO product_sources
SELECT 18, id, 'owner-reported durability and accuracy context' FROM sources WHERE url = 'https://www.reddit.com/r/woodworking/comments/1w68e2p/tablesaw_recommendations/';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (18, 'identity', 'G0899 10-inch 2 HP 115V/230V cabinet table saw with precision-ground cast-iron table and cabinet-mounted cast-iron trunnion.', 'G0899 10-inch 2 HP 115V/230V cabinet table saw with a precision-ground cast-iron table and cabinet-mounted cast-iron trunnion.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.grizzly.com/products/grizzly-10-2-hp-115v-230v-cabinet-saw/g0899'), '2026-09-11', 180),
  (18, 'warranty', 'Grizzly warrants house-brand products for one year to the original purchaser; misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, lack of maintenance, and consumable parts are excluded.', '1-year limited warranty for the original purchaser, subject to Grizzly''s published exclusions and proof-of-purchase requirements.', 'T2', (SELECT id FROM sources WHERE url = 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty'), '2026-09-11', 180),
  (18, 'repair_manual', 'Official G0899 owner manual includes maintenance, service, troubleshooting, alignment, belt replacement, wiring, and parts sections.', 'Official owner manual includes maintenance, service, troubleshooting, alignment, belt replacement, wiring, and parts sections.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0899_m.pdf'), '2026-09-11', 180),
  (18, 'parts_availability', 'Exact-model online catalog and parts list provide diagrams, revision-specific part numbers, replacements, and availability status; Grizzly does not guarantee every shown part remains available.', 'Partial: exact-model parts diagrams and ordering links are published, but Grizzly states that availability is not guaranteed for every listed part.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.grizzly.com/products/g0899/parts'), '2026-09-11', 180),
  (18, 'serviceability', 'The owner manual documents maintenance, alignment, troubleshooting, and belt replacement; electrical installation and conversion are reserved for qualified personnel.', 'User-serviceable for documented maintenance, alignment, and belt replacement; electrical work is reserved for qualified personnel.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0899_m.pdf'), '2026-09-11', 180),
  (18, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-11', 180),
  (18, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-11', 30),
  (18, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-11', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  18,
  '1 year to the original purchaser from the date of purchase.',
  'Defects covered under Grizzly''s house-brand limited warranty; proof of purchase is required.',
  'Misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, lack of maintenance, consumable parts, third-party repair costs, and transport expenses are excluded or not reimbursed.',
  (SELECT id FROM sources WHERE url = 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty'),
  '2026-09-11'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  18,
  'partial',
  'https://www.grizzly.com/products/g0899/parts',
  1,
  'https://cdn0.grizzly.com/manuals/g0899_m.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.grizzly.com/products/g0899/parts'),
  '2026-09-11'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (18, 'Amazon Associates', 'https://www.amazon.com/dp/B08B6G2L6P?tag=everlastin08f-20', 1, '2026-09-11');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '7');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-11');

COMMIT;
