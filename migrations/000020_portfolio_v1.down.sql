BEGIN;

ALTER TABLE portfolio_v1 DROP COLUMN end_date;
ALTER TABLE portfolio_v1 DROP COLUMN holdings;

COMMIT;