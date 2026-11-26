PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.grizzly.com/products/grizzly-10-2-hp-115v-230v-cabinet-saw/g0899', 'Grizzly G0899 official product page', 'manufacturer', '2026-11-26'),
  ('https://cdn0.grizzly.com/manuals/g0899_m.pdf', 'Grizzly G0899 owner-service manual V4.02.26', 'manufacturer', '2026-11-26'),
  ('https://www.grizzly.com/products/g0899/parts', 'Grizzly G0899 exact-model online parts catalog', 'manufacturer', '2026-11-26'),
  ('https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty', 'Grizzly current limited-warranty policy', 'manufacturer', '2026-11-26'),
  ('https://support.grizzly.com/hc/en-us/articles/4405505042839-How-can-I-purchase-parts', 'Grizzly current parts-purchasing and revision policy', 'manufacturer', '2026-11-26'),
  ('https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item', 'Grizzly current factory-repair policy', 'manufacturer', '2026-11-26'),
  ('https://www.reddit.com/r/woodworking/comments/rdhckn/awful_experience_with_grizzly/', 'Reddit: launch-period G0899 quality and service report', 'owner-report', '2026-11-26'),
  ('https://www.reddit.com/r/woodworking/comments/1w68e2p/tablesaw_recommendations/', 'Reddit: September 2026 G0899 owner report without duration', 'owner-report', '2026-11-26'),
  ('https://www.reddit.com/r/woodworking/comments/1qm4thj/major_upgrade_for_me_today_new_cabinet_saw/o1n8a0p/', 'Reddit: G0899 owner report after about five years', 'owner-report', '2026-11-26'),
  ('https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0899&format=json', 'SaferProducts exact-model G0899 recall API query', 'other', '2026-11-26'),
  ('https://www.amazon.com/dp/B08B6G2L6P', 'Amazon exact Grizzly G0899 destination', 'other', '2026-11-26')
ON CONFLICT(url) DO UPDATE SET
  title = excluded.title,
  source_type = excluded.source_type,
  retrieved_date = excluded.retrieved_date;

DELETE FROM product_sources
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899');

INSERT INTO product_sources (product_id, source_id, purpose)
SELECT p.id, s.id, selected.purpose
FROM products p
JOIN (
  SELECT 'https://www.grizzly.com/products/grizzly-10-2-hp-115v-230v-cabinet-saw/g0899' AS url,
         'current exact-model identity, construction, electrical configuration, cutting capacities, specifications, and manufacturer support boundary' AS purpose
  UNION ALL SELECT 'https://cdn0.grizzly.com/manuals/g0899_m.pdf',
         'current V4.02.26 manual for machines manufactured since February 2026, including maintenance, alignment, belt replacement, wiring, and illustrated parts'
  UNION ALL SELECT 'https://www.grizzly.com/products/g0899/parts',
         'dated exact-model catalog snapshot with 316 rendered rows, direct add-to-cart controls, legacy replacement mappings, and unavailable legacy components'
  UNION ALL SELECT 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty',
         'current one-year house-brand warranty, proof requirement, liability boundary, and exclusions'
  UNION ALL SELECT 'https://support.grizzly.com/hc/en-us/articles/4405505042839-How-can-I-purchase-parts',
         'current manufacturer explanation of online diagrams, legacy parts, substitutes, availability labels, and manufacture-date revision matching'
  UNION ALL SELECT 'https://support.grizzly.com/hc/en-us/articles/23294713462167-Can-you-repair-my-item',
         'current technical-support and factory-repair path, authorization, shipping, diagnostic, labor, and parts-availability boundaries'
  UNION ALL SELECT 'https://www.reddit.com/r/woodworking/comments/rdhckn/awful_experience_with_grizzly/',
         'launch-period exact-model anecdote reporting a twisted fence, blade-guard and riving-knife access difficulty, and dust-hose clogging'
  UNION ALL SELECT 'https://www.reddit.com/r/woodworking/comments/1w68e2p/tablesaw_recommendations/',
         'September 2026 exact-model anecdote reporting flat accurate surfaces, a mid-level fence, and minor annoyances without ownership duration'
  UNION ALL SELECT 'https://www.reddit.com/r/woodworking/comments/1qm4thj/major_upgrade_for_me_today_new_cabinet_saw/o1n8a0p/',
         'January 2026 exact-model anecdote reporting about five years of ownership and a positive overall experience without workload or repair history'
  UNION ALL SELECT 'https://www.saferproducts.gov/RestWebServices/Recall?ProductName=G0899&format=json',
         'exact-model recall query returned an empty result on 2026-11-26; not a universal safety clearance'
  UNION ALL SELECT 'https://www.amazon.com/dp/B08B6G2L6P',
         'exact-model commercial destination whose current page title identifies Grizzly Industrial G0899'
) selected
JOIN sources s ON s.url = selected.url
WHERE p.slug = 'grizzly-g0899';

