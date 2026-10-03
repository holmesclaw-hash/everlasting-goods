PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://metabo-hpt.com/products/product/c10rjs-10-jobsite-table-saw-w-fold-roll-stand-metabo-hpt', 'Metabo HPT C10RJS official product page', 'manufacturer', '2026-10-03'),
  ('https://www.metabo-hpt.com/docs/default-source/product-owners-manuals/c10rj(s)-instruction-manual-071320.pdf?sfvrsn=4a65d267_1', 'Metabo HPT C10RJ(S) owner''s manual', 'manufacturer', '2026-10-03'),
  ('https://www.metabo-hpt.com/docs/default-source/product-parts-lists/c10rjs_e3_bd.pdf?sfvrsn=5c64e2db_1', 'Metabo HPT C10RJS E3 parts list', 'manufacturer', '2026-10-03'),
  ('https://www.metabo-hpt.com/support/parts', 'Metabo HPT official parts ordering page', 'manufacturer', '2026-10-03'),
  ('https://www.metabo-hpt.com/support/tool-repair-service', 'Metabo HPT factory repair service', 'manufacturer', '2026-10-03'),
  ('https://www.metabo-hpt.com/support/warranty-information/metabo-hpt-tool-warranty', 'Metabo HPT tool warranty terms', 'manufacturer', '2026-10-03'),
  ('https://www.reddit.com/r/Tools/comments/1prvy6b/how_do_i_even_fix_this_there_isnt_even_a_parts/', 'C10RJS owner report about a broken alignment bolt', 'owner-report', '2026-10-03'),
  ('https://www.amazon.com/dp/B086YHDYPW', 'Amazon exact Metabo HPT C10RJS destination', 'other', '2026-10-03'),
  ('https://www.acmetools.com/metabo-hpt-10in-jobsite-table-saw-with-fold-roll-stand-c10rjsm/717709027831.html', 'Acme Tools C10RJSM commercial corroboration', 'other', '2026-10-03');

INSERT INTO products (
  id, slug, brand, model, sku, category, category_group, variant_notes,
  evidence_tier, recommendation, recommendation_reasoning, last_reviewed_date
) VALUES (
  29,
  'metabo-hpt-c10rjs',
  'Metabo HPT',
  'C10RJS',
  'C10RJS',
  'table-saws',
  'tools-shop',
  'Metabo HPT catalogs the complete saw-and-stand package as C10RJS and displays C10RJ(S) on the product page and owner''s manual. U.S. retail corroboration identifies manufacturer part number C10RJSM and UPC 717709027831 for that package. The earlier C10RJ and international HiKOKI variants remain separate identities unless exact revision equivalence is documented.',
  'T2',
  'not-yet-verified',
  'Metabo HPT documentation establishes the exact C10RJS saw-and-fold-and-roll-stand package, owner cleaning and adjustment procedures, a detailed C10RJS E3 exploded parts list, an official parts-ordering path, factory repair support, and a two-year warranty. One exact-model owner report documents a broken alignment bolt and concern about finding parts but states no ownership duration. No qualifying exact-SKU duration evidence was verified, so expected service life and a buy or repair recommendation remain unverified.',
  '2026-10-03'
);

INSERT INTO product_sources
SELECT 29, id, 'exact identity, specifications, included stand and accessories, and two-year warranty statement' FROM sources WHERE url = 'https://metabo-hpt.com/products/product/c10rjs-10-jobsite-table-saw-w-fold-roll-stand-metabo-hpt';
INSERT INTO product_sources
SELECT 29, id, 'operation, adjustments, owner maintenance, troubleshooting, and authorized-service boundaries' FROM sources WHERE url = 'https://www.metabo-hpt.com/docs/default-source/product-owners-manuals/c10rj(s)-instruction-manual-071320.pdf?sfvrsn=4a65d267_1';
INSERT INTO product_sources
SELECT 29, id, 'exact C10RJS E3 exploded assemblies and component numbers' FROM sources WHERE url = 'https://www.metabo-hpt.com/docs/default-source/product-parts-lists/c10rjs_e3_bd.pdf?sfvrsn=5c64e2db_1';
INSERT INTO product_sources
SELECT 29, id, 'official OEM-parts ordering path' FROM sources WHERE url = 'https://www.metabo-hpt.com/support/parts';
INSERT INTO product_sources
SELECT 29, id, 'factory-trained repair support with genuine parts' FROM sources WHERE url = 'https://www.metabo-hpt.com/support/tool-repair-service';
INSERT INTO product_sources
SELECT 29, id, 'current limited-warranty conditions and exclusions' FROM sources WHERE url = 'https://www.metabo-hpt.com/support/warranty-information/metabo-hpt-tool-warranty';
INSERT INTO product_sources
SELECT 29, id, 'anecdotal exact-model failure and parts-discovery report without ownership duration' FROM sources WHERE url = 'https://www.reddit.com/r/Tools/comments/1prvy6b/how_do_i_even_fix_this_there_isnt_even_a_parts/';
INSERT INTO product_sources
SELECT 29, id, 'exact Amazon model-to-ASIN destination' FROM sources WHERE url = 'https://www.amazon.com/dp/B086YHDYPW';
INSERT INTO product_sources
SELECT 29, id, 'independent MPN, UPC, 120V configuration, and stand-package corroboration' FROM sources WHERE url = 'https://www.acmetools.com/metabo-hpt-10in-jobsite-table-saw-with-fold-roll-stand-c10rjsm/717709027831.html';

