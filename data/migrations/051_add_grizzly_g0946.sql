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
  46,
  'grizzly-g0946',
  'Grizzly',
  'G0946',
  'G0946',
  'benchtop-jointers',
  'tools-shop',
  'This exact record is for the current U.S. G0946 six-inch benchtop jointer with a 1-1/2 HP, 120V single-phase 10A universal motor, belt drive, six-row spiral-type cutterhead, and 12 two-sided 14 x 14 x 2 mm HSS inserts. The current V3.11.23 combined G0945/G0946/G0947 manual applies to machines manufactured since 12/23; owners must use the manufacture date on the machine ID label when matching manuals and revision-marked parts. G0945 straight-knife, G0947 eight-inch, G0986 ten-inch, and other jointer specifications and owner histories are not transferred to G0946. Official insert information conflicts: the current product specifications identify 12 HSS inserts, the manual parts list labels P0946160-2 as carbide, the product page calls the larger T32739 carbide insert compatible but says all 26 must be replaced despite listing 12 inserts, and the current parts page maps P0946160-2 to T32937, described there as a saw-blade/scoring product rather than an insert. These conflicts are preserved, and this record does not advise a full insert change without confirmation from Grizzly.',
  'T2',
  'not-yet-verified',
  'An exact-model owner post published April 5, 2024 describes easy initial setup, portability, and satisfactory early-use results on 6/4 rough cherry. It does not provide multi-year ownership, repair history, or sustained workload evidence. This is one early-use anecdote, not representative durability data; expected service life, failure rate, annual maintenance cost, repair economics, and a repair-versus-replace recommendation are not yet verified. A bounded exact-model recall API query returned an empty array, which is not safety clearance.',
  NULL,
  NULL,
  NULL,
  'Not yet verified; the accepted exact-model evidence is one April 2024 early-use report without multi-year ownership duration or repair history.',
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
  (372, 'https://www.grizzly.com/products/grizzly-6-benchtop-jointer-with-spiral-type-cutterhead/g0946', 'Grizzly G0946 official product page and current specifications', 'manufacturer', '2026-10-15'),
  (373, 'https://cdn0.grizzly.com/specsheets/g0946_ds.pdf', 'Grizzly G0946 specification sheet as of October 14, 2026', 'manufacturer', '2026-10-15'),
  (374, 'https://cdn0.grizzly.com/manuals/g0946_m.pdf', 'Grizzly G0945 G0946 G0947 owner manual V3.11.23 for machines manufactured since December 2023', 'manufacturer', '2026-10-15'),
  (375, 'https://www.grizzly.com/products/g0946/parts', 'Grizzly G0946 revision-aware online parts catalog', 'manufacturer', '2026-10-15'),
  (376, 'https://www.grizzly.com/products/grizzly-indexable-carbide-inserts-14.25-x-14.25-x-2mm-10-pk./t32739', 'Grizzly T32739 replacement carbide insert page naming G0946 compatibility', 'manufacturer', '2026-10-15'),
  (377, 'https://www.lumberjocks.com/threads/review-grizzly-g0946-6-inch-bench-top-spiral-head-jointer.357799/', 'LumberJocks April 2024 exact G0946 early-use owner report', 'owner-report', '2026-10-15'),
  (378, 'https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0946&format=json', 'SaferProducts exact-model G0946 recall API query', 'other', '2026-10-15'),
  (379, 'https://support.grizzly.com/hc/en-us/articles/4404772793495-Grizzly-Terms-Conditions', 'Grizzly website terms and image-reuse restrictions', 'manufacturer', '2026-10-15'),
  (380, 'https://www.amazon.com/dp/B0B75GFZ98', 'Amazon exact Grizzly G0946 commercial destination', 'other', '2026-10-15');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (46, 372, 'current exact-model identity, specifications, stock-insert material, replacement-insert claim, and contradictory 26-insert instruction'),
  (46, 373, 'current exact G0946 electrical, motor, cutterhead, insert, table, construction, dimension, and warranty specifications'),
  (46, 374, 'manufacture-date scope, maintenance, troubleshooting, insert service, table and fence adjustment, belt and motor-brush replacement, wiring, and illustrated parts'),
  (46, 375, 'revision-aware exact-model parts catalog, item-level order controls, substitutions, and availability limits'),
  (46, 376, 'manufacturer claim that the 14.25 x 14.25 x 2 mm T32739 carbide insert fits G0946'),
  (46, 301, 'manufacturer parts-purchasing route, current and legacy listings, substitutions, and availability limits'),
  (46, 251, 'manufacturer depot repair route and required serial and manufacture-date information'),
  (46, 65, 'one-year house-brand limited warranty terms and exclusions'),
  (46, 377, 'bounded April 2024 exact-model early-use report without long ownership duration'),
  (46, 255, 'current Grizzly recalled-items page and related-model recall boundary'),
  (46, 378, 'bounded exact-model recall API query returning no results; not safety clearance'),
  (46, 379, 'manufacturer image-rights restriction and article image-gate evidence'),
  (46, 380, 'exact commercial destination');

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
  (361, 46, 'identity', 'Grizzly G0946; benchtop jointer; 6 in.; 1-1/2 HP; 120V; single-phase; 10A; universal motor; belt drive; six-row spiral-type cutterhead; 12 two-sided HSS inserts; 14 x 14 x 2 mm; 11,000 RPM; 30 x 6-1/4 in. cast-aluminum table', 'Exact current U.S. G0946 six-inch benchtop jointer with a 1-1/2 HP, 120V single-phase 10A universal motor, belt drive, six-row spiral-type cutterhead, 12 two-sided HSS inserts measuring 14 x 14 x 2 mm, 11,000 RPM cutterhead speed, and a 30 x 6-1/4-inch cast-aluminum table.', 'T1', 373, '2026-10-15', 180),
  (362, 46, 'parts_availability', 'partial', 'Partial: the exact-model catalog currently displays order controls for the table assembly, table, cutterhead assembly, and some smaller parts, while the manual separately identifies the Poly-V belt, 6201ZZ bearing, motor, carbon brushes, paddle switch, power cord, fence, guard, and other components. The T32739 replacement-insert page separately names G0946 compatibility. Not every listed component was independently confirmed orderable, and manufacture-date and insert-compatibility conflicts require confirmation.', 'T1', 375, '2026-10-15', 90),
  (363, 46, 'repair_manual', 'not-comprehensive', 'The owner manual covers maintenance, troubleshooting, insert rotation and replacement, table parallelism, fence positive-stop adjustment, belt tension and replacement, motor-brush replacement, wiring, and illustrated parts. It is substantial owner and service guidance, not a comprehensive internal repair manual for every subsystem or production revision.', 'T1', 374, '2026-10-15', 180),
  (364, 46, 'serviceability', 'shop-serviceable', 'Owners can rotate or replace individual cutterhead inserts, tension or replace the belt, replace motor brushes, and adjust table parallelism and fence stops using published procedures. Electrical diagnosis and work beyond the documented procedures should follow the manual and qualified-service boundaries.', 'T1', 374, '2026-10-15', 180),
  (365, 46, 'warranty', '1-year limited warranty', 'One-year limited warranty for the original purchaser; proof of purchase is required, and consumables, misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, and lack of maintenance are excluded.', 'T1', 65, '2026-10-15', 180),
  (366, 46, 'insert_compatibility', 'official sources conflict', 'Official sources conflict: the current specifications identify 12 two-sided HSS inserts at 14 x 14 x 2 mm; the current manual parts list labels P0946160-2 as a carbide insert at that size; Grizzly names the larger 14.25 x 14.25 x 2 mm T32739 carbide insert as G0946-compatible but the product page says all 26 must be replaced despite listing 12 inserts; and the current parts page maps P0946160-2 to T32937, described there as a saw-blade/scoring product rather than an insert. Confirm a complete replacement set and procedure with Grizzly before purchase or installation.', 'T2', 372, '2026-10-15', 90),
  (367, 46, 'expected_service_life', NULL, 'Not yet verified', 'T4', NULL, '2026-10-15', 90),
  (368, 46, 'street_price', NULL, 'Not yet verified', 'T4', NULL, '2026-10-15', 30),
  (369, 46, 'annual_maintenance_cost', NULL, 'Not yet verified', 'T4', NULL, '2026-10-15', 90);

INSERT INTO affiliate_links (
  id,
  product_id,
  program_name,
  url,
  exact_model,
  verified_date
) VALUES (
  46,
  46,
  'Amazon Associates',
  'https://www.amazon.com/dp/B0B75GFZ98?tag=everlastin08f-20',
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
  46,
  'partial',
  'https://www.grizzly.com/products/g0946/parts',
  0,
  'https://cdn0.grizzly.com/manuals/g0946_m.pdf',
  'shop-serviceable',
  NULL,
  375,
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
  46,
  '1 year limited warranty',
  'Grizzly warrants the machine to the original purchaser for one year from purchase against covered defects, subject to its current terms and proof-of-purchase requirement.',
  'The warranty excludes consumables, misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, and lack of maintenance; third-party repair and transportation expenses are not reimbursed.',
  65,
  '2026-10-15'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '51');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-10-15');

COMMIT;
