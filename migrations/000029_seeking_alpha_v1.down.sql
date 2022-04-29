BEGIN;
DROP TABLE IF EXISTS seeking_alpha_v1;
ALTER TABLE tickers_v1 DROP COLUMN seeking_alpha_id;
COMMIT;