UPDATE products
SET variant_notes = 'G0899 is the exact current 10-inch, 2 HP, single-phase 115V/230V saw configuration. The current owner-service manual is revision V4.02.26 for models manufactured since 02/26, and both the manual and online catalog contain versioned components. Owners must match the machine manufacture date and serial number to the applicable documentation before ordering service parts.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Grizzly currently documents cast-iron tables and trunnions, a revision-bounded owner-service manual, an exact-model online parts catalog, and factory repair support. One January 2026 exact-model owner comment reports having the G0899 for about five years and calls it great, but gives no workload, maintenance, or repair history. A launch-period 2021 owner reported a twisted fence, difficult blade-guard and riving-knife access, and dust-hose clogging; the current V4.02.26 manual establishes a later production boundary but does not prove those particular concerns persist or were corrected. A September 2026 owner described flat and accurate surfaces, a mid-level fence, and minor annoyances without stating ownership duration. These mixed anecdotes are not representative durability evidence. Expected service life, representative failure rate, annual maintenance cost, repair economics, and a buy-or-repair recommendation remain unverified.',
    last_reviewed_date = '2026-11-26'
WHERE slug = 'grizzly-g0899';

UPDATE product_fields
SET raw_value = 'Grizzly identifies G0899 as the current 10-inch stationary or cabinet-format table saw with a 2 HP single-phase TEFC induction motor. It is prewired for 115V at 16 A and can be converted to 230V at 8 A with the specified conversion parts. The current manual lists a 4,000 RPM arbor, 31-1/2-inch maximum rip to the right of the blade, 11-3/8-inch rip to the left, 3-1/8-inch maximum depth at 90 degrees, 2-1/8-inch depth at 45 degrees, a precision-ground cast-iron table and wings, and cast-iron trunnions.',
    display_value = 'G0899 current configuration: 2 HP, 115V/230V, 16 A/8 A, 4,000 RPM, 31-1/2 in. right rip, and maximum cuts of 3-1/8 in. at 90 degrees and 2-1/8 in. at 45 degrees, with cast-iron table, wings, and trunnions.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0899_m.pdf'),
    verified_date = '2026-11-26',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899')
  AND name = 'identity';

UPDATE product_fields
SET raw_value = 'The exact-model online catalog rendered 316 component rows on 2026-11-26. Of those, 180 exposed direct add-to-cart controls, 134 legacy rows pointed to named replacement parts, and two legacy rows—the V1 cabinet and V1 switch box—were disabled without a listed replacement. Direct-order rows included the complete 2 HP motor and motor components, capacitors, centrifugal switch, arbor and pulleys, poly V-belt, paddle switch, power cord, trunnions, fence assembly and rails, blade-guard assembly, and riving knife. Add-to-cart controls do not prove on-hand inventory, successful checkout, manufacture-date compatibility, or future supply.',
    display_value = 'Partial: 316 exact-model catalog rows included 180 direct add-to-cart entries, 134 legacy-to-replacement mappings, and 2 disabled legacy entries without a listed replacement; motor, arbor, belt, switch, fence, trunnion, guard, and riving-knife parts were represented, but stock and revision fit remain unproven.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.grizzly.com/products/g0899/parts'),
    verified_date = '2026-11-26',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899')
  AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'Grizzly publishes the G0899 owner-service manual revision V4.02.26 for models manufactured since February 2026. It covers setup, operation, weekly and monthly maintenance, six-to-twelve-month lubrication, troubleshooting, blade and fence alignment, riving-knife alignment, insert and miter-gauge adjustment, belt tension and replacement, wiring diagrams, electrical components, and illustrated parts lists. It is a substantial owner-service manual, while deeper factory repair remains a separate support path.',
    display_value = 'V4.02.26 owner-service manual for models since 02/26 covers maintenance, alignment, belt replacement, wiring, troubleshooting, and illustrated parts; factory repair remains separately available.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0899_m.pdf'),
    verified_date = '2026-11-26',
    reverify_days = 365
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899')
  AND name = 'repair_manual';

