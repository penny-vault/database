BEGIN;

ALTER TABLE portfolios ADD COLUMN account_number TEXT;
ALTER TABLE portfolios ADD COLUMN brokerage TEXT;
ALTER TABLE portfolios ADD COLUMN account_type TEXT;
ALTER TABLE portfolios ADD COLUMN is_open BOOLEAN;
ALTER TABLE portfolios ADD COLUMN last_viewed TIMESTAMP;
ALTER TABLE portfolios ADD COLUMN tax_lot_bytes BYTEA;
ALTER TABLE portfolios ADD COLUMN tax_lot_method TEXT;
ALTER TABLE portfolios ADD COLUMN portfolio_type TEXT;
ALTER TABLE portfolios ADD COLUMN linked_portfolios TEXT[];
ALTER TABLE portfolios ADD COLUMN fractional_shares_precision SMALLINT DEFAULT 3;

ALTER TABLE portfolio_transactions ADD COLUMN gain_loss NUMERIC(12, 5) DEFAULT 0.0;
ALTER TABLE portfolio_transactions ADD COLUMN related TEXT[];

ALTER TABLE portfolio_measurements ADD COLUMN tax_lots BYTEA;
ALTER TABLE portfolio_measurements ADD COLUMN after_tax_return REAL;
ALTER TABLE portfolio_measurements ADD COLUMN before_tax_return REAL;
ALTER TABLE portfolio_measurements ADD COLUMN tax_cost_ratio REAL;
ALTER TABLE portfolio_measurements ADD COLUMN long_term_capital_gain REAL;
ALTER TABLE portfolio_measurements ADD COLUMN short_term_capital_gain REAL;
ALTER TABLE portfolio_measurements ADD COLUMN unrealized_long_term_capital_gain REAL;
ALTER TABLE portfolio_measurements ADD COLUMN unrealized_short_term_capital_gain REAL;
ALTER TABLE portfolio_measurements ADD COLUMN qualified_dividend REAL;
ALTER TABLE portfolio_measurements ADD COLUMN non_qualified_dividend_and_interest_income REAL;

ALTER TYPE tax_disposition ADD VALUE IF NOT EXISTS 'QUALIFIED';
ALTER TYPE tax_disposition ADD VALUE IF NOT EXISTS 'NON-QUALIFIED';

-- tax_cost_ratio = (1-[(1+ R_after_tax)/(1 + R_before_tax)]) X 100
ALTER TABLE portfolios ADD COLUMN tax_cost_ratio REAL;

CREATE TABLE profile (
    user_id CHARACTER VARYING(63) PRIMARY KEY DEFAULT CURRENT_USER NOT NULL,
    interest_income_and_non_qualified_dividends REAL DEFAULT .35,
    qualified_dividend_rate REAL DEFAULT .15,
    ltc_tax_rate REAL DEFAULT .15,
    stc_tax_rate REAL DEFAULT .35
);

ALTER TABLE profile ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_id_policy ON profile USING (((user_id)::text = CURRENT_USER)) WITH CHECK (((user_id)::text = CURRENT_USER));
GRANT select, insert, update, delete ON profile TO pvuser;

ALTER TYPE datasource ADD VALUE IF NOT EXISTS 'zacks.com';

COMMIT;