-- Create portfolio tables that stores saved portfolios
BEGIN;
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.lastchanged = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE IF NOT EXISTS portfolio_v1 (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id VARCHAR(63) NOT NULL,
    name VARCHAR(32) NOT NULL,
    strategy_shortcode VARCHAR(8) NOT NULL,
    arguments JSONB NOT NULL,
    start_date TIMESTAMP NOT NULL DEFAULT now(),
    ytd_return FLOAT,
    cagr_since_inception FLOAT,
    notifications INT NOT NULL DEFAULT 1,
    created TIMESTAMP NOT NULL DEFAULT now(),
    lastchanged TIMESTAMP NOT NULL DEFAULT now()
);
CREATE INDEX portfolio_userid_idx ON portfolio_v1(user_id);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON portfolio_v1
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

COMMIT;
