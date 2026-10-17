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
  47,
  'grizzly-g0925',
  'Grizzly',
  'G0925',
  'G0925',
  'drill-presses',
  'tools-shop',
  'This exact record is for the current U.S. G0925 eight-inch benchtop drill press with a 1/3 HP, 120V single-phase 2.3A TEFC induction motor, belt drive, five spindle speeds from 740 to 3140 RPM, a JT33 keyed 1/16-to-1/2-inch chuck, and two inches of spindle travel. The current V1.02.20 owner manual applies to machines manufactured since 02/20, and a May 2020 update replaced the depth stop bracket with a chuck guard while revising the inventory and assembly instructions. Owners must use the manufacture date and serial number on the machine ID label when matching documentation and version-marked parts. The T32006 variable-speed mini drill press, Shop Fox W1667 oscillating drill press, and other drill-press specifications and owner histories are not transferred to G0925.',
  'T2',
  'not-yet-verified',
  'A dated exact-model owner statement published August 20, 2022 says the G0925 had stood up to substantial use working aluminum and was portable enough to carry to a parking garage, but it gives no purchase date, ownership duration, repair history, or workload measurement. A separate exact-item retailer review says it was purchased March 15, 2024 and reviewed April 14, 2024, but provides no durability detail beyond a short positive remark. These anecdotes do not establish representative expected service life, failure rate, annual maintenance cost, repair economics, or a repair-versus-replace recommendation, so those values are not yet verified. A bounded exact-model recall API query returned an empty array, which is not safety clearance.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; the accepted exact-model evidence lacks a documented multi-year ownership duration, repair history, or representative workload.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-16',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (381, 'https://www.grizzly.com/products/grizzly-8-benchtop-drill-press/g0925', 'Grizzly G0925 official product page and current specifications', 'manufacturer', '2026-10-16'),
  (382, 'https://cdn0.grizzly.com/specsheets/g0925_ds.pdf', 'Grizzly G0925 specification sheet accurate as of October 15, 2026', 'manufacturer', '2026-10-16'),
  (383, 'https://cdn0.grizzly.com/manuals/g0925_m.pdf', 'Grizzly G0925 owner manual V1.02.20 and May 2020 update for machines manufactured since February 2020', 'manufacturer', '2026-10-16'),
  (384, 'https://cdn0.grizzly.com/partslists/g0925_pl.pdf', 'Grizzly G0925 illustrated parts list for machines manufactured since February 2020', 'manufacturer', '2026-10-16'),
  (385, 'https://www.grizzly.com/products/g0925/parts', 'Grizzly G0925 version-aware online parts catalog', 'manufacturer', '2026-10-16'),
  (386, 'https://support.grizzly.com/hc/en-us/articles/34277374404503-How-Do-I-Submit-a-Warranty-Claim', 'Grizzly warranty replacement-parts claim process', 'manufacturer', '2026-10-16'),
  (387, 'https://www.garagejournal.com/forum/threads/attn-rockler-woodworking-regulars.502568/', 'Garage Journal August 2022 exact G0925 owner statement', 'owner-report', '2026-10-16'),
  (388, 'https://www.mowersatjacks.com/product-details/grizzly/g0925', 'Mowers at Jacks April 2024 exact G0925 short-term purchaser review', 'owner-report', '2026-10-16'),
  (389, 'https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0925&format=json', 'SaferProducts exact-model G0925 recall API query', 'other', '2026-10-16'),
  (390, 'https://www.amazon.com/dp/B088FZKW39', 'Amazon exact Grizzly G0925 commercial destination', 'other', '2026-10-16');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (47, 381, 'current exact-model identity, dimensions, spindle speeds, chuck, construction, and support claims'),
  (47, 382, 'current exact G0925 electrical, motor, spindle, table, construction, dimension, and warranty specifications'),
  (47, 383, 'manufacture-date scope, chuck-guard update, maintenance, lubrication, troubleshooting, spring and pulley service, wiring, and illustrated parts'),
  (47, 384, 'manufacture-date-bounded illustrated component identifiers and parts-availability disclaimer'),
  (47, 385, 'version-aware exact-model parts catalog and representative current order controls and substitutions'),
  (47, 301, 'manufacturer parts-purchasing route, current and legacy listings, substitutions, and availability limits'),
  (47, 251, 'manufacturer depot repair route and required serial and manufacture-date information'),
  (47, 65, 'one-year house-brand limited warranty terms and exclusions'),
  (47, 386, 'warranty replacement-parts claim process and required proof, serial, and manufacture-date information'),
  (47, 387, 'bounded August 2022 exact-model owner statement without ownership duration or repair history'),
  (47, 388, 'bounded one-month exact-model purchaser review without durability or repair detail'),
  (47, 255, 'current Grizzly recalled-items page and unrelated-model recall boundary'),
  (47, 389, 'bounded exact-model recall API query returning no results; not safety clearance'),
  (47, 379, 'manufacturer image-rights restriction and article image-gate evidence'),
  (47, 390, 'exact commercial destination');

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
  (370, 47, 'identity', 'Grizzly G0925; benchtop drill press; 8 in. swing; 1/3 HP; 120V; single-phase; 2.3A; TEFC induction motor; belt drive; 5 speeds; 740-3140 RPM; JT33 keyed chuck; 1/16-1/2 in.; 2 in. spindle travel; 34 lb', 'Exact current U.S. G0925 eight-inch benchtop drill press with a 1/3 HP, 120V single-phase 2.3A TEFC induction motor, belt drive, five spindle speeds from 740 to 3140 RPM, a JT33 keyed 1/16-to-1/2-inch chuck, two inches of spindle travel, and a 34-pound listed machine weight.', 'T1', 382, '2026-10-16', 180),
  (371, 47, 'parts_availability', 'partial', 'Partial: the exact-model catalog currently exposes order controls or named replacements for representative components including the V-belt, motor, run capacitor, selected motor components, JT33 chuck, quill, 6201ZZ bearings, paddle switch, pulleys, table, and column. The parts list and catalog warn that availability and versions can change; not every listed component was independently confirmed currently orderable.', 'T1', 385, '2026-10-16', 90),
  (372, 47, 'repair_manual', 'not-comprehensive', 'The owner manual covers scheduled maintenance, cleaning, lubrication, troubleshooting, spindle-speed belt changes, return-spring tension, pulley alignment, wiring, and illustrated parts. It is useful owner and service guidance, not a comprehensive internal repair manual for every subsystem, bearing replacement, or production revision.', 'T1', 383, '2026-10-16', 180),
  (373, 47, 'serviceability', 'shop-serviceable', 'Published procedures let owners change spindle speed by repositioning and tensioning the belt, adjust return-spring tension, align pulleys, clean and protect the machine, and lubricate the quill, column, rack, and pinion. Electrical diagnosis and work beyond documented procedures should follow the manual and qualified-service boundaries.', 'T1', 383, '2026-10-16', 180),
  (374, 47, 'warranty', '1-year limited warranty', 'One-year limited warranty for the original purchaser; proof of purchase is required, and consumables, misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, and lack of maintenance are excluded.', 'T1', 65, '2026-10-16', 180),
  (375, 47, 'documentation_revision', 'V1.02.20; machines manufactured since 02/20; May 2020 update', 'The current V1.02.20 owner manual applies to G0925 machines manufactured since 02/20. A May 2020 update replaced the depth stop bracket with a chuck guard and revised inventory and assembly steps. Match documentation and version-marked parts to the manufacture date and serial number on the machine ID label.', 'T2', 383, '2026-10-16', 180),
  (376, 47, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-16', 90),
  (377, 47, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-16', 30),
  (378, 47, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-16', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  47,
  47,
  'Amazon Associates',
  'https://www.amazon.com/dp/B088FZKW39?tag=everlastin08f-20',
  1,
  '2026-10-16'
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
  47,
  'partial',
  'https://www.grizzly.com/products/g0925/parts',
  0,
  'https://cdn0.grizzly.com/manuals/g0925_m.pdf',
  'shop-serviceable',
  NULL,
  385,
  '2026-10-16'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  47,
  '1 year limited warranty',
  'Grizzly warrants the machine to the original purchaser for one year from purchase against covered defects, subject to its current terms and proof-of-purchase requirement.',
  'The warranty excludes consumables, misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, and lack of maintenance; third-party repair and transportation expenses are not reimbursed.',
  65,
  '2026-10-16'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '52');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-16');

COMMIT;
