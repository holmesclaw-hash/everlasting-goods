PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router', 'DEWALT DWP611 official product page', 'manufacturer', '2026-09-16'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf', 'DEWALT DWP611 Type 1 instruction manual', 'manufacturer', '2026-09-16'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611', 'DEWALT ServiceNet DWP611 Type 1 parts catalog', 'manufacturer', '2026-09-16'),
  ('https://www.dewalt.com/en-us/support/warranty', 'DEWALT tool warranty policy', 'manufacturer', '2026-09-16'),
  ('https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool', 'DEWALT spare-parts support policy', 'manufacturer', '2026-09-16'),
  ('https://www.reddit.com/r/XCarve/comments/1gfuiml/best_spindlerouter_for_original_xcarve/', 'Five-year DEWALT DWP611 owner report', 'owner-report', '2026-09-16'),
  ('https://www.reddit.com/r/Tools/comments/4clk9r/dewalt_dwp611_router_problems/', 'Eighteen-month DEWALT DWP611 failure report', 'owner-report', '2026-09-16');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  21,
  'dewalt-dwp611',
  'DEWALT',
  'DWP611',
  'DWP611',
  'routers',
  'tools-shop',
  'Current fixed-base Type 1 package with motor, standard base, wrench, and instruction manual. It is not the DWP611PK combination kit, which adds a plunge base.',
  'T2',
  'not-yet-verified',
  'Manufacturer documentation establishes exact identity, an operating manual, an exploded diagram, a live Type 1 parts catalog, and current warranty support. Exact-model owner reports include five years of regular medium use with one brush replacement and a separate variable-speed and sparking failure after eighteen months; those anecdotes are not representative durability data, so expected service life and a buy or repair recommendation remain unverified.',
  '2026-09-16'
);

INSERT INTO product_sources
SELECT 21, id, 'identity, package, and construction' FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router';
INSERT INTO product_sources
SELECT 21, id, 'operating, maintenance, and safety instructions' FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf';
INSERT INTO product_sources
SELECT 21, id, 'exact Type 1 parts support' FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611';
INSERT INTO product_sources
SELECT 21, id, 'warranty terms' FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty';
INSERT INTO product_sources
SELECT 21, id, 'parts ordering and repair boundary' FROM sources WHERE url = 'https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool';
INSERT INTO product_sources
SELECT 21, id, 'positive exact-model owner evidence' FROM sources WHERE url = 'https://www.reddit.com/r/XCarve/comments/1gfuiml/best_spindlerouter_for_original_xcarve/';
INSERT INTO product_sources
SELECT 21, id, 'negative exact-model owner evidence' FROM sources WHERE url = 'https://www.reddit.com/r/Tools/comments/4clk9r/dewalt_dwp611_router_problems/';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (21, 'identity', 'DWP611 Type 1 is a corded fixed-base compact router with a 1/4-inch collet, 7-amp input, aluminum motor housing and base, motor, standard base, wrench, and instruction manual.', 'Corded Type 1 fixed-base compact router with a 1/4-inch collet.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router'), '2026-09-16', 180),
  (21, 'warranty', 'The exact product page lists a 3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee; current DEWALT policy controls coverage, exclusions, and claim requirements.', '3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee; current DEWALT terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dwp611/1-14-hp-max-torque-variable-speed-compact-router'), '2026-09-16', 180),
  (21, 'repair_manual', 'DEWALT publishes a Type 1 instruction manual with operating, maintenance, and safety instructions. It directs service to a qualified repair person using identical replacement parts and is not an owner-repair manual.', 'Official Type 1 operating and safety manual is available; it is not an owner-repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf'), '2026-09-16', 180),
  (21, 'parts_availability', 'DEWALT ServiceNet publishes an exact DWP611 Type 1 parts catalog with model drawings and orderable components; individual component availability can vary.', 'Partial: exact DWP611 Type 1 parts catalog is live, but individual component availability varies.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611'), '2026-09-16', 180),
  (21, 'serviceability', 'The instruction manual directs service to qualified repair personnel. DEWALT lets owners order available parts but warns that replacing electrical or mechanical parts during the warranty period may void coverage.', 'Shop-serviceable through qualified repair; parts can be ordered, but no unrestricted owner-repair procedure is documented.', 'T2', (SELECT id FROM sources WHERE url = 'https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool'), '2026-09-16', 180),
  (21, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-16', 180),
  (21, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-16', 30),
  (21, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-16', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  21,
  '3-year limited warranty; 1-year free service; 90-day satisfaction guarantee.',
  'The exact product page lists the three support periods; the general policy states that first-year free service includes maintenance and replacement of worn parts caused by normal use.',
  'Current DEWALT policy controls eligibility, exclusions, transfer, proof, and claim requirements.',
  (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
  '2026-09-16'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  21,
  'partial',
  'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611',
  0,
  'https://assets.dewalt.com/GLOBALBOM/QU/DWP611/1/Instruction_Manual/EN/N336740_DWP611.pdf',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/ROUTERS/PREMIUM-COMPACT-ROUTER/p/DWP611'),
  '2026-09-16'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (21, 'Amazon Associates', 'https://www.amazon.com/dp/B0048EFUV8?tag=everlastin08f-20', 1, '2026-09-16');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '13');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-16');

COMMIT;
