PRAGMA foreign_keys = ON;

CREATE TABLE metadata (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

INSERT INTO metadata (key, value) VALUES
  ('schema_version', '1'),
  ('generated_policy', 'Facts originate in SQLite; web artifacts are generated views.'),
  ('last_migrated_date', '2026-08-25');

CREATE TABLE products (
  id INTEGER PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  brand TEXT NOT NULL,
  model TEXT NOT NULL,
  sku TEXT,
  category TEXT NOT NULL,
  category_group TEXT NOT NULL DEFAULT 'tools-shop',
  variant_notes TEXT,
  evidence_tier TEXT NOT NULL CHECK (evidence_tier IN ('T1','T2','T3','T4')),
  recommendation TEXT NOT NULL DEFAULT 'not-yet-verified' CHECK (recommendation IN ('repair','buy-used','buy-new','not-yet-verified')),
  recommendation_reasoning TEXT NOT NULL DEFAULT 'Not yet verified',
  street_price_cents INTEGER,
  price_verified_date TEXT,
  expected_service_life_years REAL,
  expected_service_life_basis TEXT,
  annual_maintenance_cost_cents INTEGER,
  image_url TEXT,
  image_source_url TEXT,
  image_license_basis TEXT,
  last_reviewed_date TEXT NOT NULL
);

CREATE TABLE sources (
  id INTEGER PRIMARY KEY,
  url TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,
  source_type TEXT NOT NULL CHECK (source_type IN ('first-party','manufacturer','owner-report','other')),
  retrieved_date TEXT NOT NULL
);

CREATE TABLE product_sources (
  product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  source_id INTEGER NOT NULL REFERENCES sources(id) ON DELETE CASCADE,
  purpose TEXT NOT NULL,
  PRIMARY KEY (product_id, source_id, purpose)
);

CREATE TABLE product_fields (
  id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  raw_value TEXT,
  display_value TEXT NOT NULL,
  evidence_tier TEXT NOT NULL CHECK (evidence_tier IN ('T1','T2','T3','T4')),
  source_id INTEGER REFERENCES sources(id),
  verified_date TEXT NOT NULL,
  reverify_days INTEGER NOT NULL CHECK (reverify_days > 0),
  UNIQUE (product_id, name)
);

CREATE TABLE affiliate_links (
  id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  program_name TEXT NOT NULL,
  url TEXT NOT NULL,
  exact_model INTEGER NOT NULL CHECK (exact_model IN (0,1)),
  verified_date TEXT NOT NULL
);

CREATE TABLE warranties (
  product_id INTEGER PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE,
  warranty_length TEXT NOT NULL,
  warranty_coverage TEXT NOT NULL,
  warranty_exclusions TEXT NOT NULL,
  source_id INTEGER NOT NULL REFERENCES sources(id),
  verified_date TEXT NOT NULL
);

CREATE TABLE repairability (
  product_id INTEGER PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE,
  parts_availability TEXT NOT NULL CHECK (parts_availability IN ('full','partial','none','not-yet-verified')),
  parts_url TEXT,
  repair_manual_available INTEGER NOT NULL CHECK (repair_manual_available IN (0,1)),
  repair_manual_url TEXT,
  serviceability TEXT NOT NULL CHECK (serviceability IN ('user-serviceable','shop-serviceable','sealed','not-yet-verified')),
  ifixit_score REAL,
  source_id INTEGER REFERENCES sources(id),
  verified_date TEXT NOT NULL
);

CREATE TABLE known_failure_points (
  id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  failure_point TEXT NOT NULL,
  evidence_tier TEXT NOT NULL CHECK (evidence_tier IN ('T1','T2','T3','T4')),
  independent_source_count INTEGER NOT NULL DEFAULT 0,
  publishable INTEGER NOT NULL DEFAULT 0 CHECK (publishable IN (0,1)),
  CHECK (publishable = 0 OR evidence_tier IN ('T1','T2') OR (evidence_tier = 'T3' AND independent_source_count >= 3))
);

CREATE TABLE first_party_notes (
  id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  note_text TEXT NOT NULL,
  supplied_by TEXT NOT NULL,
  supplied_date TEXT NOT NULL,
  media_path TEXT,
  approved_for_publication INTEGER NOT NULL DEFAULT 0 CHECK (approved_for_publication IN (0,1))
);

CREATE VIEW freshness_queue AS
SELECT
  pf.product_id,
  pf.name AS field_name,
  pf.verified_date,
  pf.reverify_days,
  date(pf.verified_date, '+' || pf.reverify_days || ' days') AS stale_after,
  CASE WHEN date(pf.verified_date, '+' || pf.reverify_days || ' days') < date('now') THEN 1 ELSE 0 END AS is_stale
FROM product_fields pf;

CREATE VIEW product_economics AS
SELECT
  p.id AS product_id,
  CASE
    WHEN p.street_price_cents IS NOT NULL
      AND p.expected_service_life_years IS NOT NULL
      AND p.expected_service_life_years > 0
    THEN ROUND((p.street_price_cents / 100.0) / p.expected_service_life_years + COALESCE(p.annual_maintenance_cost_cents, 0) / 100.0, 2)
    ELSE NULL
  END AS cost_per_year
FROM products p;