INSERT INTO product_fields (product_id, name, raw_value, display_value, evidence_tier, source_id, verified_date, reverify_days) VALUES
  (29, 'identity', 'Metabo HPT identifies C10RJS/C10RJ(S) as a 120V corded 10-inch jobsite table saw with a 15-amp, 4,500-RPM motor, 35-inch right and 22-inch left rip capacity, aluminum table, soft start, electric brake, overload protection, and included fold-and-roll stand. Acme Tools corroborates manufacturer part number C10RJSM and UPC 717709027831 for the U.S. package.', '120V, 15A 10-inch C10RJS jobsite table saw with included fold-and-roll stand and 35-inch right rip capacity.', 'T2', (SELECT id FROM sources WHERE url = 'https://metabo-hpt.com/products/product/c10rjs-10-jobsite-table-saw-w-fold-roll-stand-metabo-hpt'), '2026-10-03', 180),
  (29, 'warranty', 'The exact product page states a two-year warranty. Current Metabo HPT terms cover the eligible original purchaser for defects in materials and workmanship, require proof of purchase, and exclude normal wear, abuse, improper or missing maintenance, improper setup or adjustment, unauthorized repair or alteration, accidents, and nonconforming parts.', 'Two-year limited warranty for the eligible original purchaser; current Metabo HPT terms apply.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.metabo-hpt.com/support/warranty-information/metabo-hpt-tool-warranty'), '2026-10-03', 180),
  (29, 'repair_manual', 'Metabo HPT publishes the C10RJ(S) owner''s manual with setup, operation, adjustments, troubleshooting, cleaning, fastener inspection, guard checks, and lubrication guidance. It states that all service other than routine maintenance must be performed by an authorized Metabo HPT repair center, so it is not an owner repair manual.', 'Official owner''s manual covers maintenance and adjustments but is not an internal repair manual.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.metabo-hpt.com/docs/default-source/product-owners-manuals/c10rj(s)-instruction-manual-071320.pdf?sfvrsn=4a65d267_1'), '2026-10-03', 180),
  (29, 'parts_availability', 'Metabo HPT publishes an exact C10RJS E3 exploded parts list identifying components including the switch, motor rotor and stator, bearings, carbon brushes, power cord, fence, guards, table, and rolling-stand parts. Its official parts page routes owners to an OEM-parts search. Current orderability was not verified for individual C10RJS components.', 'Partial: an official exploded parts list identifies the switch, motor, carbon brushes, fence, guards, and stand components, but individual orderability remains unverified.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.metabo-hpt.com/docs/default-source/product-parts-lists/c10rjs_e3_bd.pdf?sfvrsn=5c64e2db_1'), '2026-10-03', 90),
  (29, 'serviceability', 'The owner''s manual documents owner cleaning, periodic fastener and table-insert inspection, blade-guard checks, alignment adjustments, and no-additional-lubrication guidance. It directs internal electrical or mechanical repairs and all service beyond routine maintenance to qualified technicians or an authorized repair center. Metabo HPT also offers factory-trained repair using genuine parts.', 'Shop-serviceable: owner cleaning, fastener and guard checks, and adjustments are documented; internal work is directed to authorized repair.', 'T2', (SELECT id FROM sources WHERE url = 'https://www.metabo-hpt.com/docs/default-source/product-owners-manuals/c10rj(s)-instruction-manual-071320.pdf?sfvrsn=4a65d267_1'), '2026-10-03', 180),
  (29, 'expected_service_life', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-03', 180),
  (29, 'street_price', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-03', 30),
  (29, 'annual_maintenance_cost', 'Not yet verified', 'Not yet verified', 'T4', NULL, '2026-10-03', 180);

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  29,
  'Two years from the original purchase date for the eligible C10RJS package.',
  'Original purchaser coverage against defects in materials and workmanship, subject to current terms and proof of purchase.',
  'Normal wear, abuse, operation contrary to the manual, improper or missing maintenance, improper setup or adjustment, unauthorized repair or alteration, accidents, and nonconforming parts are excluded under current terms.',
  (SELECT id FROM sources WHERE url = 'https://www.metabo-hpt.com/support/warranty-information/metabo-hpt-tool-warranty'),
  '2026-10-03'
);

INSERT INTO repairability (
  product_id, parts_availability, parts_url, repair_manual_available,
  repair_manual_url, serviceability, source_id, verified_date
) VALUES (
  29,
  'partial',
  'https://www.metabo-hpt.com/support/parts',
  0,
  'https://www.metabo-hpt.com/docs/default-source/product-owners-manuals/c10rj(s)-instruction-manual-071320.pdf?sfvrsn=4a65d267_1',
  'shop-serviceable',
  (SELECT id FROM sources WHERE url = 'https://www.metabo-hpt.com/docs/default-source/product-parts-lists/c10rjs_e3_bd.pdf?sfvrsn=5c64e2db_1'),
  '2026-10-03'
);

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date) VALUES
  (29, 'Amazon Associates', 'https://www.amazon.com/dp/B086YHDYPW?tag=everlastin08f-20', 1, '2026-10-03');

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '31');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-03');

COMMIT;
