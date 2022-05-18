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

ALTER TABLE assets RENAME COLUMN url TO corporate_url;
ALTER TABLE assets RENAME COLUMN logo TO logo_url;

DROP TABLE tickers_v1_tmp;

ALTER TABLE tickers_v1 RENAME TO assets;
ALTER INDEX tickers_v1_pkey RENAME TO assets_pkey;
ALTER INDEX tickers_v1_active_idx RENAME TO assets_active_idx;

ALTER TABLE eod_v1 RENAME TO eod;
ALTER INDEX eod_v1_pkey RENAME TO eod_pkey;
ALTER INDEX eod_v1_composite_figi_idx RENAME TO eod_composite_figi_idx;
ALTER INDEX eod_v1_event_date_idx RENAME TO eod_event_date_idx;
ALTER INDEX eod_v1_ticker_idx RENAME TO eod_ticker_idx;

ALTER TABLE market_holidays_v1 RENAME TO market_holidays;
ALTER INDEX market_holidays_v1_pkey RENAME TO market_holidays_pkey;

ALTER TABLE portfolio_holding_v1 RENAME TO portfolio_holdings;
ALTER INDEX portfolio_holding_v1_pkey RENAME TO portfolio_holdings_pkey;

ALTER TABLE portfolio_measurement_v1 RENAME TO portfolio_measurements;
ALTER INDEX portfolio_measurement_v1_pkey RENAME TO portfolio_measurements_pkey;

ALTER TABLE portfolio_transaction_v1 RENAME TO portfolio_transactions;
ALTER INDEX portfolio_transaction_v1_pkey RENAME TO portfolio_transactions_pkey;
ALTER INDEX portfolio_transaction_v1_portfolio_id_source_id_key RENAME TO portfolio_transactions_portfolios_id_source_id_key;

ALTER TABLE portfolio_v1 RENAME TO portfolios;
ALTER INDEX portfolio_v1_pkey RENAME TO portfolios_pkey;
ALTER INDEX portfolio_userid_idx RENAME TO portfolios_userid_idx;

ALTER TABLE reported_financials_v1 RENAME TO reported_financials;
ALTER INDEX reported_financials_v1_pkey RENAME TO reported_financials_pkey;

ALTER TABLE seeking_alpha_v1 RENAME TO seeking_alpha;
ALTER INDEX seeking_alpha_v1_pkey RENAME TO seeking_alpha_pkey;
ALTER INDEX seeking_alpha_v1_quant_idx RENAME TO seeking_alpha_quant_idx;

ALTER TABLE trading_days_v1 RENAME TO trading_days;
ALTER INDEX trading_days_v1_pkey RENAME TO trading_days_pkey;

ALTER TABLE zacks_financials_v1 RENAME TO zacks_financials;
ALTER INDEX zacks_financials_v1_pkey RENAME TO zacks_financials_pkey;

DROP VIEW health_v1;

CREATE VIEW health AS
    SELECT
        (SELECT (now() - INTERVAL '32 hours')::date) AS date,
        to_char((now() - INTERVAL '30 hours')::date, 'Day') as day_of_week,
        CASE WHEN (EXTRACT(isodow FROM (now() - INTERVAL '32 hours')::date) IN (6, 7)) THEN 2
             WHEN ((SELECT count(*) FROM eod WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) > 35000 AND
                   (SELECT count(*) FROM zacks_financials WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) > 3500 AND
                   (SELECT count(*) FROM risk_indicators WHERE event_date>(select (now() - INTERVAL '60 hours')::date)) >= 1) THEN 1
             ELSE 0
        END AS status,
        (SELECT count(*) FROM eod WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) AS eod_v1_cnt,
        (SELECT count(*) FROM zacks_financials WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) AS zacks_financials_v1_cnt,
        (SELECT count(*) FROM risk_indicators WHERE event_date>(select (now() - INTERVAL '60 hours')::date)) AS risk_indicators_v1_cnt;

GRANT SELECT ON health TO pvhealth;

COMMIT;
