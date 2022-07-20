BEGIN;

CREATE TABLE portfolio_holdings (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    composite_figi text NOT NULL,
    event_date date NOT NULL,
    percent_portfolio numeric(12,11) NOT NULL,
    portfolio_id uuid NOT NULL REFERENCES portfolios(id) ON DELETE CASCADE,
    shares numeric(14,4) NOT NULL,
    ticker text NOT NULL,
    user_id character varying(63) DEFAULT CURRENT_USER NOT NULL,
    value numeric(14,4) NOT NULL,
    CONSTRAINT portfolio_holding_v1_percent_portfolio_check CHECK (((percent_portfolio <= 1.0) AND (percent_portfolio >= 0.0))),
    CONSTRAINT portfolio_holding_v1_value_check CHECK ((value >= 0.0))
);

ALTER TABLE portfolio_holdings ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_id_policy ON portfolio_holdings USING (((user_id)::text = CURRENT_USER)) WITH CHECK (((user_id)::text = CURRENT_USER));
GRANT select, insert, update, delete ON portfolio_holdings TO pvuser;

COMMIT;