-- Setup permissions
BEGIN;

-- postgrest anonymous user
CREATE ROLE pvanon WITH NOINHERIT;

-- user group role
CREATE ROLE pvuser WITH NOLOGIN;

-- execute on allowed functions
GRANT execute ON function generate_uuid_v4 TO pvuser;

-- tables with read only access
GRANT select ON dividend_v1 TO pvuser;
GRANT select ON eod_v1 TO pvuser;
GRANT select ON reported_financials_v1 TO pvuser;
GRANT select ON risk_indicators_v1 TO pvuser;
GRANT select ON stock_splits_v1 TO pvuser;
GRANT select ON tickers_v1 TO pvuser;
GRANT select ON zacks_financials_v1 TO pvuser;

-- tables with read/write access
GRANT select, insert, update, delete ON portfolio_v1 TO pvuser;
GRANT select, insert, update, delete ON portfolio_transaction_v1 TO pvuser;
GRANT select, insert, update, delete ON portfolio_measurement_v1 TO pvuser;
GRANT select, insert, update, delete ON portfolio_holding_v1 TO pvuser;

-- authenticator role
-- make sure you set the password
CREATE ROLE pvapi WITH NOINHERIT LOGIN CREATEROLE;
GRANT pvuser TO pvauth;
GRANT pvanon TO pvauth;

COMMIT;