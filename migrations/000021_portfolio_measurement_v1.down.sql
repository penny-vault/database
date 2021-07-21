BEGIN;

-- Values stored ass with 2 decimal digits (i.e. they must be
-- divided by 100)

-- Adds 60-bytes of storage, calculated daily for a 30-yr portfolio this equals
-- 60 * 252 * 30 / 1024 = 443 KB of disk space required

ALTER TABLE portfolio_measurement_v1 ADD COLUMN percent_return NUMERIC(12, 11) NOT NULL CHECK (percent_return <= 1.0 AND percent_return >= -1.0);

ALTER TABLE portfolio_measurement_v1 DROP COLUMN alpha_1yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN alpha_3yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN alpha_5yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN alpha_10yr;

ALTER TABLE portfolio_measurement_v1 DROP COLUMN beta_1yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN beta_3yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN beta_5yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN beta_10yr;

-- Time-Weighted Rate of Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 DROP COLUMN twrr_1d;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN twrr_1wk;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN twrr_1mo;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN twrr_3mo;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN twrr_1yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN twrr_3yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN twrr_5yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN twrr_10yr;

-- Money-Weighted Rate of Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 DROP COLUMN mwrr_1d;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN mwrr_1wk;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN mwrr_1mo;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN mwrr_3mo;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN mwrr_1yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN mwrr_3yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN mwrr_5yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN mwrr_10yr;

-- Active Return (Periods > 1yr are annualized)
ALTER TABLE portfolio_measurement_v1 DROP COLUMN active_return_1yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN active_return_3yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN active_return_5yr;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN active_return_10yr;

ALTER TABLE portfolio_measurement_v1 DROP COLUMN calmar_ratio;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN downside_deviation;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN information_ratio;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN k_ratio;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN keller_ratio;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN sharpe_ratio;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN sortino_ratio;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN std_dev;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN treynor_ratio;
ALTER TABLE portfolio_measurement_v1 DROP COLUMN ulcer_index;

COMMIT;