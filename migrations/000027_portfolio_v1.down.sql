BEGIN;

ALTER TABLE portfolio_v1 DROP COLUMN next_trade_date;
ALTER TABLE portfolio_v1 DROP COLUMN predicted_bytes;

COMMIT;
