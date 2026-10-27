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
  52,
  'makita-xfd15zb',
  'Makita',
  'XFD15',
  'XFD15ZB',
  'drill-drivers',
  'tools-shop',
  'Exact U.S. XFD15ZB 18V LXT Sub-Compact brushless 1/2-inch driver-drill tool-only package. Makita states that the battery and charger are not included. Do not transfer these findings to the XFD15SY1B one-battery kit, XFD15RB two-battery kit, XPH15ZB hammer driver-drill, XFD16 products, combo kits, batteries, chargers, regional DDF packages, or another model or revision.',
  'T2',
  'not-yet-verified',
  'Makita identifies the exact XFD15ZB tool-only driver-drill and publishes an XFD15 instruction manual and illustrated parts breakdown. The October 2026 Makita parts price list contains 11 entries whose descriptions name XFD15, including the gear assembly, housing set, rotor, controller, stator, and terminal; list presence does not prove on-hand stock, successful checkout, compatibility with every revision, or future supply. In a December 2024 Reddit thread, one commenter says an XFD15 paired with a 1.5Ah battery is amazing and highly recommended, but does not identify whether the tool came from the XFD15ZB package or a kit and provides no purchase date, ownership duration, workload, or repair history. The exact-title SaferProducts recall query returned an empty result during the bounded review; that is not safety clearance. Expected service life, representative failure rate, maintenance cost, repair economics, and a Buy-It-for-Life recommendation remain not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified. The accepted XFD15 tool-family owner evidence is one undated-duration positive comment without original package, workload, or repair history, not representative long-term durability evidence.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-27',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (428, 'https://www.makitatools.com/products/details/XFD15ZB', 'Makita USA XFD15ZB 18V LXT Sub-Compact brushless driver-drill product page', 'manufacturer', '2026-10-27'),
  (429, 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/cac6dead-d147-406d-ba4b-19ef50ba65e4_XFD15_IM_885850-949.pdf', 'Makita XFD15 cordless driver-drill instruction manual', 'manufacturer', '2026-10-27'),
  (430, 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/2ff76fd6-57f3-49ab-b2a7-56d05d27421e_XFD15_PB_Breakdown_XFD15RB,ZB_06-21.pdf', 'Makita XFD15RB and XFD15ZB illustrated parts breakdown dated June 2021', 'manufacturer', '2026-10-27'),
  (431, 'https://www.reddit.com/r/Makita/comments/1h4ud5v/advice_on_drill/', 'Reddit Makita thread with bounded exact-model XFD15 owner comment', 'owner-report', '2026-10-27'),
  (432, 'https://www.saferproducts.gov/RestWebServices/Recall?format=json&RecallTitle=XFD15ZB', 'SaferProducts exact-title XFD15ZB recall API query', 'other', '2026-10-27'),
  (433, 'https://www.amazon.com/dp/B09BXZTGR1', 'Amazon exact Makita XFD15ZB tool-only destination', 'other', '2026-10-27');

UPDATE sources SET retrieved_date = '2026-10-27'
WHERE id IN (8, 111, 394);

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (52, 428, 'Exact U.S. XFD15ZB tool-only identity, package boundary, and manufacturer specifications'),
  (52, 429, 'Operation, inspection, maintenance, and authorized-service boundaries'),
  (52, 430, 'Illustrated XFD15RB and XFD15ZB component breakdown dated June 2021'),
  (52, 394, 'October 2026 manufacturer price-list entries for model-labeled XFD15 components'),
  (52, 111, 'Factory, authorized, and direct-repair service routes'),
  (52, 8, 'Makita lithium-ion tool warranty term and exclusions'),
  (52, 431, 'Bounded XFD15 tool-family positive owner comment without original package, ownership duration, or repair history'),
  (52, 432, 'Bounded exact-title federal recall query with empty result'),
  (52, 433, 'Exact XFD15ZB commercial destination verified without price, rating, seller, or availability claims');

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
  (411, 52, 'identity', 'XFD15ZB 18V LXT Sub-Compact brushless cordless 1/2-inch driver-drill, tool only', 'Exact U.S. Makita XFD15ZB 18V LXT Sub-Compact brushless 1/2-inch driver-drill, tool only. Makita documents a 5-7/8-inch length, 350 in.lbs. maximum torque, two-speed 0-500 and 0-1,700 RPM transmission, and dual L.E.D. work lights.', 'T2', 428, '2026-10-27', 180),
  (412, 52, 'parts_availability', 'partial', 'Partial — the October 2026 Makita manufacturer price list contains 11 entries whose descriptions name XFD15, including the gear assembly, housing set, rotor, controller, stator, and terminal. The June 2021 breakdown documents additional component numbers. List presence does not confirm on-hand stock, successful checkout, revision compatibility, or future supply.', 'T2', 394, '2026-10-27', 90),
  (413, 52, 'repair_manual', 'false', 'No comprehensive internal repair manual verified. The XFD15 instruction manual covers operation, inspection, maintenance, battery care, accessory setup, and basic troubleshooting, while the separate illustrated breakdown identifies components without providing diagnostic or internal repair procedures.', 'T2', 429, '2026-10-27', 365),
  (414, 52, 'serviceability', 'shop-serviceable', 'Shop-serviceable through Makita authorized or factory service centers. Owner guidance includes using a dry cloth to clean the work-light lens and routine inspection, but repairs, other maintenance, and adjustment are directed to Makita service using Makita replacement parts.', 'T2', 429, '2026-10-27', 180),
  (415, 52, 'warranty', '3-year limited warranty for Makita lithium-ion tools', 'Makita states a three-year limited warranty for lithium-ion tools against defects in workmanship and materials, subject to the published terms and exclusions for attempted third-party repairs, normal wear, abuse, misuse, improper maintenance or operation, non-genuine batteries, and alterations.', 'T2', 8, '2026-10-27', 180),
  (416, 52, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-27', 180),
  (417, 52, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-27', 30),
  (418, 52, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-27', 180);

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
  52,
  'partial',
  'https://cdn.makitatools.com/apps/PriceManagement/upload/Oct%202026%20Parts%20Price%20List_2026_10_16_0637AM.xlsx',
  0,
  'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/cac6dead-d147-406d-ba4b-19ef50ba65e4_XFD15_IM_885850-949.pdf',
  'shop-serviceable',
  NULL,
  394,
  '2026-10-27'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  52,
  '3-year limited warranty for Makita lithium-ion tools',
  'Makita states that covered lithium-ion tools are warranted against defects in workmanship and materials for three years from original purchase and may be repaired or replaced after inspection.',
  'Published exclusions include attempted third-party repairs, normal wear, abuse, misuse, improper maintenance or operation, use of non-genuine batteries, and alterations.',
  8,
  '2026-10-27'
);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  52,
  52,
  'Amazon Associates',
  'https://www.amazon.com/dp/B09BXZTGR1?tag=everlastin08f-20',
  1,
  '2026-10-27'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '61');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-27');

COMMIT;
