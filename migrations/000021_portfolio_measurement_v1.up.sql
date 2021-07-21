BEGIN;

-- Values stored as smallints with 2 decimal digits (i.e. they must be
-- divided by 100)

ALTER TABLE portfolio_measurement_v1 DROP COLUMN percent_return;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN alpha_1yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN alpha_3yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN alpha_5yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN alpha_10yr SMALLINT;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN beta_1yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN beta_3yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN beta_5yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN beta_10yr SMALLINT;

-- Time-Weighted Rate of Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_1d SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_1wk SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_1mo SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_3mo SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_1yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_3yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_5yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN twrr_10yr SMALLINT;

-- Money-Weighted Rate of Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_1d SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_1wk SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_1mo SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_3mo SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_1yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_3yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_5yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN mwrr_10yr SMALLINT;

-- Active Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 ADD COLUMN active_return_1yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN active_return_3yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN active_return_5yr SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN active_return_10yr SMALLINT;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN calmar_ratio SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN downside_deviation SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN information_ratio SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN k_ratio SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN keller_ratio SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN sharpe_ratio SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN sortino_ratio SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN std_dev SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN treynor_ratio SMALLINT;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN ulcer_index SMALLINT;

COMMIT;