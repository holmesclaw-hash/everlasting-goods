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
  43,
  'grizzly-g0453z',
  'Grizzly',
  'G0453Z',
  'G0453Z',
  'stationary-planers',
  'tools-shop',
  'This exact record is for the current U.S. G0453Z 15-inch stationary planer with a 3 HP, 240V single-phase 15A motor, four-row spiral cutterhead, and 74 indexable carbide inserts. Machines manufactured 03/15 and earlier use T21348 inserts, while machines manufactured 04/15 and later use H7319 inserts; the manufacture date on the ID label must be checked before ordering cutterhead parts. Machines manufactured since 09/17 use a later rubber outfeed roller. Specifications, parts, owner reports, recall status, and commercial identities are not transferred from G0453, G0453P, G0453PX, G0453W, G0453ZW, G0453ZX, G0454Z, recalled G0815, or other related planers and revisions.',
  'T2',
  'not-yet-verified',
  'Exact-model owner reports include a two-year machine with a replaced motor after repeated capacitor trouble, a three-year machine with an undiagnosed oil leak, a four-year lightly used machine whose start problem was attributed to the centrifugal switch, and one owner reporting in 2018 that a G0453Z used since 2010 still had the same belts. These are anecdotal experiences across different usage and manufacturing revisions, not representative evidence. Expected service life, representative failure rate, repair economics, and a repair-versus-replace recommendation are not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; dated exact-model reports describe individual multi-year machines and repairs but do not establish representative G0453Z service life.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-14',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (328, 'https://www.grizzly.com/products/grizzly-15-3-hp-planer-w-spiral-cutterhead/g0453z', 'Grizzly G0453Z official product page', 'manufacturer', '2026-10-14'),
  (329, 'https://cdn0.grizzly.com/specsheets/g0453z_ds.pdf', 'Grizzly G0453Z specification sheet dated 2026-04-30', 'manufacturer', '2026-10-14'),
  (330, 'https://cdn0.grizzly.com/manuals/g0453z_m.pdf', 'Grizzly G0453Z and G0454Z owner manual with revision updates', 'manufacturer', '2026-10-14'),
  (331, 'https://www.grizzly.com/products/g0453z/parts', 'Grizzly G0453Z revision-aware parts catalog', 'manufacturer', '2026-10-14'),
  (332, 'https://cdn0.grizzly.com/partslists/g0453z_pl.pdf', 'Grizzly G0453Z illustrated parts list and revision updates', 'manufacturer', '2026-10-14'),
  (333, 'https://support.grizzly.com/hc/en-us/articles/35556139763863-FAQ-G0453Z-G0453ZX-15-Planer', 'Grizzly G0453Z and G0453ZX comparison FAQ', 'manufacturer', '2026-10-14'),
  (334, 'https://support.grizzly.com/hc/en-us/articles/41750070246423-Checking-and-Adjusting-Table-Parallelism-on-Fixed-Head-Planers', 'Grizzly fixed-head planer table-parallelism procedure', 'manufacturer', '2026-10-14'),
  (335, 'https://www.grizzly.com/products/grizzly-indexable-carbide-inserts-14-x-14-x-2mm-10-pk./h7319', 'Grizzly H7319 inserts for G0453Z machines manufactured 04/15 and later', 'manufacturer', '2026-10-14'),
  (336, 'https://www.grizzly.com/products/grizzly-indexable-carbide-inserts-14.18-x-14.18-x-2mm-10-pk./t21348', 'Grizzly T21348 inserts for G0453Z machines manufactured 03/15 and earlier', 'manufacturer', '2026-10-14'),
  (337, 'https://www.grizzly.com/parts/P0453Z518V2', 'Grizzly G0453Z V2 3 HP 240V motor part page', 'manufacturer', '2026-10-14'),
  (338, 'https://www.grizzly.com/parts/P0453Z551V2', 'Grizzly G0453Z V2 magnetic switch assembly part page', 'manufacturer', '2026-10-14'),
  (339, 'https://www.grizzly.com/parts/P0453Z063V2', 'Grizzly G0453Z later rubber outfeed roller part page', 'manufacturer', '2026-10-14'),
  (340, 'https://sawmillcreek.org/threads/15-planer-recommendations.192413/post-1986882', 'Sawmill Creek two-year G0453Z motor and capacitor owner report', 'owner-report', '2026-10-14'),
  (341, 'https://sawmillcreek.org/threads/grizzly-g0453w-planer-belt-life.262847/post-2786219', 'Sawmill Creek G0453Z same-belts-since-2010 owner report', 'owner-report', '2026-10-14'),
  (342, 'https://sawmillcreek.org/threads/grizzly-15-planer-leaking-gearbox-oil.197376/post-2040047', 'Sawmill Creek three-year G0453Z undiagnosed oil-leak owner report', 'owner-report', '2026-10-14'),
  (343, 'https://www.lumberjocks.com/threads/grizzly-15-inch-planer-help.56358/', 'LumberJocks four-year G0453Z capacitor and centrifugal-switch owner report', 'owner-report', '2026-10-14'),
  (344, 'https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0453Z&format=json', 'SaferProducts exact-model G0453Z recall API query', 'other', '2026-10-14'),
  (345, 'https://www.amazon.com/dp/B0017IF2RU', 'Amazon exact Grizzly G0453Z commercial destination', 'other', '2026-10-14');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (43, 328, 'current exact-model identity, summary specifications, warranty statement, and March-April 2015 insert boundary'),
  (43, 329, 'current exact G0453Z electrical, motor, capacity, cutterhead, table, construction, weight, and certification specifications'),
  (43, 330, 'revision-aware operation, maintenance, troubleshooting, wiring, adjustment, insert, belt, chain, and illustrated-parts documentation'),
  (43, 331, 'exact-model online parts catalog, manual revisions, substitutions, and item-level availability'),
  (43, 332, 'illustrated exact-model parts and August 2012, April 2015, and September 2017 revision boundaries'),
  (43, 333, 'exact G0453Z versus G0453ZX differences and current operating specifications'),
  (43, 334, 'manufacturer table-parallelism inspection and adjustment guidance with exact-model direction and movement boundary'),
  (43, 335, 'current H7319 consumable identity and fit for G0453Z manufactured 04/15 and later'),
  (43, 336, 'current T21348 consumable identity and fit for G0453Z manufactured 03/15 and earlier'),
  (43, 337, 'representative current motor component listing'),
  (43, 338, 'representative current magnetic-switch component listing'),
  (43, 339, 'later rubber outfeed-roller substitution and G0453W exclusion'),
  (43, 301, 'manufacturer parts-availability policy, version handling, and availability limits'),
  (43, 251, 'manufacturer depot repair route, freight burden, and prior-authorization requirements'),
  (43, 65, 'one-year limited warranty terms and exclusions'),
  (43, 340, 'bounded two-year exact-model motor and capacitor report; not representative failure-rate evidence'),
  (43, 341, 'bounded exact-model same-belts-since-2010 report; not expected-life evidence'),
  (43, 342, 'bounded three-year exact-model oil-leak report without confirmed diagnosis'),
  (43, 343, 'bounded four-year exact-model start-circuit report with owner-attributed centrifugal-switch resolution'),
  (43, 255, 'current Grizzly recalls page and separate G0815 planer recall boundary'),
  (43, 344, 'bounded exact-model recall API query returning no results; not safety clearance'),
  (43, 311, 'separate CPSC G0815 planer recall that must not be transferred to G0453Z'),
  (43, 345, 'exact commercial destination');

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
  (337, 43, 'identity', 'Grizzly G0453Z; stationary thickness planer; 15 in.; 3 HP; 240V; single-phase; 15A; four-row spiral cutterhead; 74 carbide inserts; current inserts 14 x 14 x 2 mm', 'Exact current U.S. G0453Z 15-inch stationary planer with a 3 HP, 240V single-phase 15A motor and a four-row spiral cutterhead carrying 74 indexable 14 x 14 x 2 mm carbide inserts.', 'T1', 329, '2026-10-14', 180),
  (338, 43, 'parts_availability', 'partial', 'Partial: Grizzly publishes a revision-aware exact-model catalog with currently listed H7319 and T21348 inserts, a 3 HP motor, magnetic switch, and revision-specific outfeed roller, but manufacture-date compatibility is critical and not every catalog component was independently confirmed orderable.', 'T1', 331, '2026-10-14', 90),
  (339, 43, 'repair_manual', 'not-comprehensive', 'The owner manual covers maintenance, troubleshooting, wiring, illustrated parts, insert rotation and replacement, belt service, chain service, and mechanical adjustment; it is substantial owner and technician guidance, not a comprehensive internal repair manual for every subsystem and production revision.', 'T1', 330, '2026-10-14', 180),
  (340, 43, 'serviceability', 'shop-serviceable', 'Owners can rotate or replace inserts, service belts and chains, and follow revision-specific table parallelism guidance; 240V electrical work requires a qualified person, and depot repair of this 655-pound machine can require customer-arranged crating and LTL freight.', 'T1', 334, '2026-10-14', 180),
  (341, 43, 'warranty', '1-year limited warranty', 'One-year limited warranty for the original purchaser covering manufacturing defects; consumables and published misuse, wiring, unauthorized-repair, and maintenance exclusions apply, and coverage is non-transferable.', 'T1', 65, '2026-10-14', 180),
  (342, 43, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-14', 90),
  (343, 43, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-14', 30),
  (344, 43, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-14', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  43,
  43,
  'Amazon Associates',
  'https://www.amazon.com/dp/B0017IF2RU?tag=everlastin08f-20',
  1,
  '2026-10-14'
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
  43,
  'partial',
  'https://www.grizzly.com/products/g0453z/parts',
  0,
  'https://cdn0.grizzly.com/manuals/g0453z_m.pdf',
  'shop-serviceable',
  NULL,
  334,
  '2026-10-14'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  43,
  '1 year limited warranty',
  'Grizzly warrants the machine to the original purchaser for one year from purchase against defects in materials and workmanship, subject to its current terms.',
  'The warranty is non-transferable and excludes consumables, misuse, abuse, negligence, accidents, improper wiring, unauthorized repairs or alterations, and lack of maintenance; proof of purchase is required.',
  65,
  '2026-10-14'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '48');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-14');

COMMIT;
