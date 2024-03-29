-- Setup permissions
BEGIN;

-- postgrest anonymous user
DROP ROLE pvanon;

-- tables with read only access
REVOKE select ON dividend_v1 FROM pvuser;
REVOKE select ON eod_v1 FROM pvuser;
REVOKE select ON reported_financials_v1 FROM pvuser;
REVOKE select ON risk_indicators_v1 FROM pvuser;
REVOKE select ON stock_splits_v1 FROM pvuser;
REVOKE select ON tickers_v1 FROM pvuser;
REVOKE select ON zacks_financials_v1 FROM pvuser;

-- tables with read/write access
REVOKE select, insert, update, delete ON portfolio_v1 FROM pvuser;
REVOKE select, insert, update, delete ON portfolio_transaction_v1 FROM pvuser;
REVOKE select, insert, update, delete ON portfolio_measurement_v1 FROM pvuser;
REVOKE select, insert, update, delete ON portfolio_holding_v1 FROM pvuser;

-- user group role
DROP ROLE pvuser;

-- authenticator role
-- make sure you set the password
DROP ROLE pvapi;

COMMIT;
