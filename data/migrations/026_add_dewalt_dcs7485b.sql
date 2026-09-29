PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dcs7485b/60v-max-table-saw-tool-only', 'DEWALT DCS7485B official product page', 'manufacturer', '2026-09-29'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCS7485B/3/Instruction_Manual/EN/N785278_DCS7485_NA.pdf', 'DEWALT DCS7485B Type 3 instruction manual', 'manufacturer', '2026-09-29'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCS7485B/10/Instruction_Manual/EN/NA136581_DCS7485_NA.pdf', 'DEWALT DCS7485B Type 10 instruction manual', 'manufacturer', '2026-09-29'),
  ('https://www.toolservicenet.com/en//Dewalt/WOODWORKING/BENCH-SAWS/60V-MAX-TABLE-SAW---BARE/p/DCS7485B_10', 'DEWALT ServiceNet DCS7485B Type 10 parts catalog', 'manufacturer', '2026-09-29'),
  ('https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool', 'DEWALT spare-parts support policy', 'manufacturer', '2026-09-29'),
  ('https://www.dewalt.com/en-us/support/warranty', 'DEWALT tool warranty policy', 'manufacturer', '2026-09-29'),
  ('https://www.amazon.com/dp/B01H9BLZ6A', 'Amazon exact DEWALT DCS7485B destination', 'other', '2026-09-29'),
  ('https://www.acmetools.com/dewalt-flexvolt-60v-max-8-1-4in-table-saw-bare-tool-dcs7485b/885911454162.html', 'Acme Tools DEWALT DCS7485B commercial corroboration', 'other', '2026-09-29');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  26,
  'dewalt-dcs7485b',
  'DEWALT',
  'DCS7485',
  'DCS7485B',
  'table-saws',
  'tools-shop',
  'DCS7485B is the US bare-tool package: it includes the DCS7485 saw and listed saw accessories but no battery or charger. DCS7485T1 is a separate kit that adds one FLEXVOLT battery and a fast charger. Service documentation is type-specific for Types 1, 3, and 10, so owners must match the type number before ordering parts.',
  'T2',
  'not-yet-verified',
  'DEWALT documentation establishes the exact DCS7485B bare-tool identity, type-specific operating and maintenance manuals, a Type 10 ServiceNet catalog with orderable components, current spare-parts support, and the stated three-year limited warranty package. No qualifying exact-SKU duration evidence was verified; model-level discussions do not establish representative service life for the DCS7485B package, so expected service life and a buy or repair recommendation remain unverified.',
  '2026-09-29'
);

INSERT INTO product_sources
SELECT 26, id, 'identity, bare-tool package, specifications, and warranty statement' FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcs7485b/60v-max-table-saw-tool-only';
INSERT INTO product_sources
SELECT 26, id, 'Type 3 operating, safety, and maintenance instructions' FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCS7485B/3/Instruction_Manual/EN/N785278_DCS7485_NA.pdf';
INSERT INTO product_sources
SELECT 26, id, 'Type 10 cleaning, lubrication, and authorized-repair boundaries' FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCS7485B/10/Instruction_Manual/EN/NA136581_DCS7485_NA.pdf';
INSERT INTO product_sources
SELECT 26, id, 'Type 10 exploded diagram and orderable parts' FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/BENCH-SAWS/60V-MAX-TABLE-SAW---BARE/p/DCS7485B_10';
INSERT INTO product_sources
SELECT 26, id, 'parts ordering and type-number boundary' FROM sources WHERE url = 'https://support.dewalt.com/hc/en-us/articles/7985430800781-Where-can-I-buy-spare-parts-for-my-tool';
INSERT INTO product_sources
SELECT 26, id, 'current warranty terms and exclusions' FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty';
INSERT INTO product_sources
SELECT 26, id, 'exact Amazon model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B01H9BLZ6A';
INSERT INTO product_sources
SELECT 26, id, 'independent exact-SKU commercial corroboration' FROM sources WHERE url = 'https://www.acmetools.com/dewalt-flexvolt-60v-max-8-1-4in-table-saw-bare-tool-dcs7485b/885911454162.html';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (26, 'identity', 'DCS7485B is the US 60V MAX cordless brushless 8-1/4-inch DCS7485 table saw sold as a tool-only package. DEWALT lists the saw, carbide blade, push stick, blade guard, rip fence, non-through-cut riving knife, two blade wrenches, and miter gauge; battery and charger are not included.', 'Cordless brushless 8-1/4-inch table saw sold as the DCS7485B tool-only package; battery and charger are not included.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcs7485b/60v-max-table-saw-tool-only'), '2026-09-29', 180),
  (26, 'warranty', 'The exact DCS7485B product page states a 3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee. Current DEWALT policy limits coverage to eligible original end-user purchases and excludes normal wear, abuse, and unauthorized repair, subject to applicable law.', '3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee; current DEWALT terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'), '2026-09-29', 180),
  (26, 'repair_manual', 'DEWALT publishes type-specific DCS7485 operating, safety, and maintenance manuals. They document setup, cleaning, and lubrication but direct repairs, maintenance, and adjustment beyond those procedures to DEWALT factory or authorized service centers; they are not owner-repair manuals.', 'Official type-specific operating and maintenance manuals are available; they are not owner-repair manuals.', 'T2', (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCS7485B/10/Instruction_Manual/EN/NA136581_DCS7485_NA.pdf'), '2026-09-29', 180),
  (26, 'parts_availability', 'DEWALT ServiceNet publishes a type-specific DCS7485B Type 10 exploded diagram and lists orderable components. ServiceNet also identifies Types 1 and 3, but stock and applicability vary by type and component, so owners must match the saw type before ordering.', 'Partial: type-specific ServiceNet diagrams and orderable components are available, but stock and applicability vary by type.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/BENCH-SAWS/60V-MAX-TABLE-SAW---BARE/p/DCS7485B_10'), '2026-09-29', 90),
  (26, 'serviceability', 'The Type 10 manual documents owner cleaning, weekly air-vent dust removal, dust-door cleanup, and periodic cleaning and lubrication of the height-adjustment screw. It directs repairs, maintenance, brush work, and adjustment beyond those procedures to DEWALT factory or authorized service.', 'User-serviceable for documented cleaning and height-adjustment screw lubrication; internal repair is directed to authorized service.', 'T2', (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCS7485B/10/Instruction_Manual/EN/NA136581_DCS7485_NA.pdf'), '2026-09-29', 180),
  (26, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-29', 180),
  (26, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-29', 30),
  (26, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-09-29', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  26,
  '3-year limited warranty; 1-year free service; 90-day satisfaction guarantee.',
  'The exact DCS7485B product page states all three support periods; current policy covers eligible defects in materials or workmanship and defines the first-year service contract.',
  'Normal wear, abuse, unauthorized-seller limitations, and attempted unauthorized repairs are subject to current DEWALT terms and applicable law.',
  (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/support/warranty'),
  '2026-09-29'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  26,
  'partial',
  'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/BENCH-SAWS/60V-MAX-TABLE-SAW---BARE/p/DCS7485B_10',
  0,
  'https://assets.dewalt.com/GLOBALBOM/QU/DCS7485B/10/Instruction_Manual/EN/NA136581_DCS7485_NA.pdf',
  'user-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en//Dewalt/WOODWORKING/BENCH-SAWS/60V-MAX-TABLE-SAW---BARE/p/DCS7485B_10'),
  '2026-09-29'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (26, 'Amazon Associates', 'https://www.amazon.com/dp/B01H9BLZ6A?tag=everlastin08f-20', 1, '2026-09-29');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '26');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-29');

COMMIT;
