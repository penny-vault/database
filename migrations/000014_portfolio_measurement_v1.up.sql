BEGIN;
CREATE TABLE IF NOT EXISTS portfolio_measurement_v1 (
    event_date DATE NOT NULL,
    percent_return NUMERIC(12, 11) NOT NULL CHECK (percent_return <= 1.0 AND percent_return >= -1.0),
    portfolio_id UUID NOT NULL REFERENCES portfolio_v1(id) ON DELETE CASCADE,
    risk_free_value NUMERIC(14, 4) NOT NULL CHECK (risk_free_value >= 0.0),
    total_deposited_to_date NUMERIC(14, 4) NOT NULL CHECK (total_deposited_to_date >= 0.0),
    total_withdrawn_to_date NUMERIC(14, 4) NOT NULL CHECK (total_withdrawn_to_date <= 0.0),
    user_id VARCHAR(63) NOT NULL DEFAULT current_user,
    value NUMERIC(14, 4) NOT NULL CHECK (value >= 0.0),
    PRIMARY KEY (user_id, portfolio_id, event_date)
);

ALTER TABLE portfolio_measurement_v1 ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_id_policy ON portfolio_measurement_v1
    USING (user_id = current_user)
    WITH CHECK (user_id = current_user);
COMMIT;