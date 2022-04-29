BEGIN;

ALTER TABLE tickers RENAME TO tickers_v1;
ALTER VIEW health RENAME TO health_v1;
ALTER TABLE eod RENAME TO eod_v1;
ALTER TABLE market_holidays RENAME TO market_holidays_v1;
ALTER TABLE portfolio_holding RENAME TO portfolio_holding_v1;
ALTER TABLE portfolio_measurement RENAME TO portfolio_measurement_v1;
ALTER TABLE portfolio_transaction RENAME TO portfolio_transaction_v1;
ALTER TABLE portfolio RENAME TO portfolio_v1;
ALTER TABLE reported_financials RENAME TO reported_financials_v1;
ALTER TABLE seeking_alpha RENAME TO seeking_alpha_v1;
ALTER TABLE trading_days RENAME TO trading_days_v1;
ALTER TABLE zacks_financials RENAME TO zacks_financials_v1;

ALTER TABLE tickers_v1 ADD COLUMN type text;
UPDATE tickers_v1 SET type = asset_type;
ALTER TABLE tickers_v1 DROP COLUMN asset_type;
DROP TYPE assettype;

ALTER TABLE tickers_v1 ADD COLUMN ceo text;
ALTER TABLE tickers_v1 ADD COLUMN phone text;
ALTER TABLE tickers_v1 ADD COLUMN emplyees text;
ALTER TABLE tickers_v1 ADD COLUMN marketcap text;
ALTER TABLE tickers_v1 ADD COLUMN market text;
ALTER TABLE tickers_v1 ADD COLUMN locale text;
ALTER TABLE tickers_v1 ADD COLUMN currency_name text;
ALTER TABLE tickers_v1 ADD COLUMN currency_symbol text;
ALTER TABLE tickers_v1 ADD COLUMN base_currency_name text;
ALTER TABLE tickers_v1 ADD COLUMN base_currency_symbol text;
ALTER TABLE tickers_v1 ADD COLUMN hq_address text;
ALTER TABLE tickers_v1 ADD COLUMN hq_state text;
ALTER TABLE tickers_v1 ADD COLUMN hq_country text;
ALTER TABLE tickers_v1 ADD COLUMN bloomberg text;
ALTER TABLE tickers_v1 ADD COLUMN sic int;
ALTER TABLE tickers_v1 ADD COLUMN lei text;

COMMIT;
