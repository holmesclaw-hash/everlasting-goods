PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dcw600b/20v-max-xr-brushless-cordless-compact-router-tool-only', 'DEWALT DCW600B official product page', 'manufacturer', '2026-11-19'),
  ('https://www.toolservicenet.com/en/Dewalt/WOODWORKING/ROUTERS/p/DCW600B-CA_1', 'DEWALT ServiceNet DCW600B-CA Type 1 parts catalog', 'manufacturer', '2026-11-19'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Instruction_Manual/EN/NA115327_DCW600_JUL22.pdf', 'DEWALT DCW600 Type 1 instruction manual NA115327', 'manufacturer', '2026-11-19'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Exploded_Diagram/EN/EA025823.gif', 'DEWALT DCW600B Type 1 exploded diagram EA025823', 'manufacturer', '2026-11-19'),
  ('https://yo.asmbly.org/t/compact-router-broken-replacement/15448', 'Asmbly shared-shop DCW600 failure report', 'owner-report', '2026-11-19'),
  ('https://www.amazon.com/dp/B07KSRTDML', 'Amazon exact DEWALT DCW600B destination', 'other', '2026-11-19')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, purpose
FROM products p
JOIN (
  SELECT 'https://www.dewalt.com/en-us/product/dcw600b/20v-max-xr-brushless-cordless-compact-router-tool-only' AS url,
         'current exact-model identity, features, downloads, and product-specific warranty program' AS purpose
  UNION ALL SELECT 'https://www.toolservicenet.com/en/Dewalt/WOODWORKING/ROUTERS/p/DCW600B-CA_1',
         'current DCW600B-CA Type 1 parts catalog and stock snapshot'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Instruction_Manual/EN/NA115327_DCW600_JUL22.pdf',
         'Type 1 operating, maintenance, and service-routing instructions'
  UNION ALL SELECT 'https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Exploded_Diagram/EN/EA025823.gif',
         'Type 1 exploded diagram'
  UNION ALL SELECT 'https://yo.asmbly.org/t/compact-router-broken-replacement/15448',
         'bounded shared-shop duration and failure anecdote'
  UNION ALL SELECT 'https://www.amazon.com/dp/B07KSRTDML',
         'exact-model commercial destination'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'dewalt-dcw600b';

UPDATE products
SET recommendation_reasoning = 'DEWALT currently identifies DCW600B as the tool-only 20V MAX XR brushless compact router and publishes Type 1 instruction manuals plus exploded diagrams. The exact DCW600B-CA Type 1 ServiceNet catalog presented 46 service-part entries as in stock on 2026-11-19, but stock is volatile and the catalog does not establish support for every production revision. A shared-shop report describes a DCW600 believed to be more than five years old ending with a seized spindle and difficult disassembly. That single high-use anecdote is useful failure evidence, not representative lifespan data, so expected service life, failure rate, repair economics, and a buy-or-repair recommendation remain unverified.',
    last_reviewed_date = '2026-11-19'
WHERE slug = 'dewalt-dcw600b';

UPDATE product_fields
SET raw_value = 'DEWALT identifies DCW600B as the tool-only 20V MAX XR brushless cordless compact router with a fixed base and wrench.',
    display_value = 'DCW600B 20V MAX XR brushless cordless compact router, tool only, with fixed base and wrench.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcw600b/20v-max-xr-brushless-cordless-compact-router-tool-only'),
    verified_date = '2026-11-19',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact DCW600B-CA Type 1 ServiceNet page presented 46 service-part entries as in stock on 2026-11-19 and linked the Type 1 exploded diagram. Stock can change, and this snapshot does not prove continued availability or coverage for every production revision.',
    display_value = 'Partial: the exact Type 1 catalog showed 46 in-stock service-part entries on 2026-11-19; continued stock and every production revision are not guaranteed.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en/Dewalt/WOODWORKING/ROUTERS/p/DCW600B-CA_1'),
    verified_date = '2026-11-19',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'DEWALT publishes the NA115327 Type 1 instruction manual. It covers operation, bit and collet handling, base and depth adjustment, cleaning, and routing repairs through DEWALT service, but it is not a component-level repair manual.',
    display_value = 'Official Type 1 operating and maintenance manual; it is not a component-level repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Instruction_Manual/EN/NA115327_DCW600_JUL22.pdf'),
    verified_date = '2026-11-19',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The owner documentation supports bit, collet, fixed-base, depth-adjustment, and cleaning tasks. The Type 1 catalog and exploded diagram support part identification, while internal repair is routed to DEWALT factory or authorized service.',
    display_value = 'Owner-serviceable for bit, collet, base, depth-adjustment, and cleaning tasks; internal repair is routed to authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Instruction_Manual/EN/NA115327_DCW600_JUL22.pdf'),
    verified_date = '2026-11-19',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'The exact DCW600B product page publishes a 3-year limited warranty, 1 year of free service, and a 90-day satisfaction guarantee. Eligibility and current claim terms must be confirmed with DEWALT.',
    display_value = '3-year limited warranty, 1 year free service, and 90-day satisfaction guarantee; current DEWALT eligibility and claim terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.dewalt.com/en-us/product/dcw600b/20v-max-xr-brushless-cordless-compact-router-tool-only'),
    verified_date = '2026-11-19',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-19',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b')
  AND name = 'expected_service_life';

UPDATE product_fields
SET verified_date = '2026-11-19',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.toolservicenet.com/en/Dewalt/WOODWORKING/ROUTERS/p/DCW600B-CA_1',
    repair_manual_available = 0,
    repair_manual_url = 'https://assets.dewalt.com/GLOBALBOM/QU/DCW600B/1/Instruction_Manual/EN/NA115327_DCW600_JUL22.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.toolservicenet.com/en/Dewalt/WOODWORKING/ROUTERS/p/DCW600B-CA_1'),
    verified_date = '2026-11-19'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b');

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
)
SELECT
  p.id,
  '3-year limited warranty; 1 year free service; 90-day satisfaction guarantee',
  'The exact DCW600B product page publishes DEWALT''s 3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee program.',
  'Eligibility, exclusions, claim requirements, and current terms must be confirmed with DEWALT for the purchaser and use case.',
  s.id,
  '2026-11-19'
FROM products p
JOIN sources s ON s.url = 'https://www.dewalt.com/en-us/product/dcw600b/20v-max-xr-brushless-cordless-compact-router-tool-only'
WHERE p.slug = 'dewalt-dcw600b'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-19'
WHERE product_id = (SELECT id FROM products WHERE slug = 'dewalt-dcw600b')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B07KSRTDML?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '66');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-19');

COMMIT;
