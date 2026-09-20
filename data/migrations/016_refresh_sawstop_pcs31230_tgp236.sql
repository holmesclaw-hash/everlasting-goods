PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.sawstop.com/product/pcs-double-pulley-assembly', 'SawStop PCS double pulley assembly', 'manufacturer', '2026-09-20'),
  ('https://www.sawstop.com/product/main-power-cable-pcs31230-pcs175-and-230v-cns', 'SawStop PCS31230 main power cable', 'manufacturer', '2026-09-20'),
  ('https://lumberjocks.com/threads/my-thoughts-on-the-sawstop-professional-table-saw.323061/page-2', 'Several-year SawStop PCS owner report and setup tradeoffs', 'owner-report', '2026-09-20');

UPDATE sources
SET retrieved_date = '2026-09-20'
WHERE url IN (
  'https://www.sawstop.com/product/professional-cabinet-saw-pcs31230-tgp236',
  'https://www.sawstop.com/wp-content/uploads/2021/10/Owners-Manual_Feb-2024.pdf',
  'https://www.sawstop.com/support/warranty-information/',
  'https://www.sawstop.com/product-category/parts/pcs'
);

UPDATE products
SET variant_notes = 'PCS31230 identifies the 3 HP, single-phase, 230V saw body; TGP236 identifies the 36-inch Professional T-Glide fence, rails, and extension-table package. Evidence must match both boundaries when package-specific.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports exact-model maintenance, exploded parts lists, model-compatible replacement components, and a current two-year new-product warranty. A manufacturer-independent owner reports several years with a PCS and continued overall satisfaction while also describing dado-setup interference and other annoyances. That PCS-family anecdote does not independently verify the exact TGP236 rail package, use intensity, or representative durability, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-09-20'
WHERE id = 5 AND slug = 'sawstop-pcs31230-tgp236';

INSERT OR IGNORE INTO product_sources
SELECT 5, id, 'model-compatible replacement component' FROM sources
WHERE url = 'https://www.sawstop.com/product/pcs-double-pulley-assembly';
INSERT OR IGNORE INTO product_sources
SELECT 5, id, 'PCS31230-compatible replacement component' FROM sources
WHERE url = 'https://www.sawstop.com/product/main-power-cable-pcs31230-pcs175-and-230v-cns';
INSERT OR IGNORE INTO product_sources
SELECT 5, id, 'qualified long-term PCS-family owner evidence' FROM sources
WHERE url = 'https://lumberjocks.com/threads/my-thoughts-on-the-sawstop-professional-table-saw.323061/page-2';

UPDATE product_fields
SET raw_value = 'PCS31230-TGP236 is the 3 HP, single-phase, 230V Professional Cabinet Saw package with a 36-inch Professional T-Glide fence system, rails, and extension table.',
    display_value = '3 HP, 230V Professional Cabinet Saw with 36-inch Professional T-Glide fence package.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/product/professional-cabinet-saw-pcs31230-tgp236'),
    verified_date = '2026-09-20',
    reverify_days = 180
WHERE product_id = 5 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The official PCS31230 manual contains cabinet, internal, arbor, blade-guard, and miter-gauge exploded views and parts lists. SawStop also publishes purchasable PCS-compatible components, including the PCS-WA-039 double pulley assembly and PCS-059 230V main power cable; complete current inventory was not verified.',
    display_value = 'Partial: official exploded parts lists and model-compatible replacement components are published; complete inventory is not verified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2021/10/Owners-Manual_Feb-2024.pdf'),
    verified_date = '2026-09-20',
    reverify_days = 90
WHERE product_id = 5 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'SawStop publishes an exact PCS31230 owner manual covering operation, adjustment, troubleshooting, maintenance, exploded views, and parts lists. It is not a comprehensive owner-repair manual.',
    display_value = 'Official owner operating and maintenance manual is available; it is not a comprehensive repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2021/10/Owners-Manual_Feb-2024.pdf'),
    verified_date = '2026-09-20',
    reverify_days = 180
WHERE product_id = 5 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The exact-model manual documents owner procedures for brake-cartridge replacement and inspection, blade and table alignment, belt-tension and gearing adjustments, cabinet cleaning, rust prevention, and lubrication. Exploded parts lists support diagnosis, but the manual does not document every component repair.',
    display_value = 'User-serviceable for brake cartridge work, alignment, belt tension, cleaning, and lubrication; comprehensive repairs are not documented.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2021/10/Owners-Manual_Feb-2024.pdf'),
    verified_date = '2026-09-20',
    reverify_days = 180
WHERE product_id = 5 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'SawStop warrants a new Professional Cabinet Saw bought by the original retail purchaser from an authorized distributor against defects in material or workmanship for two years; refurbished saws receive one year. Current exclusions and claim terms apply.',
    display_value = '2 years new or 1 year refurbished for the original retail purchaser; current SawStop terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/support/warranty-information/'),
    verified_date = '2026-09-20',
    reverify_days = 180
WHERE product_id = 5 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-09-20'
WHERE product_id = 5 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  5,
  '2 years new; 1 year refurbished.',
  'Defects in material or workmanship for the original retail purchaser of a Professional Cabinet Saw purchased from an authorized SawStop distributor.',
  'Misuse, abuse, negligence, accidents, normal wear and tear, unauthorized repair or alteration, and lack of maintenance are excluded; current SawStop terms apply.',
  (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/support/warranty-information/'),
  '2026-09-20'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.sawstop.com/product-category/parts/pcs',
    repair_manual_available = 0,
    repair_manual_url = 'https://www.sawstop.com/wp-content/uploads/2021/10/Owners-Manual_Feb-2024.pdf',
    serviceability = 'user-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.sawstop.com/wp-content/uploads/2021/10/Owners-Manual_Feb-2024.pdf'),
    verified_date = '2026-09-20'
WHERE product_id = 5;

UPDATE affiliate_links
SET verified_date = '2026-09-20'
WHERE product_id = 5
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B009C7NGTE?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '16');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-20');

COMMIT;