--- Add metrics to portfolio table
BEGIN;

ALTER TABLE portfolio_v1 ADD COLUMN cagr_3yr real;
ALTER TABLE portfolio_v1 ADD COLUMN cagr_5yr real;
ALTER TABLE portfolio_v1 ADD COLUMN cagr_10yr real;
ALTER TABLE portfolio_v1 ADD COLUMN std_dev real;
ALTER TABLE portfolio_v1 ADD COLUMN downside_deviation real;
ALTER TABLE portfolio_v1 ADD COLUMN max_draw_down real;
ALTER TABLE portfolio_v1 ADD COLUMN avg_draw_down real;
ALTER TABLE portfolio_v1 ADD COLUMN sharpe_ratio real;
ALTER TABLE portfolio_v1 ADD COLUMN sortino_ratio real;
ALTER TABLE portfolio_v1 ADD COLUMN ulcer_index real;

COMMIT;