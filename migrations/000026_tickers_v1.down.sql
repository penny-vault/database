BEGIN;

ALTER TABLE tickers_v1 DROP COLUMN cusip;
ALTER TABLE tickers_v1 DROP COLUMN isin;

COMMIT;