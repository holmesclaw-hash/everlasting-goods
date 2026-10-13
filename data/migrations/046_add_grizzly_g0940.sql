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
  41,
  'grizzly-g0940',
  'Grizzly',
  'G0940',
  'G0940',
  'benchtop-planers',
  'tools-shop',
  'This exact record is the current U.S. G0940 13-inch benchtop planer with a 2 HP, 120V single-phase 15A motor, a two-row helical cutterhead carrying 30 H9893-compatible 15 x 15 x 2.5 mm carbide inserts, and a granite table. The downloadable V3 manual and parts list cover machines manufactured since 03/25, while the parts catalog identifies a separate V4 manual for machines manufactured 10/25 and later. The manufacture date and serial number must be checked before applying revision-specific instructions or ordering parts. No specifications, parts claims, owner reports, recall status, or commercial identities are transferred from G0939, G0505, G0959, G0999, recalled G0815, Shop Fox W1877, or other related planers and revisions.',
  'T2',
  'not-yet-verified',
  'Official documentation establishes the exact current G0940 configuration, revision-aware parts catalog, consumable inserts, representative order pages, substantial owner maintenance, one advanced cutterhead-bearing procedure, a one-year warranty, and manufacturer repair intake. Accepted owner evidence remains anecdotal: one scratch-and-dent machine required substantial initial alignment before the owner reported a good surface finish, and another buyer reported three successive units damaged during shipping. Neither report establishes representative operating life. Expected service life, population failure rate, repair economics, and a repair-versus-replace recommendation are not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; accepted exact-model evidence covers one scratch-and-dent unit and a separate shipping-damage sequence, not representative multi-year operating life.',
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
  (293, 'https://www.grizzly.com/products/grizzly-13-2-hp-benchtop-planer-w-helical-cutterhead/g0940', 'Grizzly G0940 product page', 'manufacturer', '2026-10-12'),
  (294, 'https://cdn0.grizzly.com/specsheets/g0940_ds.pdf', 'Grizzly G0940 specification sheet dated May 4, 2026', 'manufacturer', '2026-10-12'),
  (295, 'https://cdn0.grizzly.com/manuals/g0940_m.pdf', 'Grizzly G0939/G0940 V3 owner manual for machines manufactured since March 2025', 'manufacturer', '2026-10-12'),
  (296, 'https://www.grizzly.com/products/g0940/parts', 'Grizzly G0940 exact-model parts and manuals catalog', 'manufacturer', '2026-10-12'),
  (297, 'https://cdn0.grizzly.com/partslists/g0940_pl.pdf', 'Grizzly G0940 V3 illustrated parts list', 'manufacturer', '2026-10-12'),
  (298, 'https://support.grizzly.com/hc/en-us/articles/34323368216983-FAQ-G0940-13-2-HP-Benchtop-Planer-w-Helical-Cutterhead', 'Grizzly G0940 exact-model FAQ', 'manufacturer', '2026-10-12'),
  (299, 'https://support.grizzly.com/hc/en-us/articles/41752518807191-G0940-Planer-Cutterhead-Bearing-Replacement', 'Grizzly G0940 advanced cutterhead-bearing replacement procedure', 'manufacturer', '2026-10-12'),
  (300, 'https://support.grizzly.com/hc/en-us/articles/39161065351319-Which-Knives-Inserts-or-Cutterhead-Upgrades-Fit-My-Jointer-or-Planer', 'Grizzly planer insert compatibility guide', 'manufacturer', '2026-10-12'),
  (301, 'https://support.grizzly.com/hc/en-us/articles/4405505042839-How-can-I-purchase-parts', 'Grizzly replacement-parts ordering and availability policy', 'manufacturer', '2026-10-12'),
  (302, 'https://www.grizzly.com/parts/grizzly-carbon-brush-2-pk/p0940135', 'Grizzly G0940 carbon-brush supersession page', 'manufacturer', '2026-10-12'),
  (303, 'https://www.grizzly.com/parts/grizzly-poly-v-belt-135j/p0940111', 'Grizzly G0940 Poly-V belt supersession page', 'manufacturer', '2026-10-12'),
  (304, 'https://www.grizzly.com/parts/grizzly-cutterhead-13-helical/p0940129', 'Grizzly P0940129 G0940 helical cutterhead order page', 'manufacturer', '2026-10-12'),
  (305, 'https://www.grizzly.com/products/grizzly-indexable-carbide-insert-15-x-15-x-2.5mm-10-pk./h9893', 'Grizzly H9893 G0940-compatible carbide inserts', 'manufacturer', '2026-10-12'),
  (306, 'https://www.grizzly.com/parts/grizzly-manual-g0939-g0940-mfd-10.25-v4.10.25/p0939manv4', 'Grizzly G0939/G0940 V4 manual listing for machines manufactured October 2025 and later', 'manufacturer', '2026-10-12'),
  (307, 'https://forestryforum.com/board?topic=123522.0', 'Forestry Forum G0940 scratch-and-dent owner adjustment report', 'owner-report', '2026-10-12'),
  (308, 'https://sawmillcreek.org/threads/in-search-of-a-benchtop-wood-planer.295150/', 'Sawmill Creek G0940 shipping-damage owner report', 'owner-report', '2026-10-12'),
  (309, 'https://www.amazon.com/dp/B0BBKQ4W6S', 'Amazon exact Grizzly G0940 destination', 'other', '2026-10-12'),
  (310, 'https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0940&format=json', 'CPSC recall API query for G0940', 'first-party', '2026-10-12'),
  (311, 'https://www.cpsc.gov/Recalls/2026/Grizzly-Industrial-Recalls-Heavy-Duty-Planers-Due-to-Impact-and-Laceration-Hazards', 'CPSC recall notice for separate Grizzly G0815 planer', 'first-party', '2026-10-12'),
  (312, 'https://www.grizzly.com/products/grizzly-13-2-hp-benchtop-planer/g0939', 'Grizzly G0939 straight-knife product page', 'manufacturer', '2026-10-12'),
  (313, 'https://www.grizzly.com/products/grizzly-12-1-2-2-hp-benchtop-planer/g0505', 'Grizzly G0505 product page', 'manufacturer', '2026-10-12'),
  (314, 'https://grizzly.com/products/grizzly-12-combo-planer-jointer/g0959', 'Grizzly G0959 combination planer-jointer product page', 'manufacturer', '2026-10-12'),
  (315, 'https://grizzly.com/products/grizzly-15-2-hp-benchtop-planer-with-spiral-cutterhead/g0999', 'Grizzly G0999 15-inch spiral-cutterhead planer product page', 'manufacturer', '2026-10-12'),
  (316, 'https://www.grizzly.com/products/shop-fox-13-benchtop-planer-w-spiral-type-cutterhead/w1877', 'Shop Fox W1877 spiral-type-cutterhead planer product page', 'manufacturer', '2026-10-12');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (41, 293, 'exact current identity, configuration, capacity, product status, and support route'),
  (41, 294, 'current electrical, cutterhead, capacity, construction, packaging, and warranty specifications'),
  (41, 295, 'V3 revision scope, assembly, maintenance, troubleshooting, component replacement, calibration, wiring, and safety limits'),
  (41, 296, 'exact-model revision-aware online parts and manuals catalog'),
  (41, 297, 'V3 illustrated parts breakdown and explicit parts-availability limitation'),
  (41, 298, 'current exact-model design, voltage, insert, and configuration FAQ'),
  (41, 299, 'advanced exact-model cutterhead-bearing replacement procedure'),
  (41, 300, 'G0940 compatibility with thirty H9893 inserts'),
  (41, 301, 'manufacturer parts-ordering, supersession, and availability boundaries'),
  (41, 65, 'warranty duration, original-purchaser boundary, proof-of-purchase requirement, and exclusions'),
  (41, 251, 'manufacturer repair intake, technical support, paid repair route, and post-discontinuation parts policy'),
  (41, 302, 'direct replacement-brush supersession page'),
  (41, 303, 'direct replacement-belt supersession page'),
  (41, 304, 'direct exact-model helical-cutterhead order page'),
  (41, 305, 'current G0940-compatible replacement-insert order page'),
  (41, 306, 'separate V4 manual identity for machines manufactured October 2025 and later'),
  (41, 307, 'bounded scratch-and-dent unit adjustment and finish report'),
  (41, 308, 'bounded three-unit shipping-damage and support report'),
  (41, 309, 'exact commercial destination'),
  (41, 255, 'manufacturer recall-page bounded search'),
  (41, 310, 'CPSC recall API exact-product-name query returned no records; no-match query is not safety clearance'),
  (41, 311, 'separate G0815 recall boundary'),
  (41, 312, 'separate G0939 straight-knife identity'),
  (41, 313, 'separate G0505 planer identity'),
  (41, 314, 'separate G0959 combination-machine identity'),
  (41, 315, 'separate G0999 15-inch spiral-cutterhead identity'),
  (41, 316, 'separate Shop Fox W1877 identity');

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
  (321, 41, 'identity', 'G0940; 13-inch; 2 HP; 120V; single-phase; 15A; two-row helical cutterhead; 30 inserts; granite table', 'Exact current U.S. G0940 13-inch benchtop planer; 2 HP, 120V single-phase, 15A, with a two-row helical cutterhead carrying 30 four-edge 15 x 15 x 2.5 mm carbide inserts and a granite table.', 'T1', 293, '2026-10-12', 180),
  (322, 41, 'parts_availability', 'partial', 'Partial: Grizzly publishes an exact-model revision-aware catalog and illustrated list, with direct pages for H9893 inserts, superseded brushes and belt, and the complete helical cutterhead; present purchase information is mixed for major assemblies including the motor and feed rollers, and the parts list disclaims guaranteed availability.', 'T1', 296, '2026-10-12', 90),
  (323, 41, 'repair_manual', 'not-comprehensive', 'The V3 owner manual covers insert rotation, motor-brush and belt replacement, pinion-gear replacement, lubrication, troubleshooting, and calibration, and Grizzly separately publishes an advanced cutterhead-bearing procedure; these resources do not form a comprehensive internal repair manual for every subsystem or revision.', 'T1', 295, '2026-10-12', 180),
  (324, 41, 'serviceability', 'shop-serviceable', 'Owners can rotate or replace individual inserts and service brushes and the belt; the documented bearing procedure is advanced, revision-specific work requires manufacture-date checks, and electrical repair remains qualified-service work.', 'T1', 299, '2026-10-12', 180),
  (325, 41, 'warranty', '1-year limited warranty', 'One-year limited warranty for the original purchaser, subject to proof-of-purchase requirements and published exclusions.', 'T1', 65, '2026-10-12', 180),
  (326, 41, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-12', 90),
  (327, 41, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-12', 30),
  (328, 41, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-12', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  41,
  41,
  'Amazon Associates',
  'https://www.amazon.com/dp/B0BBKQ4W6S?tag=everlastin08f-20',
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
  41,
  'partial',
  'https://www.grizzly.com/products/g0940/parts',
  0,
  'https://cdn0.grizzly.com/manuals/g0940_m.pdf',
  'shop-serviceable',
  NULL,
  296,
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
  41,
  '1 year limited warranty',
  'Grizzly house-brand products are warranted to the original purchaser for one year from purchase, with proof of purchase required.',
  'Published exclusions include misuse, abuse, negligence, accidents, unauthorized repairs, improper wiring, alterations, lack of maintenance, and consumable parts.',
  65,
  '2026-10-12'
);

UPDATE metadata SET value = '46' WHERE key = 'evidence_revision';
UPDATE metadata SET value = '2026-10-12' WHERE key = 'last_migrated_date';
UPDATE sources SET retrieved_date = '2026-10-12' WHERE id IN (65, 251, 255);
