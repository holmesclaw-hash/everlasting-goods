PRAGMA foreign_keys = ON;
BEGIN;

INSERT INTO sources (id, url, title, source_type, retrieved_date) VALUES
  (79, 'https://californiaairtools.com/maintenance-troubleshooting-guide', 'California Air Tools maintenance and troubleshooting guide', 'manufacturer', '2026-09-16'),
  (80, 'https://www.reddit.com/r/Tools/comments/iyaif5/california_air_compressors_any_good', 'California air compressors - any good? owner discussion', 'owner-report', '2026-09-16');

INSERT INTO product_sources (product_id, source_id, purpose) VALUES
  (14, 79, 'maintenance'),
  (14, 80, 'owner-evidence');

UPDATE products
SET last_reviewed_date = '2026-09-16',
    recommendation_reasoning = 'Manufacturer documentation supports routine user maintenance and troubleshooting plus an authorized service path. The available owner discussion is mixed, and this exact model''s service life remains unverified, so no buy or repair recommendation is published.'
WHERE id = 14 AND slug = 'california-air-tools-8010';

UPDATE product_fields
SET raw_value = 'Partial support: the official 8010 page identifies replaceable 1 HP air filter part 90227, while the manual directs owners to California Air Tools for service or repair parts.',
    display_value = 'Partial: replaceable air filter part 90227 is identified, with manufacturer service and parts support.',
    evidence_tier = 'T2',
    source_id = 34,
    verified_date = '2026-09-16',
    reverify_days = 180
WHERE product_id = 14 AND name = 'parts_availability';

UPDATE product_fields
SET raw_value = 'The manufacturer publishes user procedures for air-filter maintenance, tank draining, connection leaks, and check-valve troubleshooting; the manual routes repair work through authorized service and excludes unauthorized repairs from warranty coverage.',
    display_value = 'User-serviceable for documented routine maintenance and troubleshooting; repair work is routed through authorized service.',
    evidence_tier = 'T2',
    source_id = 79,
    verified_date = '2026-09-16',
    reverify_days = 180
WHERE product_id = 14 AND name = 'serviceability';

UPDATE repairability
SET parts_availability = 'partial',
    parts_url = 'https://californiaairtools.com/maintenance-troubleshooting-guide',
    serviceability = 'user-serviceable',
    source_id = 79,
    verified_date = '2026-09-16'
WHERE product_id = 14;

UPDATE metadata SET value = '2026-09-16' WHERE key = 'last_migrated_date';

COMMIT;
