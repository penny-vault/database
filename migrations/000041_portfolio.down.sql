BEGIN;

ALTER TABLE portfolios DROP COLUMN account_number;
ALTER TABLE portfolios DROP COLUMN brokerage;
ALTER TABLE portfolios DROP COLUMN account_type;
ALTER TABLE portfolios DROP COLUMN is_open;
ALTER TABLE portfolios DROP COLUMN last_viewed;
ALTER TABLE portfolios DROP COLUMN tax_lot_bytes;
ALTER TABLE portfolios DROP COLUMN tax_lot_method;
ALTER TABLE portfolios DROP COLUMN portfolio_type;
ALTER TABLE portfolios DROP COLUMN linked_portfolios;
ALTER TABLE portfolios DROP COLUMN fractional_shares_precision;

ALTER TABLE portfolio_transactions DROP COLUMN gain_loss;
ALTER TABLE portfolio_transactions DROP COLUMN related;

ALTER TABLE portfolio_measurements DROP COLUMN tax_lots;
ALTER TABLE portfolio_measurements DROP COLUMN after_tax_return;
ALTER TABLE portfolio_measurements DROP COLUMN before_tax_return;
ALTER TABLE portfolio_measurements DROP COLUMN tax_cost_ratio;
ALTER TABLE portfolio_measurements DROP COLUMN long_term_capital_gain;
ALTER TABLE portfolio_measurements DROP COLUMN short_term_capital_gain;
ALTER TABLE portfolio_measurements DROP COLUMN unrealized_long_term_capital_gain;
ALTER TABLE portfolio_measurements DROP COLUMN unrealized_short_term_capital_gain;
ALTER TABLE portfolio_measurements DROP COLUMN qualified_dividend;
ALTER TABLE portfolio_measurements DROP COLUMN non_qualified_dividend_and_interest_income;

ALTER TABLE portfolios DROP COLUMN tax_cost_ratio;
DROP TABLE IF EXISTS profile CASCADE;

COMMIT;