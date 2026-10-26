PRAGMA foreign_keys = ON;

BEGIN IMMEDIATE;

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
  50,
  'milwaukee-3601-20',
  'Milwaukee',
  '3601-20',
  '3601-20',
  'drill-drivers',
  'tools-shop',
  'Exact U.S. Milwaukee 3601-20 M18 compact brushless 1/2-inch drill/driver bare-tool package. Milwaukee lists the 3601-20 tool and belt clip; battery and charger are not included. Do not transfer these findings to the 3601-22CT battery-and-charger kit, the 3602-20 hammer drill, other combo kits, batteries, chargers, regional packages, or another serial/revision configuration. The service-parts evidence reviewed is the July 2025 list for starting serial N66A.',
  'T2',
  'not-yet-verified',
  'Milwaukee identifies the exact 3601-20 bare-tool package and publishes an operator manual plus a July 2025 N66A service-parts list. The service document identifies chuck, rotor, gearbox, electronic, housing, and belt-clip assemblies and provides limited chuck, wiring, and torque procedures, but current individual-part orderability was not independently verified. A June 13, 2026 Reddit post reports that a 3601-20 chuck screw sheared and says the owner encountered an inconvenient physical-shop warranty path; it gives no purchase date, ownership duration, workload, repair outcome, or representative failure context. The discovery lead about a 40-year-old drill does not identify a 3601-20 and predates this model by decades, so it is not exact-model longevity evidence. An exact-title SaferProducts recall query returned an empty result; that bounded check is not safety clearance. Expected service life, representative failure rate, annual maintenance cost, repair economics, and a Buy-It-for-Life recommendation remain not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified. The only accepted exact-model owner report describes a sheared chuck screw without a purchase date, ownership duration, workload, completed repair, or representative service-life evidence.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-25',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (414, 'https://www.milwaukeetool.com/products/details/m18-compact-brushless-1-2-drill-driver/3601-20', 'Milwaukee 3601-20 M18 compact brushless 1/2-inch drill/driver product page', 'manufacturer', '2026-10-25'),
  (415, 'https://documents.milwaukeetool.com/58-14-9845d2.pdf', 'Milwaukee 3601-20 and 3602-20 operator manual', 'manufacturer', '2026-10-25'),
  (416, 'https://documents.milwaukeetool.com/54-06-2995R.pdf', 'Milwaukee 3601-20 N66A service parts list revised July 2025', 'manufacturer', '2026-10-25'),
  (417, 'https://www.reddit.com/r/BuyItForLife/comments/1keezh2/my_dads_drill_40_years_and_still_going_strong/', 'Forty-year drill report rejected as non-exact Milwaukee 3601-20 evidence', 'owner-report', '2026-10-25'),
  (418, 'https://www.reddit.com/r/MilwaukeeTool/comments/1u55mxz/how_do_i_replace_chuck_screw_that_sheared_off_on/', 'Milwaukee 3601-20 owner report about a sheared chuck screw', 'owner-report', '2026-10-25'),
  (419, 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=3601-20', 'SaferProducts exact-title 3601-20 recall API query', 'other', '2026-10-25'),
  (420, 'https://www.amazon.com/dp/B0CRPLWH24', 'Amazon exact Milwaukee 3601-20 bare-tool destination', 'other', '2026-10-25');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (50, 414, 'Exact U.S. 3601-20 bare-tool identity, package boundary, specifications, release date, and official documents'),
  (50, 415, 'Operation, owner maintenance, inspection, warranty, and authorized-service boundaries'),
  (50, 416, 'July 2025 N66A service assemblies, chuck procedure, wiring diagram, and torque specifications'),
  (50, 5, 'Current Milwaukee power-tool warranty terms'),
  (50, 417, 'Rejected non-exact discovery lead that is not used as 3601-20 longevity evidence'),
  (50, 418, 'Bounded exact-model sheared-chuck-screw and warranty-access owner report'),
  (50, 419, 'Bounded exact-title federal recall query with empty result'),
  (50, 420, 'Exact 3601-20 commercial destination verified without price, rating, seller, or availability claims');

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
  (395, 50, 'identity', '3601-20 M18 compact brushless 1/2-inch drill/driver, bare tool with belt clip', 'Exact U.S. Milwaukee 3601-20 M18 compact brushless 1/2-inch drill/driver bare tool with belt clip. Milwaukee documents a 5.7-inch tool length, 2.3-pound tool-only weight, 550 in-lb maximum torque, and 0-550 and 0-1,700 RPM settings.', 'T2', 414, '2026-10-25', 180),
  (396, 50, 'parts_availability', 'partial', 'Partial — Milwaukee''s July 2025 N66A service-parts list identifies chuck, rotor, gearbox, electronic, housing, and belt-clip assemblies plus fasteners. Current individual orderability and durable future stock were not independently verified.', 'T2', 416, '2026-10-25', 90),
  (397, 50, 'repair_manual', 'false', 'No comprehensive owner repair manual verified. The service-parts list provides limited chuck removal and installation, wiring routing, assembly, and torque procedures, while the operator manual says never to disassemble the tool and directs all repairs to a Milwaukee service facility.', 'T2', 416, '2026-10-25', 365),
  (398, 50, 'serviceability', 'shop-serviceable', 'Shop-serviceable through Milwaukee service facilities. Owner care covers vent cleaning, mild-soap exterior cleaning, inspection for noise, misalignment, binding, or broken parts, battery-contact cleaning, and a six-month-to-one-year inspection interval depending on use.', 'T2', 415, '2026-10-25', 180),
  (399, 50, 'warranty', '5-year limited power-tool warranty', 'Milwaukee states a five-year limited power-tool warranty for the original purchaser from an authorized distributor, subject to proof, examination, terms, and exclusions; chucks are specifically listed among normal-wear parts when normal use exhausts them.', 'T2', 5, '2026-10-25', 180),
  (400, 50, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-25', 180),
  (401, 50, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-25', 30),
  (402, 50, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-25', 180);

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
  50,
  'partial',
  'https://documents.milwaukeetool.com/54-06-2995R.pdf',
  0,
  'https://documents.milwaukeetool.com/58-14-9845d2.pdf',
  'shop-serviceable',
  NULL,
  416,
  '2026-10-25'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  50,
  '5-year limited power-tool warranty',
  'For the original purchaser from an authorized Milwaukee distributor, Milwaukee may repair or replace parts it determines defective in material or workmanship, subject to the current terms, examination, proof, and exceptions.',
  'Unauthorized repair attempts, misuse, alterations, abuse, normal wear, lack of maintenance, and accidents are excluded; chucks are specifically listed among normal-wear parts when normal use exhausts them.',
  5,
  '2026-10-25'
);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  50,
  50,
  'Amazon Associates',
  'https://www.amazon.com/dp/B0CRPLWH24?tag=everlastin08f-20',
  1,
  '2026-10-25'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '58');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-25');

COMMIT;