UPDATE product_fields
SET raw_value = 'The current manual schedules weekly table, miter-slot, cast-iron, and fence cleaning; monthly cabinet and motor dust removal plus belt inspection; and trunnion-slide, worm-gear, bull-gear, and leadscrew lubrication every six to twelve months. It documents owner alignment, calibration, troubleshooting, belt tension, and belt replacement. Grizzly technical support may walk owners through minor adjustments or repairs, while authorized factory repair requires prior approval and shipping or drop-off.',
    display_value = 'User-serviceable: weekly cleaning, monthly dust and belt checks, 6–12-month lubrication, alignment and calibration, plus belt replacement; phone support and authorized factory repair cover deeper work.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://cdn0.grizzly.com/manuals/g0899_m.pdf'),
    verified_date = '2026-11-26',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899')
  AND name = 'serviceability';

UPDATE product_fields
SET raw_value = 'Grizzly currently warrants house-brand products for one year to the original purchaser from the date of purchase. Registration is not required, but proof of purchase is required. The published policy excludes defects caused directly or indirectly by misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, lack of maintenance, or consumable parts, and it does not reimburse third-party repairs or machinery transport expenses.',
    display_value = '1-year limited warranty for the original purchaser with proof of purchase; misuse, repairs, improper wiring, alterations, lack of maintenance, consumables, third-party work, and transport costs are excluded or unreimbursed.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty'),
    verified_date = '2026-11-26',
    reverify_days = 90
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899')
  AND name = 'warranty';

UPDATE product_fields
SET verified_date = '2026-11-26',
    reverify_days = 180
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899')
  AND name IN ('expected_service_life', 'annual_maintenance_cost');

UPDATE product_fields
SET verified_date = '2026-11-26',
    reverify_days = 30
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899')
  AND name = 'street_price';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://www.grizzly.com/products/g0899/parts',
    repair_manual_available = 1,
    repair_manual_url = 'https://cdn0.grizzly.com/manuals/g0899_m.pdf',
    serviceability = 'user-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.grizzly.com/products/g0899/parts'),
    verified_date = '2026-11-26'
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899');

INSERT INTO warranties (
  product_id,
  warranty_length,
  warranty_coverage,
  warranty_exclusions,
  source_id,
  verified_date
)
SELECT
  p.id,
  '1 year to the original purchaser from the date of purchase.',
  'Grizzly warrants its house-brand products to the original purchaser; registration is not required, but proof of purchase is required for a claim.',
  'Misuse, abuse, negligence, accidents, repairs, improper wiring, alterations, lack of maintenance, and consumable parts are excluded; third-party repair and machinery transport expenses are not reimbursed.',
  s.id,
  '2026-11-26'
FROM products p
JOIN sources s ON s.url = 'https://support.grizzly.com/hc/en-us/articles/4407181257751-Do-your-items-carry-a-warranty'
WHERE p.slug = 'grizzly-g0899'
ON CONFLICT(product_id) DO UPDATE SET
  warranty_length = excluded.warranty_length,
  warranty_coverage = excluded.warranty_coverage,
  warranty_exclusions = excluded.warranty_exclusions,
  source_id = excluded.source_id,
  verified_date = excluded.verified_date;

UPDATE affiliate_links
SET verified_date = '2026-11-26'
WHERE product_id = (SELECT id FROM products WHERE slug = 'grizzly-g0899')
  AND program_name = 'Amazon Associates'
  AND url = 'https://www.amazon.com/dp/B08B6G2L6P?tag=everlastin08f-20'
  AND exact_model = 1;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '73');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-11-26');

COMMIT;
