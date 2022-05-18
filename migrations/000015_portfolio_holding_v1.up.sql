BEGIN;
CREATE TABLE IF NOT EXISTS portfolio_holding_v1 (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    composite_figi TEXT NOT NULL,
    event_date DATE NOT NULL,
    percent_portfolio NUMERIC(12, 11) NOT NULL CHECK (percent_portfolio <= 1.0 AND percent_portfolio >= 0.0),
    portfolio_id UUID NOT NULL REFERENCES portfolio_v1(id) ON DELETE CASCADE,
    shares NUMERIC(14, 4) NOT NULL,
    ticker TEXT NOT NULL,
    user_id VARCHAR(63) NOT NULL DEFAULT current_user,
    value NUMERIC(14, 4) NOT NULL CHECK (value >= 0.0)
);

ALTER TABLE portfolio_holding_v1 ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_id_policy ON portfolio_holding_v1
    USING (user_id = current_user)
    WITH CHECK (user_id = current_user);
COMMIT;
