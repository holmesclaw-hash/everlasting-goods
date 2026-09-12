BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.grizzly.com/products/grizzly-10-2-hp-120v-hybrid-table-saw-w-t-shaped-fence/g0771z', 'Grizzly G0771Z official product page', 'manufacturer', '2026-09-12'),
  ('https://cdn0.grizzly.com/manuals/g0771z_m.pdf', 'Grizzly G0771Z current owner-manual update', 'manufacturer', '2026-09-12'),
  ('https://cdn0.grizzly.com/partslists/g0771z_pl.pdf', 'Grizzly G0771Z current parts-list update', 'manufacturer', '2026-09-12'),
  ('https://www.grizzly.com/products/g0771z/parts', 'Grizzly G0771Z exact-model parts catalog', 'manufacturer', '2026-09-12'),
  ('https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty', 'Grizzly limited warranty policy', 'manufacturer', '2026-09-12'),
  ('https://www.reddit.com/r/woodworking/comments/16qco9f/table_saw_lifting_mechanism_problems/', 'Reddit: G0771Z blade-lift owner repair report', 'owner-report', '2026-09-12'),
  ('https://www.reddit.com/r/woodworking/comments/10ub8xc/dewalt_jobsite_or_grizzly_hybrid_table_saw/', 'Reddit: G0771Z two-year owner follow-up', 'owner-report', '2026-09-12');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  19,
  'grizzly-g0771z',
  'Grizzly',
  'G0771Z',
  'G0771Z',
  'table-saws',
  'tools-shop',
  'Current 10-inch 2 HP hybrid table-saw configuration; match the machine manufacture date to the applicable manual and part revision before ordering service parts.',
  'T2',
  'not-yet-verified',
  'Manufacturer documentation verifies cast-iron tables and trunnions, a model-specific manual/update, revision-specific parts documentation, an exact-model parts catalog, and a one-year limited warranty. A two-year owner follow-up and a separate repair report provide mixed context but do not establish expected service life, recurring failure rates, or a recommendation.',
  '2026-09-12'
);

INSERT INTO product_sources
SELECT 19, id, 'identity and construction' FROM sources WHERE url = 'https://www.grizzly.com/products/grizzly-10-2-hp-120v-hybrid-table-saw-w-t-shaped-fence/g0771z';
INSERT INTO product_sources
SELECT 19, id, 'model-specific adjustment documentation' FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0771z_m.pdf';
INSERT INTO product_sources
SELECT 19, id, 'revision-specific parts documentation' FROM sources WHERE url = 'https://cdn0.grizzly.com/partslists/g0771z_pl.pdf';
INSERT INTO product_sources
SELECT 19, id, 'parts availability' FROM sources WHERE url = 'https://www.grizzly.com/products/g0771z/parts';
INSERT INTO product_sources
SELECT 19, id, 'warranty terms' FROM sources WHERE url = 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty';
INSERT INTO product_sources
SELECT 19, id, 'owner-reported repair and parts-delay context' FROM sources WHERE url = 'https://www.reddit.com/r/woodworking/comments/16qco9f/table_saw_lifting_mechanism_problems/';
INSERT INTO product_sources
SELECT 19, id, 'two-year owner-reported use and dust-collection context' FROM sources WHERE url = 'https://www.reddit.com/r/woodworking/comments/10ub8xc/dewalt_jobsite_or_grizzly_hybrid_table_saw/';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (19, 'identity', 'G0771Z 10-inch 2 HP hybrid table saw; 120V/240V, prewired for 120V; precision-ground cast-iron table and cabinet-mounted cast-iron trunnions.', 'G0771Z 10-inch 2 HP 120V/240V hybrid table saw with a precision-ground cast-iron table and cabinet-mounted cast-iron trunnions.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.grizzly.com/products/grizzly-10-2-hp-120v-hybrid-table-saw-w-t-shaped-fence/g0771z'), '2026-09-12', 180),
  (19, 'warranty', 'Grizzly products carry one-year coverage for the original purchaser from purchase or shipment; proof of purchase is required and published exclusions apply.', '1-year limited warranty for the original purchaser, subject to Grizzly''s published exclusions and proof-of-purchase requirements.', 'T2', (SELECT id FROM sources WHERE url = 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty'), '2026-09-12', 180),
  (19, 'repair_manual', 'The official model-specific manual/update documents table-insert adjustment and current revised parts and states that the rest of the owner manual remains applicable.', 'Official model-specific manual/update documents table-insert adjustment, current parts revisions, and continued applicability of the owner manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0771z_m.pdf'), '2026-09-12', 180),
  (19, 'parts_availability', 'Exact-model catalog and parts-list update provide revision-specific part numbers, replacements, and availability states; Grizzly does not guarantee every shown part remains available.', 'Partial: exact-model catalog provides revision-specific parts and replacement links, but Grizzly states that every listed part is not guaranteed to remain available.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.grizzly.com/products/g0771z/parts'), '2026-09-12', 180),
  (19, 'serviceability', 'Official documentation provides a user table-insert adjustment procedure and exact-model replacement parts; broader work must follow the manufacture-date manual revision.', 'User-serviceable for the documented table-insert adjustment and published replacement parts; use the manual revision matching the machine manufacture date.', 'T2', (SELECT id FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0771z_m.pdf'), '2026-09-12', 180),
  (19, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-12', 180),
  (19, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-12', 30),
  (19, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-12', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  19,
  '1 year to the original purchaser from the date of purchase or shipment.',
  'Defects covered under Grizzly''s house-brand limited warranty; proof of purchase is required.',
  'Misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, lack of maintenance, consumable parts, third-party repair costs, and transport expenses are excluded or not reimbursed.',
  (SELECT id FROM sources WHERE url = 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty'),
  '2026-09-12'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  19,
  'partial',
  'https://www.grizzly.com/products/g0771z/parts',
  1,
  'https://cdn0.grizzly.com/manuals/g0771z_m.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.grizzly.com/products/g0771z/parts'),
  '2026-09-12'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (19, 'Amazon Associates', 'https://www.amazon.com/dp/B07K7SZPBR?tag=everlastin08f-20', 1, '2026-09-12');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '8');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-12');

COMMIT;
