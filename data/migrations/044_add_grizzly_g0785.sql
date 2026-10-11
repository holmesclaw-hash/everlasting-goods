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
  39,
  'grizzly-g0785',
  'Grizzly',
  'G0785',
  'G0785',
  'dust-collectors',
  'tools-shop',
  'This exact record is the current U.S. G0785 single-stage wall-mount configuration with a 1 HP, 120V/240V single-phase motor, one 4-inch inlet, 1-micron canister filter, and lower collection bag. No specifications, parts claims, owner reports, or commercial identities are transferred from G0785Z, the higher-capacity G0944 or G0944HEP, Shop Fox W1844, or other related collectors and revisions.',
  'T2',
  'not-yet-verified',
  'Official documentation establishes the exact current G0785 configuration, maintenance scope, exact-model illustrated parts catalog, representative orderable motor, impeller, canister-filter, and collection-bag parts, one-year warranty, and manufacturer repair route. A 2020 independent hands-on test reported good suction and chip capacity and very good bag emptying but no ownership duration. A separate exact-model owner said the unit had difficulty keeping up with a planer and jointer but supplied no ownership duration. Expected service life, representative failure rate, repair economics, and a repair-versus-replace recommendation are not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; the accepted exact-model evidence includes a bounded 2020 hands-on test and an owner performance anecdote, neither of which establishes representative service life.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-11',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (259, 'https://www.grizzly.com/products/grizzly-1-hp-wall-mount-dust-collector-with-canister-filter/g0785', 'Grizzly G0785 product page', 'manufacturer', '2026-10-11'),
  (260, 'https://cdn0.grizzly.com/specsheets/g0785_ds.pdf', 'Grizzly G0785 specification sheet', 'manufacturer', '2026-10-11'),
  (261, 'https://cdn0.grizzly.com/manuals/g0785_m.pdf', 'Grizzly G0785 owner manual', 'manufacturer', '2026-10-11'),
  (262, 'https://www.grizzly.com/products/g0785/parts', 'Grizzly G0785 exact-model parts catalog', 'manufacturer', '2026-10-11'),
  (263, 'https://cdn0.grizzly.com/partslists/g0785_pl.pdf', 'Grizzly G0785 illustrated parts list', 'manufacturer', '2026-10-11'),
  (264, 'https://www.finewoodworking.com/project-guides/shop-machines/tool-test-wall-mounted-dust-collectors', 'Fine Woodworking wall-mounted dust collector test including G0785', 'owner-report', '2026-10-11'),
  (265, 'https://www.reddit.com/r/woodworking/comments/1n2x91e/is_a_dedicated_dust_collection_set_up_worth_it/', 'Reddit exact-model G0785 owner performance report', 'owner-report', '2026-10-11'),
  (266, 'https://www.amazon.com/dp/B083JQWX18', 'Amazon exact Grizzly G0785 destination', 'other', '2026-10-11'),
  (268, 'https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0785&format=json', 'CPSC recall API query for G0785', 'first-party', '2026-10-11'),
  (269, 'https://www.grizzly.com/parts/grizzly-canister-filter/p0785001', 'Grizzly P0785001 replacement canister filter', 'manufacturer', '2026-10-11'),
  (270, 'https://www.grizzly.com/products/grizzly-dust-collection-bag-for-g0785-and-g0944-series-3-pk./t21820', 'Grizzly T21820 replacement collection bags for G0785 and G0944 series', 'manufacturer', '2026-10-11'),
  (271, 'https://www.grizzly.com/parts/grizzly-motor-1hp-120-240v-1-ph/p0785010', 'Grizzly P0785010 replacement motor', 'manufacturer', '2026-10-11'),
  (272, 'https://www.grizzly.com/parts/grizzly-aluminium-impeller-10/p0785009', 'Grizzly P0785009 replacement impeller', 'manufacturer', '2026-10-11');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (39, 259, 'exact identity, current U.S. product status, configuration, and manufacturer support'),
  (39, 260, 'exact current configuration, electrical specification, package contents, construction, and warranty summary'),
  (39, 261, 'operation, maintenance, troubleshooting, wiring, impeller-tightening procedure, and service boundaries'),
  (39, 262, 'exact-model online parts catalog, revision cautions, and ordering path'),
  (39, 263, 'illustrated parts breakdown and component identities'),
  (39, 65, 'warranty duration, original-purchaser boundary, proof-of-purchase requirement, and exclusions'),
  (39, 251, 'manufacturer repair intake, technical support, paid repair route, and post-discontinuation parts policy'),
  (39, 264, 'bounded 2020 independent exact-model performance test without ownership duration'),
  (39, 265, 'bounded exact-model owner report about planer and jointer performance without ownership duration'),
  (39, 266, 'exact commercial destination'),
  (39, 255, 'manufacturer recall-page bounded search'),
  (39, 268, 'CPSC recall API exact-product-name query returned no records; no-match query is not safety clearance'),
  (39, 269, 'exact-model replacement canister filter order page'),
  (39, 270, 'current exact-model compatible replacement collection-bag order page'),
  (39, 271, 'exact-model replacement motor order page'),
  (39, 272, 'exact-model replacement impeller order page');

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
  (305, 39, 'identity', 'G0785; wall-mount; single-stage; 1 HP; 120V/240V; single-phase; one 4-inch inlet; 1-micron canister; collection bag', 'Exact current U.S. G0785 wall-mount single-stage collector; 1 HP, 120V/240V single-phase, with one 4-inch inlet, 1-micron canister filter, and lower collection bag.', 'T1', 259, '2026-10-11', 180),
  (306, 39, 'parts_availability', 'partial', 'Partial: Grizzly publishes an exact-model catalog and illustrated list, with current order pages verified for the motor, impeller, canister filter, and collection bags; not every listed component was independently confirmed orderable.', 'T1', 262, '2026-10-11', 90),
  (307, 39, 'repair_manual', 'not-verified', 'The owner manual covers maintenance, troubleshooting, wiring, illustrated parts, and one impeller-tightening procedure, but it does not provide a comprehensive step-by-step internal repair manual.', 'T1', 261, '2026-10-11', 180),
  (308, 39, 'serviceability', 'shop-serviceable', 'Owners can clean or replace the canister filter and collection bag and follow the documented impeller-tightening procedure; electrical work is reserved for a qualified electrician or service personnel, and Grizzly offers repair intake.', 'T1', 261, '2026-10-11', 180),
  (309, 39, 'warranty', '1-year limited warranty', 'One-year limited warranty for the original purchaser, subject to proof-of-purchase requirements and published exclusions.', 'T1', 65, '2026-10-11', 180),
  (310, 39, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-11', 90),
  (311, 39, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-11', 30),
  (312, 39, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-11', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  39,
  39,
  'Amazon Associates',
  'https://www.amazon.com/dp/B083JQWX18?tag=everlastin08f-20',
  1,
  '2026-10-11'
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
  39,
  'partial',
  'https://www.grizzly.com/products/g0785/parts',
  0,
  'https://cdn0.grizzly.com/manuals/g0785_m.pdf',
  'shop-serviceable',
  NULL,
  262,
  '2026-10-11'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  39,
  '1 year limited warranty',
  'Grizzly house-brand products are warranted to the original purchaser for one year from purchase, with proof of purchase required.',
  'Published exclusions include misuse, abuse, negligence, accidents, unauthorized repairs, improper wiring, alterations, lack of maintenance, and consumable parts.',
  65,
  '2026-10-11'
);

UPDATE metadata SET value = '44' WHERE key = 'evidence_revision';
UPDATE metadata SET value = '2026-10-11' WHERE key = 'last_migrated_date';
UPDATE sources SET retrieved_date = '2026-10-11' WHERE id IN (65, 251, 255);
