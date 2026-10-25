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
  49,
  'dewalt-dcd801b',
  'DEWALT',
  'DCD801',
  'DCD801B',
  'drill-drivers',
  'tools-shop',
  'Exact U.S. DCD801B 20V MAX XR brushless 1/2-inch drill/driver tool-only package. DEWALT lists the DCD801 drill/driver and belt hook; battery, charger, and optional TOOL CONNECT chip are sold separately. The support evidence reviewed here is for DCD801B Type 1. Do not transfer these findings to DCD801QQ2 or DCD801H1 kits, the DCD806 hammer drill, DCD800 or DCD805 tools, regional packages, combo kits, batteries, chargers, or another type/revision.',
  'T2',
  'not-yet-verified',
  'DEWALT identifies the exact DCD801B tool-only drill/driver and publishes Type 1 documentation. The October 25, 2026 ServiceNet snapshot marked 22 entries purchasable; the housing, motor-and-switch assembly, sensor, and selector had positive numeric stock, while the transmission was marked purchasable and inStock but showed a numeric stock level of zero. That inconsistency and normal inventory volatility limit the finding to partial dated support. An August 8, 2026 Reddit post says its author bought the DCD801QQ2 kit several months earlier and had thoroughly enjoyed the included DCD801 for woodworking projects. DEWALT confirms that kit contains a DCD801 drill/driver, but the report concerns a kit rather than the DCD801B tool-only package, gives no repair history, and is anecdotal short-duration evidence. The exact-title SaferProducts recall query returned an empty result and the DEWALT safety-notices page did not identify DCD801 in the bounded review; neither check is safety clearance. Expected service life, representative failure rate, maintenance cost, repair economics, and a Buy-It-for-Life recommendation remain not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified. The accepted exact-tool owner report describes only several months of use from a DCD801QQ2 kit and cannot establish representative service life for the DCD801B tool-only package.',
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
  (406, 'https://www.dewalt.com/en-us/product/dcd801b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only', 'DEWALT DCD801B 20V MAX XR brushless 1/2-inch drill/driver product page', 'manufacturer', '2026-10-25'),
  (407, 'https://www.dewalt.com/en-us/product/dcd801qq2/20v-max-xr-brushless-cordless-12-drilldriver-2-4ah-powerpack-batteries', 'DEWALT DCD801QQ2 kit product page', 'manufacturer', '2026-10-25'),
  (408, 'https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Instruction_Manual/EN/NA283252_man_cordless_drill_drivers_DCD801_DCD806_NA.pdf', 'DEWALT DCD801 and DCD806 Type 1 North America instruction manual', 'manufacturer', '2026-10-25'),
  (409, 'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-XR-DRILL-DRIVER---BARE/p/DCD801B_1', 'DEWALT ServiceNet DCD801B Type 1 parts catalog', 'manufacturer', '2026-10-25'),
  (410, 'https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Exploded_Diagram/EN/NA370838-SRD1_DCD801_.svg', 'DEWALT DCD801B Type 1 exploded diagram', 'manufacturer', '2026-10-25'),
  (411, 'https://www.reddit.com/r/Dewalt/comments/1vj2fpl/dcd801qq2_hd_in_store_clearance_135/', 'DCD801 owner report from a DCD801QQ2 kit on r/Dewalt', 'owner-report', '2026-10-25'),
  (412, 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=DCD801', 'SaferProducts exact-title DCD801 recall API query', 'other', '2026-10-25'),
  (413, 'https://www.amazon.com/dp/B0F94FMBYW', 'Amazon exact DCD801B tool-only destination', 'other', '2026-10-25');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (49, 406, 'Exact U.S. DCD801B tool-only identity, package boundary, and manufacturer specifications'),
  (49, 407, 'Confirmation that the owner-report DCD801QQ2 kit contains a DCD801 drill/driver'),
  (49, 408, 'Type 1 operation, maintenance, cleaning, and repair-path boundaries'),
  (49, 409, 'Type 1 live model status and dated individual-part orderability and stock snapshot'),
  (49, 410, 'Type 1 exploded assembly documentation'),
  (49, 83, 'DEWALT spare-parts ordering policy and ServiceNet path'),
  (49, 241, 'DEWALT manuals, parts-list, and diagram support path'),
  (49, 243, 'Manufacturer warranty-repair service-center path'),
  (49, 2, 'DEWALT warranty terms'),
  (49, 411, 'Bounded exact-tool owner report from a separately identified kit package'),
  (49, 403, 'Bounded manufacturer safety-notice review'),
  (49, 412, 'Bounded exact-title federal recall query with empty result'),
  (49, 413, 'Exact DCD801B commercial destination verified without price, rating, seller, or availability claims');

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
  (387, 49, 'identity', 'DCD801B 20V MAX XR brushless 1/2-inch drill/driver, tool-only, Type 1', 'Exact U.S. DEWALT DCD801B 20V MAX XR brushless 1/2-inch drill/driver, tool-only; Type 1 evidence reviewed. It has the ANTI-ROTATION system, 0-650 and 0-2,000 RPM settings, a 1/2-inch metal ratcheting chuck, and a 70-lumen adjustable worklight.', 'T2', 406, '2026-10-25', 180),
  (388, 49, 'parts_availability', 'partial', 'Partial — the October 25, 2026 ServiceNet Type 1 snapshot marked 22 entries purchasable. The housing, motor-and-switch assembly, sensor, and selector showed positive numeric stock. The transmission was marked purchasable and inStock while its numeric stock level read zero, so the snapshot is internally inconsistent and does not guarantee current checkout, future stock, or complete component-level support.', 'T2', 409, '2026-10-25', 30),
  (389, 49, 'repair_manual', 'false', 'No comprehensive internal repair manual verified. The Type 1 owner manual covers operation, adjustment, routine maintenance, weekly cleaning, and safety, then directs repairs, maintenance, and adjustment to factory or authorized service centers.', 'T2', 408, '2026-10-25', 365),
  (390, 49, 'serviceability', 'shop-serviceable', 'Shop-serviceable through DEWALT service centers. Owner guidance includes blowing dust from air vents with clean, dry air at least weekly and cleaning nonmetallic exterior parts with water and mild soap; internal repair is not documented as an owner procedure.', 'T2', 408, '2026-10-25', 180),
  (391, 49, 'warranty', '3-year limited warranty; 1-year free service; 90-day money-back guarantee', 'DEWALT states a three-year limited warranty, one-year free service, and 90-day money-back guarantee for covered products, subject to the published terms and exclusions.', 'T2', 2, '2026-10-25', 180),
  (392, 49, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-25', 180),
  (393, 49, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-25', 30),
  (394, 49, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-25', 180);

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
  49,
  'partial',
  'https://www.toolservicenet.com/en//Dewalt/CORDLESS-DRILLS/DRILLS%2C-20V/20V-MAX-XR-DRILL-DRIVER---BARE/p/DCD801B_1',
  0,
  'https://assets.dewalt.com/GLOBALBOM/QU/DCD801B/1/Instruction_Manual/EN/NA283252_man_cordless_drill_drivers_DCD801_DCD806_NA.pdf',
  'shop-serviceable',
  NULL,
  409,
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
  49,
  '3-year limited warranty; 1-year free service; 90-day money-back guarantee',
  'The published policy covers repair without charge for defects due to faulty materials or workmanship for three years from purchase and includes one year of free maintenance/service on covered DEWALT tools.',
  'The published policy excludes part failure due to normal wear or tool abuse and is subject to DEWALT''s full terms, proof-of-purchase, product, and regional conditions.',
  2,
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
  49,
  49,
  'Amazon Associates',
  'https://www.amazon.com/dp/B0F94FMBYW?tag=everlastin08f-20',
  1,
  '2026-10-25'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '57');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-25');

COMMIT;
