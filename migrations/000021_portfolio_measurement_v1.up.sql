BEGIN;

ALTER TABLE portfolio_measurement_v1 DROP COLUMN percent_return;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN alpha_1yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN alpha_3yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN alpha_5yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN alpha_10yr REAL;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN beta_1yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN beta_3yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN beta_5yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN beta_10yr REAL;

-- Time-Weighted Rate of Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_1d REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_1wk REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_1mo REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_3mo REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_1yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_3yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_5yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_10yr REAL;

-- Money-Weighted Rate of Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_1d REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_1wk REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_1mo REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_3mo REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_1yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_3yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_5yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_10yr REAL;

-- Active Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 ADD COLUMN active_return_1yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN active_return_3yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN active_return_5yr REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN active_return_10yr REAL;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN calmar_ratio REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN downside_deviation REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN information_ratio REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN k_ratio REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN keller_ratio REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN sharpe_ratio REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN sortino_ratio REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN std_dev REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN treynor_ratio REAL;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN ulcer_index REAL;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN benchmark_value DOUBLE PRECISION;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN strategy_growth_of_10k DOUBLE PRECISION;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN benchmark_growth_of_10k DOUBLE PRECISION;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN risk_free_growth_of_10k DOUBLE PRECISION;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN strategy_value DOUBLE PRECISION;
UPDATE portfolio_measurement_v1 SET strategy_value = value WHERE portfolio_id IS NOT NULL;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN value;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN risk_free_value_tmp DOUBLE PRECISION;
UPDATE portfolio_measurement_v1 SET risk_free_value_tmp = risk_free_value WHERE portfolio_id IS NOT NULL;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN risk_free_value;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN risk_free_value DOUBLE PRECISION;
UPDATE portfolio_measurement_v1 SET risk_free_value = risk_free_value_tmp WHERE portfolio_id IS NOT NULL;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN risk_free_value_tmp;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN total_deposited_to_date_tmp DOUBLE PRECISION;
UPDATE portfolio_measurement_v1 SET total_deposited_to_date_tmp = total_deposited_to_date WHERE portfolio_id IS NOT NULL;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN total_deposited_to_date;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN total_deposited_to_date DOUBLE PRECISION;
UPDATE portfolio_measurement_v1 SET total_deposited_to_date = total_deposited_to_date_tmp WHERE portfolio_id IS NOT NULL;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN total_deposited_to_date_tmp;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN total_withdrawn_to_date_tmp DOUBLE PRECISION;
UPDATE portfolio_measurement_v1 SET total_withdrawn_to_date_tmp = total_withdrawn_to_date WHERE portfolio_id IS NOT NULL;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN total_withdrawn_to_date;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN total_withdrawn_to_date DOUBLE PRECISION;
UPDATE portfolio_measurement_v1 SET total_withdrawn_to_date = total_withdrawn_to_date_tmp WHERE portfolio_id IS NOT NULL;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN total_withdrawn_to_date_tmp;

ALTER TABLE portfolio_v1 DROP COLUMN performance_json;
ALTER TABLE portfolio_v1 ADD COLUMN performance_bytes BYTEA;

COMMIT;