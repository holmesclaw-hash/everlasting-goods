PRAGMA foreign_keys = ON;
BEGIN;

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.reddit.com/r/woodworking/comments/1iudoea/good_purchase_bosch_router_1617evspk_combo/', 'Bosch 1617EVSPK owner discussion: long ownership reports', 'owner-report', '2026-09-26'),
  ('https://www.reddit.com/r/woodworking/comments/2tuf2a/bosch_1617evspk_plunge_router_plunging_is_not/', 'Bosch 1617EVSPK owner report: stiff plunge action on first use', 'owner-report', '2026-09-26'),
  ('https://slickdeals.net/f/19861437-bosch-router-1617evspk-2-25-hp-combination-plunge-and-fixed-base-woodworking-router-179-free-s-h-at-amazon', 'August 2026 Bosch 1617EVSPK commercial identity corroboration', 'other', '2026-09-26');

DELETE FROM product_sources WHERE product_id = 9;

INSERT INTO product_sources
SELECT 9, id, 'current catalog identity, performance range, current part number, and package contents' FROM sources
WHERE url = 'https://www.boschtools.com/us/en/products/1617evspk-0601617577';
INSERT INTO product_sources
SELECT 9, id, 'operating, cleaning, bit and collet, maintenance, and authorized-service boundaries' FROM sources
WHERE url = 'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf';
INSERT INTO product_sources
SELECT 9, id, 'current Bosch corded-tool warranty terms' FROM sources
WHERE url = 'https://www.boschtools.com/us/en/service/product-warranty/';
INSERT INTO product_sources
SELECT 9, id, 'qualified exact-combo long-ownership anecdotes' FROM sources
WHERE url = 'https://www.reddit.com/r/woodworking/comments/1iudoea/good_purchase_bosch_router_1617evspk_combo/';
INSERT INTO product_sources
SELECT 9, id, 'qualified exact-model first-use plunge-action report' FROM sources
WHERE url = 'https://www.reddit.com/r/woodworking/comments/2tuf2a/bosch_1617evspk_plunge_router_plunging_is_not/';
INSERT INTO product_sources
SELECT 9, id, 'exact-model commercial destination' FROM sources
WHERE url = 'https://www.amazon.com/dp/B00005RHPD';
INSERT INTO product_sources
SELECT 9, id, 'recent exact-model commercial identity corroboration' FROM sources
WHERE url = 'https://slickdeals.net/f/19861437-bosch-router-1617evspk-2-25-hp-combination-plunge-and-fixed-base-woodworking-router-179-free-s-h-at-amazon';

UPDATE products
SET variant_notes = 'Bosch identifies 1617EVSPK as the 2.25 HP variable-speed combination kit with fixed and plunge bases. The current catalog page displays part number 06016176A1; the 0601617577 value in the page URL is not presented as the current part number.',
    recommendation = 'not-yet-verified',
    recommendation_reasoning = 'Manufacturer documentation supports the exact fixed-base and plunge-base package, owner cleaning and bit or collet procedures, authorized service, and a one-year limited warranty. In one exact-combo discussion, individual owners report about 15 to more than 20 years of use; another exact-model owner reported stiff plunge action on first use. These anecdotes do not establish representative service life, current parts availability, or repair economics, so expected service life and a buy or repair recommendation remain unverified.',
    last_reviewed_date = '2026-09-26'
WHERE id = 9 AND slug = 'bosch-1617evspk';

UPDATE product_fields
SET raw_value = 'Bosch identifies 1617EVSPK as a 2.25 HP corded variable-speed router combination kit with fixed and plunge bases, 8,000 to 25,000 rpm speed control, and current part number 06016176A1.',
    display_value = '2.25 HP corded variable-speed router kit, 8,000–25,000 RPM, with fixed and plunge bases.',
    evidence_tier = 'T2',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/products/1617evspk-0601617577'),
    verified_date = '2026-09-26',
    reverify_days = 180
WHERE product_id = 9 AND name = 'identity';

UPDATE product_fields
SET raw_value = 'Not yet verified. The previously recorded exact Bosch spare-parts URL returns HTTP 404, and its claimed technical-part-number mapping was not independently corroborated during correction review.',
    display_value = 'Not yet verified',
    evidence_tier = 'T4',
    source_id = NULL,
    verified_date = '2026-09-26',
    reverify_days = 90
WHERE product_id = 9 AND name = 'parts_availability';

UPDATE repairability
SET parts_availability = 'not-yet-verified',
    parts_url = NULL,
    repair_manual_available = 0,
    repair_manual_url = 'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf',
    serviceability = 'shop-serviceable',
    source_id = (SELECT id FROM sources WHERE url = 'https://www.boschtools.com/us/en/ocsmedia/2610051825_1617_0518.pdf'),
    verified_date = '2026-09-26'
WHERE product_id = 9;

DELETE FROM sources
WHERE url IN (
  'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/1617evspk-3601F75710',
  'https://www.garagejournal.com/forum/threads/bosch-1617-router-users-beware.327633/',
  'https://festoolownersgroup.com/threads/bosch-1617evspk-combo-router-kit.69166/',
  'https://slickdeals.net/f/18625288-bosch-2-25-hp-variable-speed-router-combination-kit-1617evspk-149-free-shipping'
);

INSERT OR REPLACE INTO metadata (key, value) VALUES ('evidence_revision', '25');
INSERT OR REPLACE INTO metadata (key, value) VALUES ('last_migrated_date', '2026-09-26');

COMMIT;
