BEGIN;

ALTER TABLE portfolio_v1 DROP COLUMN predicted_holdings;
ALTER TABLE portfolio_v1 DROP COLUMN predicted_justification;
ALTER TABLE portfolio_v1 DROP COLUMN next_trade_date;

COMMIT;