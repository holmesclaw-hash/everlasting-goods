PRAGMA foreign_keys = ON;
BEGIN;

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
  45,
  'grizzly-g1021z',
  'Grizzly',
  'G1021Z',
  'G1021Z',
  'stationary-planers',
  'tools-shop',
  'This exact record is for the current U.S. G1021Z 15-inch stationary planer with a 3 HP, 230V single-phase 12A motor, three-knife cutterhead, and cabinet stand. Grizzly publishes manufacture-date-specific manual versions covering 01/00 through 04/20 and later; owners must use the manufacture date on the machine ID label to select the matching manual version and compatible parts. The current specification sheet lists 12A and 474 pounds, while the current manual''s illustrated machine label lists 15A and 507 pounds; this official-document conflict is preserved rather than silently reconciled. Specifications, parts, owner reports, recall status, and commercial identity are not transferred from the spiral-cutterhead G1021X2, historical G1021, G0453Z, recalled G0815, or other related planers and manufacturing revisions.',
  'T2',
  'not-yet-verified',
  'One exact-model owner reported purchasing a G1021Z in 2005, using it primarily outdoors for 15 years, then replacing rust-damaged or missing parts and several bearings during a rebuild before installing a helical cutterhead. Another owner reported a used G1021Z was reliable through heavy hobby loads during two years of ownership. The first machine''s later upgraded configuration is not treated as stock G1021Z evidence. These are individual anecdotes, not representative durability data; expected service life, representative failure rate, repair economics, and a repair-versus-replace recommendation are not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; individual exact-model reports cover two years of reliable use and a 15-year machine later rebuilt and modified, but they do not establish representative G1021Z service life.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-15',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (359, 'https://www.grizzly.com/products/grizzly-15-3-hp-planer-with-cabinet-stand/g1021z', 'Grizzly G1021Z official product page', 'manufacturer', '2026-10-15'),
  (360, 'https://cdn0.grizzly.com/specsheets/g1021z_ds.pdf', 'Grizzly G1021Z current specification sheet', 'manufacturer', '2026-10-15'),
  (361, 'https://cdn0.grizzly.com/manuals/g1021z_m.pdf', 'Grizzly G1021X2 and G1021Z owner manual V5.04.21', 'manufacturer', '2026-10-15'),
  (362, 'https://www.grizzly.com/products/g1021z/parts', 'Grizzly G1021Z revision-aware online parts catalog and manual index', 'manufacturer', '2026-10-15'),
  (363, 'https://cdn0.grizzly.com/partslists/g1021z_pl.pdf', 'Grizzly G1021Z illustrated parts list for machines manufactured since November 2020', 'manufacturer', '2026-10-15'),
  (364, 'https://www.grizzly.com/parts/P1021Z016V2', 'Grizzly G1021Z V2 motor part and current supersession', 'manufacturer', '2026-10-15'),
  (365, 'https://www.grizzly.com/parts/P1021Z040V2', 'Grizzly G1021Z V2 magnetic switch assembly part page', 'manufacturer', '2026-10-15'),
  (366, 'https://www.grizzly.com/parts/P1021Z170', 'Grizzly G1021Z planer knives and current G6701 supersession', 'manufacturer', '2026-10-15'),
  (367, 'https://www.grizzly.com/parts/P1021Z109AV2', 'Grizzly G1021Z V2 gearbox assembly part page', 'manufacturer', '2026-10-15'),
  (368, 'https://www.woodworkingtalk.com/threads/grizzly-g1021z-planer-rebuild-helical-cutter-install-and-other-upgrades.221945/', 'WoodworkingTalk 2005 G1021Z purchase, 15-year outdoor-use history, rebuild, and later modification report', 'owner-report', '2026-10-15'),
  (369, 'https://sawmillcreek.org/threads/grizzly-g1021-planer-opinions-please.219189/', 'Sawmill Creek two-year used G1021Z reliability report and separate G1021 discussion', 'owner-report', '2026-10-15'),
  (370, 'https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G1021Z&format=json', 'SaferProducts exact-model G1021Z recall API query', 'other', '2026-10-15'),
  (371, 'https://www.amazon.com/dp/B0000DD0AS', 'Amazon exact Grizzly G1021Z commercial destination', 'other', '2026-10-15');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (45, 359, 'current exact-model identity, summary specifications, cabinet-stand configuration, and support resources'),
  (45, 360, 'current exact G1021Z electrical, motor, capacity, cutterhead, table, construction, and weight specifications'),
  (45, 361, 'latest combined-manual exact G1021Z setup, operation, maintenance, troubleshooting, wiring, adjustment, and service guidance'),
  (45, 362, 'manufacture-date manual index, revision-aware online parts catalog, substitutions, and item-level availability'),
  (45, 363, 'current illustrated exact-model parts list and conflicting 15A, 507-pound illustrated ID-label specifications'),
  (45, 364, 'representative current motor supersession and listing'),
  (45, 365, 'representative current magnetic-switch assembly listing'),
  (45, 366, 'current three-knife consumable identity, supersession, dimensions, and exact G1021-series fit'),
  (45, 367, 'representative current gearbox assembly listing'),
  (45, 301, 'manufacturer parts-availability policy, version handling, substitutions, and availability limits'),
  (45, 251, 'manufacturer depot repair route, freight burden, and prior-authorization requirements'),
  (45, 65, 'one-year limited warranty terms and exclusions'),
  (45, 368, 'bounded exact-model 2005 purchase, 15-year outdoor-use, bearing-replacement, rebuild, and post-rebuild modification report'),
  (45, 369, 'bounded two-year exact-model reliability report; separate historical G1021 reports excluded from G1021Z durability claims'),
  (45, 255, 'current Grizzly recalls page and separate G0815 planer recall boundary'),
  (45, 370, 'bounded exact-model recall API query returning no results; not safety clearance'),
  (45, 311, 'separate CPSC G0815 planer recall that must not be transferred to G1021Z'),
  (45, 371, 'exact commercial destination');

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
  (353, 45, 'identity', 'Grizzly G1021Z; stationary thickness planer; cabinet stand; 15 in.; 3 HP; 230V; single-phase; 12A; three-knife cutterhead; knives 15 x 1 x 1/8 in.; 16 and 28 FPM', 'Exact current U.S. G1021Z 15-inch stationary planer with a cabinet stand, 3 HP 230V single-phase 12A motor, three-knife cutterhead using 15 x 1 x 1/8-inch HSS knives, and 16 and 28 FPM feed rates.', 'T1', 360, '2026-10-15', 180),
  (354, 45, 'parts_availability', 'partial', 'Partial: Grizzly publishes a revision-aware exact-model catalog with currently listed or substituted motor, magnetic switch, knives, gearbox, belts, chains, bearings, and many smaller components, but compatibility depends on manufacture date and manual version, and not every catalog component was independently confirmed orderable.', 'T1', 362, '2026-10-15', 90),
  (355, 45, 'repair_manual', 'not-comprehensive', 'The owner manual covers setup, maintenance, troubleshooting, wiring, illustrated parts, knife replacement and adjustment, belt and chain service, gearbox oil, and mechanical adjustment; it is substantial owner and technician guidance, not a comprehensive internal repair manual for every subsystem and manufacturing revision.', 'T1', 361, '2026-10-15', 180),
  (356, 45, 'serviceability', 'shop-serviceable', 'Owners can replace or adjust knives, service belts and chains, change gearbox oil, lubricate the machine, and perform documented mechanical adjustments; 230V electrical work requires a qualified person, and depot repair of this 474-pound machine can require customer-arranged crating and LTL freight.', 'T1', 361, '2026-10-15', 180),
  (357, 45, 'warranty', '1-year limited warranty', 'One-year limited warranty for the original purchaser covering manufacturing defects; consumables and published misuse, wiring, unauthorized-repair, and maintenance exclusions apply, and coverage is non-transferable.', 'T1', 65, '2026-10-15', 180),
  (358, 45, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-15', 90),
  (359, 45, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-15', 30),
  (360, 45, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-15', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  45,
  45,
  'Amazon Associates',
  'https://www.amazon.com/dp/B0000DD0AS?tag=everlastin08f-20',
  1,
  '2026-10-15'
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
  45,
  'partial',
  'https://www.grizzly.com/products/g1021z/parts',
  0,
  'https://cdn0.grizzly.com/manuals/g1021z_m.pdf',
  'shop-serviceable',
  NULL,
  362,
  '2026-10-15'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  45,
  '1 year limited warranty',
  'Grizzly warrants the machine to the original purchaser for one year from purchase against defects in materials and workmanship, subject to its current terms.',
  'The warranty is non-transferable and excludes consumables, misuse, abuse, negligence, accidents, improper wiring, unauthorized repairs or alterations, and lack of maintenance; proof of purchase is required.',
  65,
  '2026-10-15'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '50');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-15');

COMMIT;
