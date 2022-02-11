BEGIN;

ALTER TABLE portfolio_v1 ADD COLUMN predicted_holdings JSONB;
ALTER TABLE portfolio_v1 ADD COLUMN predicted_justification JSONB;
ALTER TABLE portfolio_v1 ADD COLUMN next_trade_date TIMESTAMP;

COMMIT;