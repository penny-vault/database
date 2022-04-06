BEGIN;

ALTER TABLE portfolio_v1 ADD COLUMN predicted_bytes BYTEA;
ALTER TABLE portfolio_v1 ADD COLUMN next_trade_date TIMESTAMP;

COMMIT;