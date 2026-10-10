PRAGMA foreign_keys = ON;

INSERT INTO products (
  id,
  slug,
  brand,
  model,
  sku,
  category,
  category_group,
  variant_notes,
  evidence_tier,
  recommendation,
  recommendation_reasoning,
  street_price_cents,
  price_verified_date,
  expected_service_life_years,
  expected_service_life_basis,
  annual_maintenance_cost_cents,
  image_url,
  image_source_url,
  image_license_basis,
  last_reviewed_date,
  image_license_url,
  image_attribution,
  image_alt
) VALUES (
  38,
  'grizzly-g0860',
  'Grizzly',
  'G0860',
  'G0860',
  'dust-collectors',
  'tools-shop',
  'This exact record is the current U.S. G0860 portable two-stage cyclone configuration with a 1-1/2 HP, 110V single-phase 15A motor, 20-gallon collection drum, 6-inch inlet, and included two-port 4-inch adapter. The related G0861 is a 2 HP, 220V machine and the G0862 is a 3 HP, 220V machine; their specifications, parts, ownership reports, and commercial identities are not transferred to G0860.',
  'T2',
  'not-yet-verified',
  'Official documentation establishes the exact current G0860 configuration, replaceable filter, exact-model illustrated parts catalog, maintenance and troubleshooting scope, one-year warranty, and manufacturer repair route. Owner evidence is mixed and anecdotal: a 2021 hands-on reviewer bought the test unit but reported no ownership duration, while a 2020 owner reported startup and electrical problems after roughly one year. Expected service life, representative failure rate, repair economics, and a repair-versus-replace recommendation are not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; the accepted exact-model owner reports are mixed anecdotes and do not establish a representative lifespan.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-10',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (247, 'https://www.grizzly.com/products/grizzly-1-1-2-hp-portable-cyclone-dust-collector/g0860', 'Grizzly G0860 product page', 'manufacturer', '2026-10-10'),
  (248, 'https://cdn0.grizzly.com/manuals/g0860_m.pdf', 'Grizzly G0860/G0861/G0862 owner manual and G0860/G0861 update', 'manufacturer', '2026-10-10'),
  (249, 'https://www.grizzly.com/products/g0860/parts', 'Grizzly G0860 exact-model parts catalog', 'manufacturer', '2026-10-10'),
  (250, 'https://cdn0.grizzly.com/partslists/g0860_pl.pdf', 'Grizzly G0860 illustrated parts list', 'manufacturer', '2026-10-10'),
  (251, 'https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item', 'Grizzly repair-service policy', 'manufacturer', '2026-10-10'),
  (252, 'https://www.finewoodworking.com/2021/01/12/tool-review-grizzly-g0860-dust-collector', 'Fine Woodworking hands-on Grizzly G0860 review', 'owner-report', '2026-10-10'),
  (253, 'https://www.lumberjocks.com/threads/dc-question.309661/', 'LumberJocks G0860 owner startup and service report', 'owner-report', '2026-10-10'),
  (254, 'https://www.amazon.com/dp/B07K1YTJZD', 'Amazon exact Grizzly G0860 destination', 'other', '2026-10-10'),
  (255, 'https://www.grizzly.com/recalls', 'Grizzly recalled-items page', 'manufacturer', '2026-10-10'),
  (256, 'https://www.cpsc.gov/Recalls?search_combined_fields=G0860', 'CPSC recalls search for G0860', 'first-party', '2026-10-10'),
  (257, 'https://www.grizzly.com/products/grizzly-replacement-filter-for-g0860-g0861/t30314', 'Grizzly T30314 replacement filter for G0860 and G0861', 'manufacturer', '2026-10-10'),
  (258, 'https://cdn0.grizzly.com/specsheets/g0860_ds.pdf', 'Grizzly G0860 data sheet', 'manufacturer', '2026-10-10');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (38, 247, 'exact identity, current U.S. configuration, included equipment, and manufacturer status'),
  (38, 248, 'operation, maintenance, troubleshooting, electrical boundaries, wiring, and service procedures'),
  (38, 249, 'exact-model online parts catalog and ordering path'),
  (38, 250, 'illustrated parts breakdown and availability limitation'),
  (38, 65, 'warranty duration, coverage, purchaser boundary, and exclusions'),
  (38, 251, 'manufacturer repair intake and paid-service route'),
  (38, 252, 'bounded positive hands-on evidence without long-term duration'),
  (38, 253, 'bounded negative exact-model owner report after roughly one year'),
  (38, 254, 'exact commercial destination'),
  (38, 255, 'manufacturer recall-page bounded search'),
  (38, 256, 'CPSC model-number recall-search lead; no-match search is not safety clearance'),
  (38, 257, 'exact-model replacement canister filter'),
  (38, 258, 'exact-model manufacturer specifications');

INSERT INTO product_fields (
  id,
  product_id,
  name,
  raw_value,
  display_value,
  evidence_tier,
  source_id,
  verified_date,
  reverify_days
) VALUES
  (297, 38, 'identity', 'G0860; 1-1/2 HP; 110V; single-phase; 15A; 20-gallon drum; 6-inch inlet; two 4-inch adapter ports', 'Exact U.S. G0860 portable two-stage cyclone dust collector; 1-1/2 HP, 110V single-phase, 15A, with 20-gallon collection drum.', 'T1', 247, '2026-10-10', 180),
  (298, 38, 'parts_availability', 'partial', 'Partial: Grizzly publishes an exact-model online parts catalog and illustrated list plus order pages for the replacement filter and major assemblies; the parts list says availability is not guaranteed.', 'T1', 249, '2026-10-10', 90),
  (299, 38, 'repair_manual', 'not-verified', 'The owner manual covers maintenance, filter and collection-bag procedures, troubleshooting, wiring diagrams, and illustrated parts, but it does not provide step-by-step internal repair procedures.', 'T1', 248, '2026-10-10', 180),
  (300, 38, 'serviceability', 'shop-serviceable', 'Owners can clean or replace the filter and collection bags and perform documented maintenance; internal electrical diagnosis or repair requires a qualified person, with Grizzly offering repair intake.', 'T1', 248, '2026-10-10', 180),
  (301, 38, 'warranty', '1-year limited warranty', 'One-year limited warranty for the original purchaser, subject to proof-of-purchase requirements and published exclusions.', 'T1', 65, '2026-10-10', 180),
  (302, 38, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-10', 90),
  (303, 38, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-10', 30),
  (304, 38, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-10', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  38,
  38,
  'Amazon Associates',
  'https://www.amazon.com/dp/B07K1YTJZD?tag=everlastin08f-20',
  1,
  '2026-10-10'
);

INSERT INTO repairability (
  product_id,
  parts_availability,
  parts_url,
  repair_manual_available,
  repair_manual_url,
  serviceability,
  ifixit_score,
  source_id,
  verified_date
) VALUES (
  38,
  'partial',
  'https://www.grizzly.com/products/g0860/parts',
  0,
  'https://cdn0.grizzly.com/manuals/g0860_m.pdf',
  'shop-serviceable',
  NULL,
  249,
  '2026-10-10'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  38,
  '1 year limited warranty',
  'Grizzly-manufactured products are warranted to the original purchaser for one year from purchase or shipment against defects in material and workmanship, with proof of purchase required.',
  'Published exclusions include unauthorized repair or alteration, misuse, abuse, negligence, accidents, improper conditions, lack of maintenance, damage caused by non-Grizzly parts, normal wear, and consumable parts.',
  65,
  '2026-10-10'
);

UPDATE metadata SET value = '43' WHERE key = 'evidence_revision';
UPDATE metadata SET value = '2026-10-10' WHERE key = 'last_migrated_date';
UPDATE sources SET retrieved_date = '2026-10-10' WHERE id = 65;
