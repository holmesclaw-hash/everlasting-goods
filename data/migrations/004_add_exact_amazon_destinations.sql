BEGIN;

DELETE FROM affiliate_links WHERE program_name = 'Amazon Associates';

INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B00WM1VPKE?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'california-air-tools-8010';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B084GYHQFY?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'makita-mac210q';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B07Z5QNBVS?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'bosch-gsr18v-535fcb15';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B09ZQ4VTXK?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'dewalt-dcd800b';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B00EOOZT5E?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'dewalt-dcd800d1e1';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B093QS3VJR?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'makita-xfd14z';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B0BB854SJ8?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'milwaukee-2904-20';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B00K69ILFQ?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'fein-turbo-i';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B0DYK9VDC1?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'festool-ct-26-ei-hepa';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B07ZMN75V2?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'makita-vc4210l';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B00005RHPD?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'bosch-1617evspk';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B07KSRTDML?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'dewalt-dcw600b';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B00E7D3V4S?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'makita-rt0701c';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B0851KL858?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'bosch-4100xc-10';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B00F2CGXGG?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'dewalt-dwe7491rs';
INSERT INTO affiliate_links (product_id, program_name, url, exact_model, verified_date)
SELECT id, 'Amazon Associates', 'https://www.amazon.com/dp/B009C7NGTE?tag=everlastin08f-20', 1, '2026-08-25' FROM products WHERE slug = 'sawstop-pcs31230-tgp236';

INSERT OR REPLACE INTO metadata (key, value) VALUES ('affiliate_revision', '4');

COMMIT;
