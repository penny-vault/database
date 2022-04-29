-- Modify tickers_v1 to fix typos in column names and remove unused columns
-- WARNING: This is not a backwards compatible change and some data alterations
-- are irreversible. Maintaining the _v1 moniker because the fields we are removing
-- are only referenced by data ingest scripts
BEGIN;

CREATE TYPE assettype AS ENUM (
    'Common Stock',
    'Preferred Stock',
    'Exchange Traded Fund',
    'Exchange Traded Note',
    'Mutual Fund',
    'Closed-End Fund',
    'American Depository Receipt Common'
);

ALTER TABLE tickers_v1 ADD COLUMN asset_type assettype NOT NULL DEFAULT 'Common Stock';

DELETE FROM tickers_v1 WHERE type IN ('ADRR', 'ADRP')
UPDATE tickers_v1 SET asset_type = 'Common Stock' WHERE type IN ('Stock', 'CS');
UPDATE tickers_v1 SET asset_type = 'American Depository Receipt Common' WHERE type IN ('ADR', 'ADRC');
UPDATE tickers_v1 SET asset_type = 'Exchange Traded Fund' WHERE type = 'ETF';
UPDATE tickers_v1 SET asset_type = 'Exchange Traded Note' WHERE type = 'ETN';
UPDATE tickers_v1 SET asset_type = 'Closed-End Fund' WHERE type = 'FUND';
UPDATE tickers_v1 SET asset_type = 'Mutual Fund' WHERE type in ('MF', 'Mutual Fund');

ALTER TABLE tickers_v1 DROP COLUMN type;
ALTER TABLE tickers_v1 DROP COLUMN ceo;
ALTER TABLE tickers_v1 DROP COLUMN phone;
ALTER TABLE tickers_v1 DROP COLUMN emplyees;
ALTER TABLE tickers_v1 DROP COLUMN marketcap;
ALTER TABLE tickers_v1 DROP COLUMN market;
ALTER TABLE tickers_v1 DROP COLUMN locale;
ALTER TABLE tickers_v1 DROP COLUMN currency_name;
ALTER TABLE tickers_v1 DROP COLUMN currency_symbol;
ALTER TABLE tickers_v1 DROP COLUMN base_currency_name;
ALTER TABLE tickers_v1 DROP COLUMN base_currency_symbol;
ALTER TABLE tickers_v1 DROP COLUMN hq_address;
ALTER TABLE tickers_v1 DROP COLUMN hq_state;
ALTER TABLE tickers_v1 DROP COLUMN hq_country;
ALTER TABLE tickers_v1 DROP COLUMN bloomberg;
ALTER TABLE tickers_v1 DROP COLUMN sic;
ALTER TABLE tickers_v1 DROP COLUMN lei;

DROP TABLE tickers_v1_tmp;

ALTER TABLE tickers_v1 RENAME TO tickers;
ALTER VIEW health_v1 RENAME TO health;
ALTER TABLE eod_v1 RENAME TO eod;
ALTER TABLE market_holidays_v1 RENAME TO market_holidays;
ALTER TABLE portfolio_holding_v1 RENAME TO portfolio_holding;
ALTER TABLE portfolio_measurement_v1 RENAME TO portfolio_measurement;
ALTER TABLE portfolio_transaction_v1 RENAME TO portfolio_transaction;
ALTER TABLE portfolio_v1 RENAME TO portfolio;
ALTER TABLE reported_financials_v1 RENAME TO reported_financials;
ALTER TABLE seeking_alpha_v1 RENAME TO seeking_alpha;
ALTER TABLE trading_days_v1 RENAME TO trading_days;
ALTER TABLE zacks_financials_v1 RENAME TO zacks_financials;

COMMIT;
