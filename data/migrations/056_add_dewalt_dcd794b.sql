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
  48,
  'dewalt-dcd794b',
  'DEWALT',
  'DCD794',
  'DCD794B',
  'drill-drivers',
  'tools-shop',
  'Exact U.S. DCD794B ATOMIC 20V MAX brushless 1/2-inch drill/driver tool-only package. DEWALT lists a belt hook with the bare tool; battery and charger are sold separately. The support evidence reviewed here is for DCD794B Type 1. Do not transfer these findings to DCD794D1 or DCD794D2 kits, the DCD799 hammer drill, DCD800 or DCD805 tools, regional packages, combo kits, batteries, chargers, or a different type/revision.',
  'T2',
  'not-yet-verified',
  'DEWALT identifies the exact DCD794B tool-only drill/driver and publishes Type 1 documentation. The live ServiceNet snapshot reviewed October 24, 2026 listed individually purchasable major assemblies including the chuck, clamshell, transmission, motor, and selector, but current stock is volatile and this does not establish future support. A July 17, 2026 Reddit post reports two to three months of continuous DCD794 use, and a commenter in the same thread reports using the model for about one year for home maintenance and repairs. Those self-reports are useful but anecdotal, short-duration, and not representative evidence for service life, failure rate, maintenance cost, or repair economics. The exact-title SaferProducts recall query returned an empty result and the DEWALT safety-notices page did not identify DCD794 in the bounded review; neither check is safety clearance. Expected service life, representative failure rate, maintenance cost, repair economics, and a Buy-It-for-Life recommendation remain not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified. The exact-model owner evidence reviewed is limited to one report after two to three months of use and one comment after about one year; it cannot establish representative service life.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-24',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (398, 'https://www.dewalt.com/en-us/product/dcd794b/atomic-20v-max-brushless-cordless-12-drilldriver-tool-only', 'DEWALT DCD794B ATOMIC 20V MAX brushless 1/2-inch drill/driver product page', 'manufacturer', '2026-10-24'),
  (399, 'https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Instruction_Manual/EN/NA597019_DCD794_DCD799_NA_NBC.pdf', 'DEWALT DCD794 and DCD799 Type 1 North America instruction manual', 'manufacturer', '2026-10-24'),
  (400, 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-COMPACT-DRILL-DRIVER-BARE/p/DCD794B_1', 'DEWALT ServiceNet DCD794B Type 1 parts catalog', 'manufacturer', '2026-10-24'),
  (401, 'https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Exploded_Diagram/EN/DCD794_B_C1_D1_T1.svg', 'DEWALT DCD794B Type 1 exploded diagram', 'manufacturer', '2026-10-24'),
  (402, 'https://www.reddit.com/r/Dewalt/comments/1uzcdvm/in_love_with_the_dcd794_3_month_review/', 'DCD794 short-duration owner reports on r/Dewalt', 'owner-report', '2026-10-24'),
  (403, 'https://www.dewalt.com/en-us/support/safety-notices-and-recalls', 'DEWALT safety notices and recalls', 'manufacturer', '2026-10-24'),
  (404, 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD794', 'SaferProducts exact-title DCD794 recall API query', 'other', '2026-10-24'),
  (405, 'https://www.amazon.com/dp/B0BY1QMH24', 'Amazon exact DCD794B tool-only destination', 'other', '2026-10-24');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (48, 398, 'Exact U.S. DCD794B tool-only identity, package boundary, and manufacturer specifications'),
  (48, 399, 'Type 1 operation, maintenance, cleaning, troubleshooting, and repair-path boundaries'),
  (48, 400, 'Type 1 live model status and current individual-part orderability snapshot'),
  (48, 401, 'Type 1 exploded assembly documentation'),
  (48, 83, 'DEWALT spare-parts ordering policy and ServiceNet path'),
  (48, 241, 'DEWALT manuals, parts-list, and diagram support path'),
  (48, 243, 'Manufacturer warranty-repair service-center path'),
  (48, 2, 'DEWALT warranty terms'),
  (48, 402, 'Bounded exact-model owner reports with short ownership duration'),
  (48, 403, 'Bounded manufacturer safety-notice review'),
  (48, 404, 'Bounded exact-title federal recall query with empty result'),
  (48, 405, 'Exact DCD794B commercial destination verified without price, rating, seller, or availability claims');

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
  (379, 48, 'identity', 'DCD794B ATOMIC 20V MAX brushless 1/2-inch drill/driver, tool-only, Type 1', 'Exact U.S. DEWALT DCD794B ATOMIC 20V MAX brushless 1/2-inch compact drill/driver, tool-only; Type 1 evidence reviewed', 'T2', 398, '2026-10-24', 180),
  (380, 48, 'parts_availability', 'partial', 'Partial — the October 24, 2026 ServiceNet Type 1 snapshot listed purchasable assemblies including the chuck, clamshell, transmission, motor, and selector. This is a dated availability snapshot, not a guarantee of future stock or complete component-level repair support.', 'T2', 400, '2026-10-24', 30),
  (381, 48, 'repair_manual', 'false', 'No comprehensive internal repair manual verified. The Type 1 owner manual covers operation, routine maintenance, cleaning, and basic troubleshooting, then directs repairs and adjustments to DEWALT service facilities.', 'T2', 399, '2026-10-24', 365),
  (382, 48, 'serviceability', 'shop-serviceable', 'Shop-serviceable through DEWALT''s service network. Owner guidance is limited to cleaning dirt and dust with dry compressed air, using mild soap on nonmetallic exterior parts, and following battery/tool safety instructions; internal repair is not documented as an owner procedure.', 'T2', 243, '2026-10-24', 180),
  (383, 48, 'warranty', '3-year limited warranty; 1-year free service; 90-day money-back guarantee', 'DEWALT states a three-year limited warranty, one-year free service, and 90-day money-back guarantee for covered products, subject to the published terms and exclusions.', 'T2', 2, '2026-10-24', 180),
  (384, 48, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-24', 180),
  (385, 48, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-24', 30),
  (386, 48, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-24', 180);

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
  48,
  'partial',
  'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-COMPACT-DRILL-DRIVER-BARE/p/DCD794B_1',
  0,
  'https://assets.dewalt.com/GLOBALBOM/QU/DCD794B/1/Instruction_Manual/EN/NA597019_DCD794_DCD799_NA_NBC.pdf',
  'shop-serviceable',
  NULL,
  400,
  '2026-10-24'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  48,
  '3-year limited warranty; 1-year free service; 90-day money-back guarantee',
  'The published policy covers repair without charge for defects due to faulty materials or workmanship for three years from purchase and includes one year of free maintenance/service on covered DEWALT tools.',
  'The published policy excludes part failure due to normal wear or tool abuse and is subject to DEWALT''s full terms, proof-of-purchase, product, and regional conditions.',
  2,
  '2026-10-24'
);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  48,
  48,
  'Amazon Associates',
  'https://www.amazon.com/dp/B0BY1QMH24?tag=everlastin08f-20',
  1,
  '2026-10-24'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '56');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-24');

COMMIT;
