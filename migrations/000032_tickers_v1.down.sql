BEGIN;

ALTER TABLE assets RENAME TO tickers_v1;

ALTER TABLE eod RENAME TO eod_v1;
ALTER TABLE market_holidays RENAME TO market_holidays_v1;
ALTER TABLE portfolio_holdings RENAME TO portfolio_holding_v1;
ALTER TABLE portfolio_measurements RENAME TO portfolio_measurement_v1;
ALTER TABLE portfolio_transactions RENAME TO portfolio_transaction_v1;
ALTER TABLE portfolios RENAME TO portfolio_v1;
ALTER TABLE reported_financials RENAME TO reported_financials_v1;
ALTER TABLE seeking_alpha RENAME TO seeking_alpha_v1;
ALTER TABLE trading_days RENAME TO trading_days_v1;
ALTER TABLE zacks_financials RENAME TO zacks_financials_v1;

ALTER INDEX assets_pkey RENAME TO tickers_v1_pkey;
ALTER INDEX assets_active_idx RENAME TO tickers_v1_active_idx;

ALTER INDEX assets_pkey RENAME TO tickers_v1_pkey;
ALTER INDEX assets_active_idx RENAME TO tickers_v1_active_idx;
ALTER INDEX eod_pkey RENAME TO eod_v1_pkey;
ALTER INDEX eod_composite_figi_idx RENAME TO eod_v1_composite_figi_idx;
ALTER INDEX eod_event_date_idx RENAME TO eod_v1_event_date_idx;
ALTER INDEX eod_ticker_idx RENAME TO eod_v1_ticker_idx;
ALTER INDEX market_holidays_pkey RENAME TO market_holidays_v1_pkey;
ALTER INDEX portfolio_holdings_pkey RENAME TO portfolio_holding_v1_pkey;
ALTER INDEX portfolio_measurements_pkey RENAME TO portfolio_measurement_v1_pkey;
ALTER INDEX portfolio_transactions_pkey RENAME TO portfolio_transaction_v1_pkey;
ALTER INDEX portfolio_transactions_portfolios_id_source_id_key RENAME TO portfolio_transaction_v1_portfolio_id_source_id_key;
ALTER INDEX portfolios_pkey RENAME TO portfolio_v1_pkey;
ALTER INDEX portfolios_userid_idx RENAME TO portfolio_userid_idx;
ALTER INDEX reported_financials_pkey RENAME TO reported_financials_v1_pkey;
ALTER INDEX seeking_alpha_pkey RENAME TO seeking_alpha_v1_pkey;
ALTER INDEX seeking_alpha_quant_idx RENAME TO seeking_alpha_v1_quant_idx;
ALTER INDEX trading_days_pkey RENAME TO trading_days_v1_pkey;
ALTER INDEX zacks_financials_pkey RENAME TO zacks_financials_v1_pkey;

CREATE VIEW health_v1 AS
    SELECT
        (SELECT (now() - INTERVAL '32 hours')::date) AS date,
        to_char((now() - INTERVAL '30 hours')::date, 'Day') as day_of_week,
        CASE WHEN (EXTRACT(isodow FROM (now() - INTERVAL '32 hours')::date) IN (6, 7)) THEN 2
             WHEN ((SELECT count(*) FROM eod_v1 WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) > 35000 AND
                   (SELECT count(*) FROM zacks_financials_v1 WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) > 3500 AND
                   (SELECT count(*) FROM risk_indicators_v1 WHERE event_date>(select (now() - INTERVAL '60 hours')::date)) >= 1) THEN 1
             ELSE 0
        END AS status,
        (SELECT count(*) FROM eod_v1 WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) AS eod_v1_cnt,
        (SELECT count(*) FROM zacks_financials_v1 WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) AS zacks_financials_v1_cnt,
        (SELECT count(*) FROM risk_indicators_v1 WHERE event_date>(select (now() - INTERVAL '60 hours')::date)) AS risk_indicators_v1_cnt;

GRANT SELECT ON health_v1 TO pvhealth;

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
