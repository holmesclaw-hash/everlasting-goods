BEGIN;

INSERT OR IGNORE INTO metadata (key, value) VALUES ('evidence_revision', '3');

INSERT OR IGNORE INTO sources (url, title, source_type, retrieved_date) VALUES
  ('https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only', 'DEWALT DCD800B official product page', 'manufacturer', '2026-08-25'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA043446_DCD800_DCD805_NA.pdf', 'DEWALT DCD800/DCD805 instruction manual', 'manufacturer', '2026-08-25'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif', 'DEWALT DCD800 exploded diagram', 'manufacturer', '2026-08-25'),
  ('https://documents.milwaukeetool.com/58-14-9998d1.pdf', 'Milwaukee 2904-20 operator manual', 'manufacturer', '2026-08-25'),
  ('https://documents.milwaukeetool.com/54-24-2990R.pdf', 'Milwaukee 2904-20 service parts list', 'manufacturer', '2026-08-25'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf', 'Makita XFD14 instruction manual', 'manufacturer', '2026-08-25'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf', 'Makita XFD14 parts breakdown', 'manufacturer', '2026-08-25'),
  ('https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf', 'Bosch GSR18V-535FC instruction manual', 'manufacturer', '2026-08-25'),
  ('https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110', 'Bosch GSR18V-535FCB15 spare-parts catalog', 'manufacturer', '2026-08-25'),
  ('https://www.sawstop.com/product-category/parts/pcs', 'SawStop PCS replacement-parts storefront', 'manufacturer', '2026-08-25'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Instruction_Manual/EN/N376167_DWE7490.pdf', 'DEWALT DWE7491RS instruction manual', 'manufacturer', '2026-08-25'),
  ('https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Exploded_Diagram/EN/EA024890.gif', 'DEWALT DWE7491RS exploded diagram', 'manufacturer', '2026-08-25'),
  ('https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf', 'Bosch 4100XC instruction manual', 'manufacturer', '2026-08-25'),
  ('https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/4100xc-10-3601L13015', 'Bosch 4100XC-10 spare-parts catalog', 'manufacturer', '2026-08-25'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf', 'Makita RT0701C instruction manual', 'manufacturer', '2026-08-25'),
  ('https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf', 'Makita RT0701C parts breakdown', 'manufacturer', '2026-08-25');

-- Reconcile exact manuals and parts evidence for existing records.
DELETE FROM product_sources WHERE product_id = 2 AND purpose IN ('manual','parts');
INSERT INTO product_sources SELECT 2, id, 'manual' FROM sources WHERE url = 'https://documents.milwaukeetool.com/58-14-9998d1.pdf';
INSERT INTO product_sources SELECT 2, id, 'parts' FROM sources WHERE url = 'https://documents.milwaukeetool.com/54-24-2990R.pdf';
UPDATE product_fields SET raw_value='Official operator manual is linked.', display_value='Official operator manual is linked.', source_id=(SELECT id FROM sources WHERE url='https://documents.milwaukeetool.com/58-14-9998d1.pdf') WHERE product_id=2 AND name='repair_manual';
UPDATE product_fields SET raw_value='Partial: manufacturer service-parts list and repair portal are linked.', display_value='Partial: manufacturer service-parts list and repair portal are linked.', source_id=(SELECT id FROM sources WHERE url='https://documents.milwaukeetool.com/54-24-2990R.pdf') WHERE product_id=2 AND name='parts_availability';
UPDATE repairability SET repair_manual_url='https://documents.milwaukeetool.com/58-14-9998d1.pdf', parts_url='https://documents.milwaukeetool.com/54-24-2990R.pdf', source_id=(SELECT id FROM sources WHERE url='https://documents.milwaukeetool.com/54-24-2990R.pdf') WHERE product_id=2;

DELETE FROM product_sources WHERE product_id = 3 AND purpose IN ('manual','parts');
INSERT INTO product_sources SELECT 3, id, 'manual' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf';
INSERT INTO product_sources SELECT 3, id, 'parts' FROM sources WHERE url = 'https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf';
UPDATE product_fields SET source_id=(SELECT id FROM sources WHERE url='https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf') WHERE product_id=3 AND name='repair_manual';
UPDATE product_fields SET raw_value='Partial: official exploded parts breakdown and service path are linked.', display_value='Partial: official exploded parts breakdown and service path are linked.', source_id=(SELECT id FROM sources WHERE url='https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf') WHERE product_id=3 AND name='parts_availability';
UPDATE repairability SET repair_manual_url='https://cdn.makitatools.com/apps/cms/doc/prod/XFD/398deb0c-2db4-4690-a5b8-9be116dc1e01_XFD14_IM_885859-941.pdf', parts_url='https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf', source_id=(SELECT id FROM sources WHERE url='https://cdn.makitatools.com/apps/cms/doc/prod/XFD/ee24317d-fede-46ed-b1bf-eb8a8c4ac745_XFD14_PB_Breakdown_XFD14T,Z_02-21.pdf') WHERE product_id=3;

DELETE FROM product_sources WHERE product_id = 4 AND purpose IN ('manual','parts');
INSERT INTO product_sources SELECT 4, id, 'manual' FROM sources WHERE url = 'https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf';
INSERT INTO product_sources SELECT 4, id, 'parts' FROM sources WHERE url = 'https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110';
UPDATE product_fields SET source_id=(SELECT id FROM sources WHERE url='https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf') WHERE product_id=4 AND name='repair_manual';
UPDATE product_fields SET raw_value='Partial: exact manufacturer spare-parts catalog is linked.', display_value='Partial: exact manufacturer spare-parts catalog is linked.', source_id=(SELECT id FROM sources WHERE url='https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110') WHERE product_id=4 AND name='parts_availability';
UPDATE repairability SET repair_manual_url='https://ocsmedia.boschtools.com/binary/manualsmedia/o206866v2_2610055572GSR18V535FC012020.pdf', parts_url='https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110', source_id=(SELECT id FROM sources WHERE url='https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/gsr18v-535fcb15-3601JG7110') WHERE product_id=4;

DELETE FROM product_sources WHERE product_id = 5 AND purpose='parts';
INSERT INTO product_sources SELECT 5, id, 'parts' FROM sources WHERE url='https://www.sawstop.com/product-category/parts/pcs';
UPDATE product_fields SET raw_value='Partial: manufacturer PCS replacement-parts storefront and support manuals are linked.', display_value='Partial: manufacturer PCS replacement-parts storefront and support manuals are linked.', source_id=(SELECT id FROM sources WHERE url='https://www.sawstop.com/product-category/parts/pcs') WHERE product_id=5 AND name='parts_availability';
UPDATE repairability SET parts_url='https://www.sawstop.com/product-category/parts/pcs', source_id=(SELECT id FROM sources WHERE url='https://www.sawstop.com/product-category/parts/pcs') WHERE product_id=5;

DELETE FROM product_sources WHERE product_id = 6 AND purpose IN ('manual','parts');
INSERT INTO product_sources SELECT 6, id, 'manual' FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Instruction_Manual/EN/N376167_DWE7490.pdf';
INSERT INTO product_sources SELECT 6, id, 'parts' FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Exploded_Diagram/EN/EA024890.gif';
UPDATE product_fields SET source_id=(SELECT id FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Instruction_Manual/EN/N376167_DWE7490.pdf') WHERE product_id=6 AND name='repair_manual';
UPDATE product_fields SET raw_value='Partial: manufacturer exploded diagram and ServiceNet support are linked.', display_value='Partial: manufacturer exploded diagram and ServiceNet support are linked.', source_id=(SELECT id FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Exploded_Diagram/EN/EA024890.gif') WHERE product_id=6 AND name='parts_availability';
UPDATE repairability SET repair_manual_url='https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Instruction_Manual/EN/N376167_DWE7490.pdf', parts_url='https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Exploded_Diagram/EN/EA024890.gif', source_id=(SELECT id FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DWE7491RS/2/Exploded_Diagram/EN/EA024890.gif') WHERE product_id=6;

DELETE FROM product_sources WHERE product_id = 7 AND purpose IN ('manual','parts');
INSERT INTO product_sources SELECT 7, id, 'manual' FROM sources WHERE url='https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf';
INSERT INTO product_sources SELECT 7, id, 'parts' FROM sources WHERE url='https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/4100xc-10-3601L13015';
UPDATE product_fields SET source_id=(SELECT id FROM sources WHERE url='https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf') WHERE product_id=7 AND name='repair_manual';
UPDATE product_fields SET raw_value='Partial: exact manufacturer spare-parts catalog is linked.', display_value='Partial: exact manufacturer spare-parts catalog is linked.', source_id=(SELECT id FROM sources WHERE url='https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/4100xc-10-3601L13015') WHERE product_id=7 AND name='parts_availability';
UPDATE repairability SET repair_manual_url='https://ocsmedia.boschtools.com/binary/manualsmedia/o206944v2_1600A01Z1U_1019_4100XC.pdf', parts_url='https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/4100xc-10-3601L13015', source_id=(SELECT id FROM sources WHERE url='https://www.boschtoolservice.com/us/en/bosch-pt/spareparts/4100xc-10-3601L13015') WHERE product_id=7;

DELETE FROM product_sources WHERE product_id = 8 AND purpose IN ('manual','parts');
INSERT INTO product_sources SELECT 8, id, 'manual' FROM sources WHERE url='https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf';
INSERT INTO product_sources SELECT 8, id, 'parts' FROM sources WHERE url='https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf';
UPDATE product_fields SET source_id=(SELECT id FROM sources WHERE url='https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf') WHERE product_id=8 AND name='repair_manual';
UPDATE product_fields SET raw_value='Partial: official parts breakdown and factory/authorized service path are linked.', display_value='Partial: official parts breakdown and factory/authorized service path are linked.', source_id=(SELECT id FROM sources WHERE url='https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf') WHERE product_id=8 AND name='parts_availability';
UPDATE repairability SET repair_manual_url='https://cdn.makitatools.com/apps/cms/doc/prod/RT0/647d7eb3-3b81-48d3-b5c1-3ae0fe4e121d_RT0701C_IM.pdf', parts_url='https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf', source_id=(SELECT id FROM sources WHERE url='https://cdn.makitatools.com/apps/cms/doc/prod/RT0/1a53392d-f910-408c-9f73-fbc7ed56d465_RT0701C_PB_Breakdown_RT0701C_8-13.pdf') WHERE product_id=8;

-- Add the exact DCD800B tool-only record without removing the already published kit record.
INSERT INTO products (id, slug, brand, model, sku, category, category_group, evidence_tier, last_reviewed_date)
VALUES (16, 'dewalt-dcd800b', 'DEWALT', 'DCD800', 'DCD800B', 'drill-drivers', 'tools-shop', 'T2', '2026-08-25');
INSERT INTO product_sources SELECT 16, id, 'identity' FROM sources WHERE url='https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only';
INSERT INTO product_sources SELECT 16, id, 'manual' FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA043446_DCD800_DCD805_NA.pdf';
INSERT INTO product_sources SELECT 16, id, 'warranty' FROM sources WHERE url='https://www.dewalt.com/en-us/support/warranty';
INSERT INTO product_sources SELECT 16, id, 'parts' FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif';
INSERT INTO product_fields (product_id,name,raw_value,display_value,evidence_tier,source_id,verified_date,reverify_days) VALUES
  (16,'identity','20V MAX XR brushless cordless 1/2-inch drill/driver, DCD800B tool-only package; 0-650 / 0-2,000 RPM and 6.37-inch tool-head length documented.','20V MAX XR brushless cordless 1/2-inch drill/driver, DCD800B tool-only package; 0-650 / 0-2,000 RPM and 6.37-inch tool-head length documented.','T2',(SELECT id FROM sources WHERE url='https://www.dewalt.com/en-us/product/dcd800b/20v-max-xr-brushless-cordless-12-drilldriver-tool-only'),'2026-08-25',180),
  (16,'warranty','3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee, subject to manufacturer terms.','3-year limited warranty, 1-year free service, and 90-day satisfaction guarantee, subject to manufacturer terms.','T2',(SELECT id FROM sources WHERE url='https://www.dewalt.com/en-us/support/warranty'),'2026-08-25',180),
  (16,'repair_manual','Official DCD800/DCD805 instruction manual is linked.','Official DCD800/DCD805 instruction manual is linked.','T2',(SELECT id FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA043446_DCD800_DCD805_NA.pdf'),'2026-08-25',180),
  (16,'parts_availability','Partial: official exploded diagram and manufacturer support are linked.','Partial: official exploded diagram and manufacturer support are linked.','T2',(SELECT id FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif'),'2026-08-25',180),
  (16,'serviceability','Not yet verified','Not yet verified','T4',NULL,'2026-08-25',180),
  (16,'expected_service_life','Not yet verified','Not yet verified','T4',NULL,'2026-08-25',180),
  (16,'street_price','Not yet verified','Not yet verified','T4',NULL,'2026-08-25',30),
  (16,'annual_maintenance_cost','Not yet verified','Not yet verified','T4',NULL,'2026-08-25',180);
INSERT INTO repairability (product_id,parts_availability,parts_url,repair_manual_available,repair_manual_url,serviceability,source_id,verified_date)
VALUES (16,'partial','https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif',1,'https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Instruction_Manual/EN/NA043446_DCD800_DCD805_NA.pdf','not-yet-verified',(SELECT id FROM sources WHERE url='https://assets.dewalt.com/GLOBALBOM/QU/DCD800B/1/Exploded_Diagram/EN/DCD800.gif'),'2026-08-25');

COMMIT;
