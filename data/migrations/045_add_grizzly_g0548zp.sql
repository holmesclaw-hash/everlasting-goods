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
  40,
  'grizzly-g0548zp',
  'Grizzly',
  'G0548ZP',
  'G0548ZP',
  'dust-collectors',
  'tools-shop',
  'This exact record is the current U.S. G0548ZP single-stage collector with a 2 HP, 240V single-phase motor, one 6-inch main inlet, an adapter with three 4-inch ports, a 1-micron canister filter, and a 12-3/4-inch aluminum impeller. Post-2021 machines use revised inlet adapter P0548ZP029V2, so the machine manufacture date must be checked before ordering revision-specific parts. No specifications, parts claims, owner reports, or commercial identities are transferred from G0548Z, G0548, shared-manual siblings G1028Z2, G1029Z2, or G1029Z2P, Shop Fox W1666, South Bend SB1100, or other related collectors and revisions.',
  'T2',
  'not-yet-verified',
  'Official documentation establishes the exact current G0548ZP configuration, maintenance scope, revision-aware parts catalog, representative orderable motor, collector body, post-2021 inlet adapter, and compatible collection bags, one-year warranty, and manufacturer repair route. A 2020 owner reported only a few months of use, a 2013 new-unit filter problem ended with Grizzly sending a replacement canister, and a 2017 owner published a measured comparison without stating ownership duration. Expected service life, representative failure rate, repair economics, and a repair-versus-replace recommendation are not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; the accepted exact-model evidence includes a few months of ownership, a new-unit filter-support anecdote, and a dated hands-on measured comparison, none of which establishes representative service life.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-12',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (273, 'https://www.grizzly.com/products/grizzly-2-hp-canister-dust-collector-w-aluminum-impeller/g0548zp', 'Grizzly G0548ZP product page', 'manufacturer', '2026-10-12'),
  (274, 'https://cdn1.grizzly.com/specsheets/g0548zp_ds.pdf', 'Grizzly G0548ZP specification sheet', 'manufacturer', '2026-10-12'),
  (275, 'https://cdn0.grizzly.com/manuals/g0548zp_m.pdf', 'Grizzly G0548ZP owner manual and 2022 inlet-adapter update', 'manufacturer', '2026-10-12'),
  (276, 'https://www.grizzly.com/products/g0548zp/parts', 'Grizzly G0548ZP exact-model parts catalog', 'manufacturer', '2026-10-12'),
  (277, 'https://cdn0.grizzly.com/partslists/g0548zp_pl.pdf', 'Grizzly G0548ZP illustrated parts list', 'manufacturer', '2026-10-12'),
  (278, 'https://www.reddit.com/r/woodworking/comments/h03chl/dust_collector_grizzly_g0548zp_or_shop_fox_w1666/', 'Reddit G0548ZP owner report after a few months', 'owner-report', '2026-10-12'),
  (279, 'https://sawmillcreek.org/threads/grizzly-dust-collector-spewing-fine-dust.206845/', 'Sawmill Creek G0548ZP new-unit filter and support report', 'owner-report', '2026-10-12'),
  (280, 'https://davidmpeters.wordpress.com/2017/01/08/jet-jcdc-2-vs-grizzly-g0548zp-showdown/', 'Owner-measured G0548ZP and Jet comparison', 'owner-report', '2026-10-12'),
  (281, 'https://www.amazon.com/dp/B00DQJPBJ2', 'Amazon exact Grizzly G0548ZP destination', 'other', '2026-10-12'),
  (282, 'https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0548ZP&format=json', 'CPSC recall API query for G0548ZP', 'first-party', '2026-10-12'),
  (283, 'https://www.grizzly.com/parts/grizzly-motor-2hp-240v-1-ph/p0548zp017', 'Grizzly P0548ZP017 replacement motor', 'manufacturer', '2026-10-12'),
  (284, 'https://www.grizzly.com/parts/grizzly-inlet-adapter-6-x-4-x-3-pc-v2.01.22/p0548zp029v2', 'Grizzly P0548ZP029V2 revised inlet adapter', 'manufacturer', '2026-10-12'),
  (285, 'https://www.grizzly.com/products/grizzly-plastic-lower-bag-500mm-3-pack/t21821', 'Grizzly T21821 G0548ZP-compatible collection bags', 'manufacturer', '2026-10-12'),
  (286, 'https://www.grizzly.com/parts/grizzly-collector-body/p0548zp011', 'Grizzly P0548ZP011 collector body', 'manufacturer', '2026-10-12'),
  (287, 'https://www.grizzly.com/products/grizzly-extra-canister-for-g0548-z-g0562-z/h5783', 'Grizzly H5783 G0548ZP-compatible replacement canister', 'manufacturer', '2026-10-12'),
  (288, 'https://grizzly.com/products/grizzly-2hp-canister-dust-collector/g0548z', 'Grizzly discontinued G0548Z product page', 'manufacturer', '2026-10-12'),
  (289, 'https://www.grizzly.com/products/grizzly-2-hp-dust-collector-with-aluminum-impeller-polar-bear-series/g1029z2p', 'Grizzly G1029Z2P bag-filter product page', 'manufacturer', '2026-10-12'),
  (290, 'https://www.grizzly.com/products/shop-fox-2-hp-dust-collector/w1666', 'Shop Fox W1666 bag-filter product page', 'manufacturer', '2026-10-12'),
  (291, 'https://www.grizzly.com/products/south-bend-2-hp-canister-dust-collector/sb1100', 'South Bend SB1100 canister product page', 'manufacturer', '2026-10-12'),
  (292, 'https://grizzly.com/products/grizzly-2-hp-canister-dust-collector/g0548', 'Grizzly superseded G0548 product page', 'manufacturer', '2026-10-12');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (40, 273, 'exact identity, current configuration, current product status, and manufacturer support'),
  (40, 274, 'current electrical, construction, filtration, airflow, packaging, and warranty specifications'),
  (40, 275, 'exact-model inventory, revision boundary, maintenance, troubleshooting, wiring, parts, and service limits'),
  (40, 276, 'exact-model online parts catalog, manufacture-date revision cautions, and current ordering paths'),
  (40, 277, 'illustrated parts breakdown and component identities'),
  (40, 65, 'warranty duration, original-purchaser boundary, proof-of-purchase requirement, and exclusions'),
  (40, 251, 'manufacturer repair intake, technical support, paid repair route, and post-discontinuation parts policy'),
  (40, 278, 'bounded exact-model owner report after only a few months of use'),
  (40, 279, 'bounded new-unit filter problem and manufacturer replacement-support report'),
  (40, 280, 'bounded 2017 owner-measured comparison without stated ownership duration'),
  (40, 281, 'exact commercial destination'),
  (40, 255, 'manufacturer recall-page bounded search'),
  (40, 282, 'CPSC recall API exact-product-name query returned no records; no-match query is not safety clearance'),
  (40, 283, 'current exact-model replacement motor order page'),
  (40, 284, 'current post-2021 revision-specific inlet-adapter order page'),
  (40, 285, 'current G0548ZP-compatible replacement collection-bag order page'),
  (40, 286, 'current exact-model collector-body order page'),
  (40, 287, 'manufacturer replacement-canister identity and fit'),
  (40, 288, 'separate discontinued G0548Z identity'),
  (40, 289, 'separate G1029Z2P bag-filter identity'),
  (40, 290, 'separate Shop Fox W1666 bag-filter identity'),
  (40, 291, 'separate South Bend SB1100 canister identity'),
  (40, 292, 'separate superseded G0548 identity');

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
  (313, 40, 'identity', 'G0548ZP; single-stage; 2 HP; 240V; single-phase; one 6-inch inlet; three 4-inch adapter ports; 1-micron canister; 12-3/4-inch aluminum impeller', 'Exact current U.S. G0548ZP single-stage collector; 2 HP, 240V single-phase, with one 6-inch main inlet, an adapter with three 4-inch ports, a 1-micron canister filter, and a 12-3/4-inch aluminum impeller.', 'T1', 273, '2026-10-12', 180),
  (314, 40, 'parts_availability', 'partial', 'Partial: Grizzly publishes an exact-model catalog and illustrated list, with current order pages verified for the motor, collector body, post-2021 inlet adapter, and compatible collection bags; replacement-canister fit is documented, but canister and impeller orderability were not both independently confirmed.', 'T1', 276, '2026-10-12', 90),
  (315, 40, 'repair_manual', 'not-verified', 'The shared owner manual provides exact G0548ZP assembly, system-design, maintenance, troubleshooting, wiring, and illustrated-parts information, but it does not provide a comprehensive step-by-step internal repair manual.', 'T1', 275, '2026-10-12', 180),
  (316, 40, 'serviceability', 'shop-serviceable', 'Owners can clean or replace the canister and collection bag and use cataloged assemblies, while electrical work is reserved for qualified service personnel and Grizzly offers repair intake.', 'T1', 275, '2026-10-12', 180),
  (317, 40, 'warranty', '1-year limited warranty', 'One-year limited warranty for the original purchaser, subject to proof-of-purchase requirements and published exclusions.', 'T1', 65, '2026-10-12', 180),
  (318, 40, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-12', 90),
  (319, 40, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-12', 30),
  (320, 40, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-12', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  40,
  40,
  'Amazon Associates',
  'https://www.amazon.com/dp/B00DQJPBJ2?tag=everlastin08f-20',
  1,
  '2026-10-12'
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
  40,
  'partial',
  'https://www.grizzly.com/products/g0548zp/parts',
  0,
  'https://cdn0.grizzly.com/manuals/g0548zp_m.pdf',
  'shop-serviceable',
  NULL,
  276,
  '2026-10-12'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  40,
  '1 year limited warranty',
  'Grizzly house-brand products are warranted to the original purchaser for one year from purchase, with proof of purchase required.',
  'Published exclusions include misuse, abuse, negligence, accidents, unauthorized repairs, improper wiring, alterations, lack of maintenance, and consumable parts.',
  65,
  '2026-10-12'
);

UPDATE metadata SET value = '45' WHERE key = 'evidence_revision';
UPDATE metadata SET value = '2026-10-12' WHERE key = 'last_migrated_date';
UPDATE sources SET retrieved_date = '2026-10-12' WHERE id IN (65, 251, 255);
