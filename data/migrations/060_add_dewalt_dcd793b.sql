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
  51,
  'dewalt-dcd793b',
  'DEWALT',
  'DCD793',
  'DCD793B',
  'drill-drivers',
  'tools-shop',
  'Exact U.S. DCD793B 20V MAX brushless cordless 1/2-inch drill/driver tool-only package. DEWALT lists the DCD793 drill/driver and belt hook; battery and charger are sold separately. The support evidence reviewed here is for DCD793B Type 1. Do not transfer these findings to the DCD793D1 battery-and-charger kit, the DCD798 hammer drill, the DCD794 ATOMIC drill/driver, XR models, combo kits, batteries, chargers, regional packages, or another type/revision.',
  'T2',
  'not-yet-verified',
  'DEWALT identifies the exact DCD793B tool-only drill/driver and publishes Type 1 documentation. The October 26, 2026 ServiceNet snapshot marked 13 entries purchasable, including the clamshell, motor-and-switch, selector, and transmission assemblies, all with positive numeric stock; normal inventory volatility limits that finding to partial dated support. An August 4, 2025 TechGearLab review documents hands-on drilling and driving tests of the exact DCD793B, but it is not ownership-duration or repair-history evidence. No credible long-duration exact-model owner report was accepted. The exact-title SaferProducts recall query returned an empty result and the DEWALT safety-notices page did not identify DCD793 in the bounded review; neither check is safety clearance. Expected service life, representative failure rate, maintenance cost, repair economics, and a Buy-It-for-Life recommendation remain not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified. The accepted exact-model evidence is a 2025 hands-on performance review rather than long-duration ownership or repair-history evidence, and no credible long-duration exact-model owner report was accepted.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-26',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (421, 'https://www.dewalt.com/en-us/product/dcd793b/20v-max-brushless-cordless-12-drilldriver-tool-only', 'DEWALT DCD793B 20V MAX brushless 1/2-inch drill/driver product page', 'manufacturer', '2026-10-26'),
  (422, 'https://assets.dewalt.com/GLOBALBOM/QU/DCD793B/1/Instruction_Manual/EN/DCD793-DCD798_NA.pdf', 'DEWALT DCD793 and DCD798 Type 1 North America instruction manual', 'manufacturer', '2026-10-26'),
  (423, 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V//p/DCD793B_1', 'DEWALT ServiceNet DCD793B Type 1 parts catalog', 'manufacturer', '2026-10-26'),
  (424, 'https://assets.dewalt.com/GLOBALBOM/QU/DCD793B/1/Exploded_Diagram/EN/E21151.svg', 'DEWALT DCD793B Type 1 exploded diagram', 'manufacturer', '2026-10-26'),
  (425, 'https://www.techgearlab.com/reviews/tools/drill/dewalt-20v-max-brushless-1-2-in-cordless-compact-drill-driver-dcd793b', 'TechGearLab hands-on DEWALT DCD793B drill review', 'other', '2026-10-26'),
  (426, 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD793', 'SaferProducts exact-title DCD793 recall API query', 'other', '2026-10-26'),
  (427, 'https://www.amazon.com/dp/B0BY13XZXT', 'Amazon exact DEWALT DCD793B tool-only destination', 'other', '2026-10-26');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (51, 421, 'Exact U.S. DCD793B tool-only identity, package boundary, and manufacturer specifications'),
  (51, 422, 'Type 1 operation, maintenance, cleaning, and repair-path boundaries'),
  (51, 423, 'Type 1 live model status and dated individual-part orderability and stock snapshot'),
  (51, 424, 'Type 1 exploded assembly documentation'),
  (51, 83, 'DEWALT spare-parts ordering policy and ServiceNet path'),
  (51, 241, 'DEWALT manuals, parts-list, and diagram support path'),
  (51, 243, 'Manufacturer warranty-repair service-center path'),
  (51, 2, 'DEWALT warranty terms'),
  (51, 425, 'Bounded exact-model hands-on testing that does not establish ownership duration or service life'),
  (51, 403, 'Bounded manufacturer safety-notice review'),
  (51, 426, 'Bounded exact-title federal recall query with empty result'),
  (51, 427, 'Exact DCD793B commercial destination verified without price, rating, seller, or availability claims');

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
  (403, 51, 'identity', 'DCD793B 20V MAX brushless cordless 1/2-inch drill/driver, tool-only, Type 1', 'Exact U.S. DEWALT DCD793B 20V MAX brushless cordless 1/2-inch drill/driver, tool-only; Type 1 evidence reviewed. DEWALT documents a 6.38-inch tool-head length, 404 UWO, up to 1,650 RPM no load, a 1/2-inch ratcheting chuck, and an LED work light.', 'T2', 421, '2026-10-26', 180),
  (404, 51, 'parts_availability', 'partial', 'Partial — the October 26, 2026 ServiceNet Type 1 snapshot marked 13 entries purchasable. The clamshell, motor-and-switch, selector, and transmission assemblies all showed positive numeric stock. This is a dated snapshot and does not guarantee current checkout, future stock, or complete component-level support.', 'T2', 423, '2026-10-26', 30),
  (405, 51, 'repair_manual', 'false', 'No comprehensive internal repair manual verified. The Type 1 owner manual covers operation, adjustment, routine maintenance, weekly cleaning, and safety, then directs repairs, maintenance, and adjustment to factory or authorized service centers.', 'T2', 422, '2026-10-26', 365),
  (406, 51, 'serviceability', 'shop-serviceable', 'Shop-serviceable through DEWALT service centers. Owner guidance includes blowing dirt and dust from air vents with clean, dry air at least once a week and cleaning nonmetallic exterior parts with water and mild soap; internal repair is not documented as an owner procedure.', 'T2', 422, '2026-10-26', 180),
  (407, 51, 'warranty', '3-year limited warranty; 1-year free service; 90-day money-back guarantee', 'DEWALT states a three-year limited warranty, one-year free service, and 90-day money-back guarantee for covered products, subject to the published terms and exclusions.', 'T2', 2, '2026-10-26', 180),
  (408, 51, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-26', 180),
  (409, 51, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-26', 30),
  (410, 51, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-26', 180);

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
  51,
  'partial',
  'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V//p/DCD793B_1',
  0,
  'https://assets.dewalt.com/GLOBALBOM/QU/DCD793B/1/Instruction_Manual/EN/DCD793-DCD798_NA.pdf',
  'shop-serviceable',
  NULL,
  423,
  '2026-10-26'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  51,
  '3-year limited warranty; 1-year free service; 90-day money-back guarantee',
  'The published policy covers repair without charge for defects due to faulty materials or workmanship for three years from purchase and includes one year of free maintenance/service on covered DEWALT tools.',
  'The published policy excludes part failure due to normal wear or tool abuse and is subject to DEWALT''s full terms, proof-of-purchase, product, and regional conditions.',
  2,
  '2026-10-26'
);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  51,
  51,
  'Amazon Associates',
  'https://www.amazon.com/dp/B0BY13XZXT?tag=everlastin08f-20',
  1,
  '2026-10-26'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '60');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-26');

COMMIT;
