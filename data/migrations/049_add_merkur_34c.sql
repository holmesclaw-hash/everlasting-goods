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
  44,
  'merkur-34c',
  'MERKUR',
  '34C',
  'MK-34001',
  'safety-razors',
  'personal-care',
  'This exact record is for the current North American bright-chrome MERKUR 34C, SKU MK-34001: a two-piece, straight-cut, closed-comb double-edge safety razor with a brass handle and zinc-alloy head. MERKUR also lists bright-gold, matte-chrome, and matte-steel variants; finish-specific identities and destinations must not be transferred without verification. The open-license photograph was made in 2008 and depicts an exact MERKUR 34C, but it is historical visual evidence rather than proof of the current production revision or finish details.',
  'T2',
  'not-yet-verified',
  'Current manufacturer documentation establishes the two-piece MK-34001 configuration, standard double-edge blade format, routine cleaning and drying guidance, a separately sold compatible top plate, and a manufacturer service-request channel. One exact-model owner reported starting with a 34C eight years earlier and using it daily for three years; another reported five years of daily use. These are anecdotal reports about individual razors, and the owner discussion also describes production-revision concerns. Expected service life, representative failure rate, repair economics, and a repair-versus-replace recommendation are not yet verified.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; exact-model owner reports cover individual five- and eight-year histories but do not establish representative service life for the current MK-34001 production revision.',
  NULL,
  '/images/products/merkur-34c-safety-razor.jpg',
  'https://commons.wikimedia.org/wiki/File:Merkur_heavy_duty_safety_razor.jpg',
  'Open-license exact model photograph; historical 2008 configuration, not proof of the current production revision',
  '2026-10-14',
  'https://creativecommons.org/licenses/by-sa/3.0',
  'Hustvedt / Wikimedia Commons',
  'MERKUR 34C bright-chrome two-piece double-edge safety razor photographed from above'
);

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (346, 'https://shopmerkur.com/products/merkur-double-edge-safety-razor-straight-cut-extra-thick-handle-chrome', 'ShopMerkur current North American MERKUR 34C product page', 'manufacturer', '2026-10-14'),
  (347, 'https://merkur-razors.com/produkt/merkur-34c/?lang=en', 'MERKUR 34C official manufacturer product page', 'manufacturer', '2026-10-14'),
  (348, 'https://www.merkur-razors.com/wp-content/uploads/2024/07/safety-razor-two-piece-blade-replacement.pdf', 'MERKUR two-piece safety-razor blade replacement guide', 'manufacturer', '2026-10-14'),
  (349, 'https://www.merkur-razors.com/care-for-shaving-tools/?lang=en', 'MERKUR shaving-tool care guidance', 'manufacturer', '2026-10-14'),
  (350, 'https://www.merkur-razors.com/product-category/safety-razor-spare-parts/?lang=en', 'MERKUR official safety-razor spare-parts catalog', 'manufacturer', '2026-10-14'),
  (351, 'https://shopmerkur.com/products/merkur-34c-top-plate-with-long-screw-in-chrome-finish-mk-90004', 'ShopMerkur MK-90004 Top Plate 34 product page', 'manufacturer', '2026-10-14'),
  (352, 'https://www.merkur-razors.com/customer-service/?lang=en', 'MERKUR manufacturer customer-service and service-request page', 'manufacturer', '2026-10-14'),
  (353, 'https://www.merkur-razors.com/terms-and-conditions/?lang=en', 'MERKUR direct-shop defect-liability and warranty terms', 'manufacturer', '2026-10-14'),
  (354, 'https://www.badgerandblade.com/forum/threads/original-34c-thursdays.656755/', 'Badger & Blade eight-year MERKUR 34C owner report and revision discussion', 'owner-report', '2026-10-14'),
  (355, 'https://www.badgerandblade.com/forum/threads/merkur-34c.612135/', 'Badger & Blade five-year MERKUR 34C daily-use owner report', 'owner-report', '2026-10-14'),
  (356, 'https://commons.wikimedia.org/wiki/File:Merkur_heavy_duty_safety_razor.jpg', 'Wikimedia Commons exact-model MERKUR 34C photograph and license record', 'owner-report', '2026-10-14'),
  (357, 'https://pricehistory.app/p/merkur-mk34c-double-edge-razor-heavy-duty-sS7MGAce', 'ASIN B002A8JO1Q commercial identity corroboration for MERKUR Mk34c', 'other', '2026-10-14'),
  (358, 'https://www.amazon.com/dp/B002A8JO1Q', 'Amazon exact MERKUR 34C destination', 'other', '2026-10-14');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (44, 346, 'current North American exact SKU, two-piece construction, dimensions, weight, blade format, materials, finish, and listed variants'),
  (44, 347, 'manufacturer corroboration of current 34001 identity, two-piece closed-comb configuration, dimensions, weight, materials, and finish'),
  (44, 348, 'official blade-change procedure, two-piece construction, and overtightening boundary'),
  (44, 349, 'manufacturer cleaning, drying, storage, residue-removal, and wear limitations'),
  (44, 350, 'manufacturer spare-parts range and exact 34C top-plate compatibility statement'),
  (44, 351, 'current North American MK-90004 replacement top plate listing and exact 34C compatibility'),
  (44, 352, 'manufacturer product-information, service-request, and complaint channel'),
  (44, 353, 'direct-shop statutory defect liability and absence of a general additional product-specific warranty term'),
  (44, 354, 'bounded eight-year exact-model ownership history, three years of daily use, and anecdotal revision concern'),
  (44, 355, 'bounded exact-model five-year daily-use owner report'),
  (44, 356, 'exact-model photo identity, author, capture date, dimensions, and CC BY-SA 3.0 rights'),
  (44, 357, 'commercial corroboration mapping ASIN B002A8JO1Q to MERKUR Mk34c Heavy Duty short-handle razor'),
  (44, 358, 'exact commercial destination');

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
  (345, 44, 'identity', 'MERKUR 34C; MK-34001; two-piece; straight cut; closed comb; standard double-edge blade; brass handle; zinc-alloy head; bright chrome; 78 g; 81 x 43 x 25 mm product measurements', 'Exact current North American SKU MK-34001: a 78-gram, two-piece, straight-cut closed-comb razor using standard double-edge blades, with a brass handle, zinc-alloy head, bright-chrome finish, and listed product measurements of 81 x 43 x 25 mm.', 'T1', 346, '2026-10-14', 180),
  (346, 44, 'parts_availability', 'partial', 'Partial: MERKUR sells the compatible MK-90004 bright-chrome Top Plate 34 with a long screw for the 34C, but separate current ordering for the base plate, complete handle, internal expansion ring, and every structural component was not verified.', 'T1', 351, '2026-10-14', 90),
  (347, 44, 'repair_manual', 'not-comprehensive', 'The manufacturer publishes a model-family blade-change guide and separate care instructions; these cover consumable replacement, cleaning, drying, and overtightening avoidance, not a comprehensive structural repair manual.', 'T1', 348, '2026-10-14', 180),
  (348, 44, 'serviceability', 'user-serviceable', 'Owners can replace the standard double-edge blade, clean and dry the razor, and replace the separately sold compatible top plate; other defects or unavailable structural parts follow MERKUR’s service-request channel.', 'T1', 351, '2026-10-14', 180),
  (349, 44, 'warranty', 'no product-specific term verified', 'No product-specific additional manufacturer warranty term was verified. MERKUR’s direct-shop terms apply statutory defect liability and say any additional warranty must be separately stated; coverage can therefore depend on the purchase channel.', 'T1', 353, '2026-10-14', 180),
  (350, 44, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-14', 90),
  (351, 44, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-14', 30),
  (352, 44, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-14', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  44,
  44,
  'Amazon Associates',
  'https://www.amazon.com/dp/B002A8JO1Q?tag=everlastin08f-20',
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
  44,
  'partial',
  'https://shopmerkur.com/products/merkur-34c-top-plate-with-long-screw-in-chrome-finish-mk-90004',
  0,
  'https://www.merkur-razors.com/wp-content/uploads/2024/07/safety-razor-two-piece-blade-replacement.pdf',
  'user-serviceable',
  NULL,
  351,
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
  44,
  'No product-specific term verified',
  'MERKUR’s direct-shop terms apply statutory defect liability unless an additional warranty is separately stated; the reviewed 34C product pages do not publish a separate product-specific warranty term.',
  'Purchase-channel and jurisdiction terms can differ; no universal U.S. duration or transferable lifetime warranty is claimed.',
  353,
  '2026-10-14'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '49');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-14');

COMMIT;
