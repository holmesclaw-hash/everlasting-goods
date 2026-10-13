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
  42,
  'moccamaster-kbgv-select-53948',
  'Moccamaster',
  'KBGV Select',
  '53948',
  'drip-coffee-makers',
  'kitchen',
  'This exact commercial record is for the U.S. Moccamaster KBGV Select 10-cup brewer in Matte Black, model 53948, with a 40-ounce glass carafe and half- or full-carafe selector. Other KBGV colors have separate model numbers. The photographed 15-year-old K741.64B in the related editorial guide is historical family evidence, not the same model, and its service duration is not transferred to the current 53948.',
  'T2',
  'not-yet-verified',
  'Current manufacturer documentation establishes the KBGV Select configuration, separately sold external parts, a factory repair channel, a five-year original-purchaser warranty, and required cleaning and descaling. A five-year owner report concerns a Moccamaster family machine without proving the exact 53948 configuration, while the 15-year K741.64B and roughly 30-year inherited machine are different historical models. Exact-53948 expected service life, representative failure rate, repair economics, and a repair-versus-replace recommendation are not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; long-duration evidence reviewed for older or incompletely identified Moccamaster family machines cannot establish the expected service life of exact model 53948.',
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-10-13',
  NULL,
  NULL,
  NULL
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (317, 'https://us.moccamaster.com/products/kbgv', 'Moccamaster KBGV Select official U.S. product page', 'manufacturer', '2026-10-13'),
  (318, 'https://support.moccamaster.com/hc/en-us/article_attachments/1500014339002', 'Moccamaster KBGV Select official owner manual', 'manufacturer', '2026-10-13'),
  (319, 'https://us.moccamaster.com/collections/kbgv-select-coffee-brewer-parts', 'Moccamaster KBGV Select replacement-parts catalog', 'manufacturer', '2026-10-13'),
  (320, 'https://support.moccamaster.com/hc/en-us/articles/1500009429481-Can-I-get-my-Moccamaster-repaired', 'Moccamaster USA factory repair program', 'manufacturer', '2026-10-13'),
  (321, 'https://support.moccamaster.com/hc/en-us/articles/1500012391061-What-is-the-warranty-on-my-Moccamaster-brewer', 'Moccamaster USA brewer warranty terms', 'manufacturer', '2026-10-13'),
  (322, 'https://commons.wikimedia.org/wiki/File:Technivorm_Moccamaster_K741.64B.jpg', 'Wikimedia Commons 15-year-old Technivorm Moccamaster K741.64B owner photograph', 'owner-report', '2026-10-13'),
  (323, 'https://www.reddit.com/r/BuyItForLife/comments/1356i6h/five_years_with_a_moccamaster/', 'Reddit five-year Moccamaster owner report', 'owner-report', '2026-10-13'),
  (324, 'https://www.reddit.com/r/BuyItForLife/comments/1nvw5m5/my_moccamaster_has_been_brewing_for_30_years_and/', 'Reddit inherited roughly 30-year Moccamaster owner report', 'owner-report', '2026-10-13'),
  (325, 'https://bestreviews.com/kitchen/coffee-accessories/technivorm-moccamaster--53923-kbgv-select-coffee-maker-juniper', 'BestReviews KBGV Select independent testing report', 'other', '2026-10-13'),
  (326, 'https://device.report/technivorm-moccamaster/53948', 'Model 53948 and ASIN B093DXS54M commercial identity corroboration', 'other', '2026-10-13'),
  (327, 'https://www.amazon.com/dp/B093DXS54M', 'Amazon exact Moccamaster 53948 KBGV Select destination', 'other', '2026-10-13');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (42, 317, 'current KBGV Select identity, capacity, glass-carafe configuration, selector, shutoff, construction, care, and color family'),
  (42, 318, 'owner operation, cleaning, descaling, troubleshooting, safety boundaries, and no-user-serviceable-parts warning'),
  (42, 319, 'current exact-family external replacement-parts catalog and older-brewer support statement'),
  (42, 320, 'manufacturer flat-rate factory repair route and repaired-brewer warranty'),
  (42, 321, 'five-year original-purchaser warranty, exclusions, and registration guidance'),
  (42, 322, 'bounded 15-year historical K741.64B evidence with replacement reservoir; different-model boundary'),
  (42, 323, 'bounded five-year Moccamaster owner report without exact 53948 identity'),
  (42, 324, 'bounded roughly 30-year inherited historical Moccamaster report without exact current-model identity'),
  (42, 325, 'independent KBGV Select usability and construction tradeoffs; not long-term lifespan evidence'),
  (42, 326, 'commercial corroboration mapping model 53948 to Matte Black KBGV Select and ASIN B093DXS54M'),
  (42, 327, 'exact commercial destination');

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
  (329, 42, 'identity', 'Moccamaster KBGV Select; model 53948; Matte Black; 10 cup; 40 oz; glass carafe; half/full selector; automatic drip-stop; automatic shutoff', 'Exact U.S. model 53948 KBGV Select in Matte Black: a 40-ounce, glass-carafe brewer with a half- or full-carafe selector, automatic drip-stop, and automatic shutoff.', 'T2', 317, '2026-10-13', 180),
  (330, 42, 'parts_availability', 'partial', 'Partial: Moccamaster sells KBGV Select carafes, brew baskets, lids, an outlet arm, switches, and other external pieces, and says it supports parts for some older brewers; the reviewed catalog does not establish open ordering for every internal component.', 'T1', 319, '2026-10-13', 90),
  (331, 42, 'repair_manual', 'not-comprehensive', 'The owner manual covers operation, cleaning, descaling, troubleshooting, and safety limits, but states that no user-serviceable parts are inside and is not an internal repair manual.', 'T1', 318, '2026-10-13', 180),
  (332, 42, 'serviceability', 'shop-serviceable', 'Owners can clean, descale, and replace documented external parts; internal faults follow Moccamaster USA’s factory repair path because the manual identifies no user-serviceable internal parts.', 'T1', 320, '2026-10-13', 180),
  (333, 42, 'warranty', '5-year limited warranty', 'Five-year limited warranty for the original purchaser of a new brewer bought from an authorized retailer; the glass carafe and parts are excluded, and coverage is not transferable.', 'T1', 321, '2026-10-13', 180),
  (334, 42, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-13', 90),
  (335, 42, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-13', 30),
  (336, 42, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-13', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  42,
  42,
  'Amazon Associates',
  'https://www.amazon.com/dp/B093DXS54M?tag=everlastin08f-20',
  1,
  '2026-10-13'
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
  42,
  'partial',
  'https://us.moccamaster.com/collections/kbgv-select-coffee-brewer-parts',
  0,
  'https://support.moccamaster.com/hc/en-us/article_attachments/1500014339002',
  'shop-serviceable',
  NULL,
  320,
  '2026-10-13'
);

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
) VALUES (
  42,
  '5 years limited warranty',
  'Moccamaster USA warrants a new brewer to the original purchaser for five years from the purchase date against defects in materials and workmanship, subject to its current terms.',
  'The warranty is not transferable, excludes the glass carafe and parts, and excludes misuse, improper cleaning or descaling, unauthorized modification or repair, and other published conditions.',
  321,
  '2026-10-13'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '47');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-13');

COMMIT;
