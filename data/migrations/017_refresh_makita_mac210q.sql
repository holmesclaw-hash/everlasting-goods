PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://cdn.makitatools.com/apps/cms/doc/prod/MAC/79423a15-98e1-4185-b52b-d513cfbf30ec_MAC100Q_IM.pdf', 'Makita Quiet Series MAC100Q/MAC210Q/MAC320Q instruction manual', 'manufacturer', '2026-09-21'),
  ('https://www.makita.ca/data/upload/parts_breakdown/MAC210Q%20-%20JUN2025.pdf', 'Makita MAC210Q May 2025 parts breakdown', 'manufacturer', '2026-09-21'),
  ('https://www.reddit.com/r/Makita/comments/17deniq/choosing_between_compressors', 'Exact-model MAC210Q owner workload report', 'owner-report', '2026-09-21'),
  ('https://www.amazon.com/dp/B08GYFBQV1', 'Renewed MAC210Q owner report after about one year', 'owner-report', '2026-09-21');

UPDATE sources
SET retrieved_date = '2026-09-21'
WHERE url IN (
  'https://www.makitatools.com/products/details/MAC210Q',
  'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/4ee5e20d-9b00-4a9c-81c3-175c3d0dabb3_MAC210Q_NTFE.pdf',
  'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/e873ff0c-05fb-4bd9-91b6-d0a120917ccb_MAC210Q_PB_Breakdown_MAC210Q_05-20.pdf',
  'https://www.makitatools.com/service/warranty'
);

UPDATE sources
SET title = 'Makita MAC210Q new-tool overview'
WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/4ee5e20d-9b00-4a9c-81c3-175c3d0dabb3_MAC210Q_NTFE.pdf';

UPDATE products
SET variant_notes = 'MAC210Q identifies the U.S. 120V, 1 HP, 2-gallon oil-free Quiet Series compressor package with one 1/4-inch universal quick coupler. Evidence for other voltages or renewed MAC210Q-R condition is qualified separately.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports the exact 120V package, a current component-level parts breakdown, routine owner maintenance, authorized service, and a one-year general-product warranty. One exact-model owner reports driving close to 3,500 framing nails while finishing a basement and successful trim-nailer use; a separate renewed-unit owner reports repeated use and correct operation after about one year. Those reports do not establish representative multi-year durability for a new MAC210Q, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-09-21'
WHERE id = 15 AND slug = 'makita-mac210q';

INSERT OR IGNORE INTO product_sources
SELECT 15, id, 'exact-model operating and maintenance manual' FROM sources
WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/79423a15-98e1-4185-b52b-d513cfbf30ec_MAC100Q_IM.pdf';
INSERT OR IGNORE INTO product_sources
SELECT 15, id, 'current exact-model component parts breakdown' FROM sources
WHERE url = 'https://www.makita.ca/data/upload/parts_breakdown/MAC210Q%20-%20JUN2025.pdf';
INSERT OR IGNORE INTO product_sources
SELECT 15, id, 'qualified exact-model owner workload evidence' FROM sources
WHERE url = 'https://www.reddit.com/r/Makita/comments/17deniq/choosing_between_compressors';
INSERT OR IGNORE INTO product_sources
SELECT 15, id, 'qualified one-year renewed-unit owner evidence' FROM sources
WHERE url = 'https://www.amazon.com/dp/B08GYFBQV1';

UPDATE product_fields
SET raw_value = 'MAC210Q is the U.S. 120V Quiet Series compressor with a 1 HP induction motor, 2-gallon oil-free dual-piston pump, 2 CFM at 90 PSI, 135 PSI maximum pressure, and one included 1/4-inch universal quick coupler.',
    display_value = '120V, 1 HP, 2-gallon oil-free compressor rated at 2 CFM at 90 PSI with one quick coupler.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/products/details/MAC210Q'),
    verified_date = '2026-09-21',
    reverify_days = 180
WHERE product_id = 15 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Makita publishes a May 2025 exact-model breakdown identifying replaceable assemblies and components including the motor assembly, reed-valve head, piston ring, air-filter set, check valve, switch, capacitor, tank, safety valve, regulator, gauges, coupler, and drain valve. The document is a parts list, not proof that every component is currently orderable.',
    display_value = 'Partial: a May 2025 exact-model parts breakdown identifies component part numbers; current orderability is not verified.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makita.ca/data/upload/parts_breakdown/MAC210Q%20-%20JUN2025.pdf'),
    verified_date = '2026-09-21',
    reverify_days = 90
WHERE product_id = 15 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Makita publishes an exact-family instruction manual covering the MAC210Q with setup, operation, tank draining, air-filter care, safety-valve and check-valve inspection, troubleshooting, and storage. It directs abnormal operation and repairs to authorized service and is not a component-repair manual.',
    display_value = 'Official operating and maintenance manual is available; it is not a component-repair manual.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/79423a15-98e1-4185-b52b-d513cfbf30ec_MAC100Q_IM.pdf'),
    verified_date = '2026-09-21',
    reverify_days = 180
WHERE product_id = 15 AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The manual documents owner procedures for draining the tank after use, keeping the air filter clean, checking the safety valve, yearly check-valve inspection, and keeping fasteners tight. Abnormal operation and other repair work are routed to Makita authorized service.',
    display_value = 'User-serviceable for tank draining, air-filter cleaning, and safety/check-valve inspection; repairs go to authorized service.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/79423a15-98e1-4185-b52b-d513cfbf30ec_MAC100Q_IM.pdf'),
    verified_date = '2026-09-21',
    reverify_days = 180
WHERE product_id = 15 AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Makita covers general products against defects in workmanship and materials for one year from original purchase and may repair or replace after inspection. Current limitations, exclusions, and claim requirements apply.',
    display_value = '1-year general-product limited warranty from original purchase; current Makita terms apply.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
    verified_date = '2026-09-21',
    reverify_days = 180
WHERE product_id = 15 AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-09-21'
WHERE product_id = 15 AND name IN ('expected_service_life', 'street_price', 'annual_maintenance_cost');

INSERT INTO warranties (
  product_id, warranty_length, warranty_coverage, warranty_exclusions, source_id, verified_date
) VALUES (
  15,
  '1-year limited warranty.',
  'Defects in workmanship and materials for Makita products; Makita may repair or replace after inspection.',
  'Repairs made or attempted by others, normal wear and tear, abuse, misuse, improper maintenance or operation, and alterations are excluded; current Makita terms apply.',
  (SELECT id FROM sources WHERE url = 'https://www.makitatools.com/service/warranty'),
  '2026-09-21'
)
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.makita.ca/data/upload/parts_breakdown/MAC210Q%20-%20JUN2025.pdf',
    repair_manual_available = 0,
    repair_manual_url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/79423a15-98e1-4185-b52b-d513cfbf30ec_MAC100Q_IM.pdf',
    serviceability = 'user-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/MAC/79423a15-98e1-4185-b52b-d513cfbf30ec_MAC100Q_IM.pdf'),
    verified_date = '2026-09-21'
WHERE product_id = 15;

UPDATE affiliate_links
SET verified_date = '2026-09-21'
WHERE product_id = 15
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B084GYHQFY?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '17');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-21');

COMMIT;
