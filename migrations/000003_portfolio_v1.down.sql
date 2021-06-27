--- Remove metrics from portfolio table
BEGIN;

ALTER TABLE portfolio_v1 DROP COLUMN cagr_3yr;
ALTER TABLE portfolio_v1 DROP COLUMN cagr_5yr;
ALTER TABLE portfolio_v1 DROP COLUMN cagr_10yr;
ALTER TABLE portfolio_v1 DROP COLUMN std_dev;
ALTER TABLE portfolio_v1 DROP COLUMN downside_deviation;
ALTER TABLE portfolio_v1 DROP COLUMN max_draw_down;
ALTER TABLE portfolio_v1 DROP COLUMN avg_draw_down;
ALTER TABLE portfolio_v1 DROP COLUMN sharpe_ratio;
ALTER TABLE portfolio_v1 DROP COLUMN sortino_ratio;
ALTER TABLE portfolio_v1 DROP COLUMN ulcer_index;

COMMIT;