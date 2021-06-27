CREATE TYPE tax_disposition AS ENUM ('ltc', 'stc', 'deferred', 'roth');
CREATE TYPE tx_type AS ENUM ('deposit', 'sell', 'dividend', 'income', 'ltc', 'stc', 'buy', 'short', 'reinvest-dividend', 'reinvest-ltc', 'reinvest-stc', 'withdraw');
CREATE TABLE IF NOT EXISTS portfolio_transaction_v1 (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    cleared BOOL NOT NULL DEFAULT false,
    commission NUMERIC(14, 4),
    composite_figi text,
    event_date DATE NOT NULL,
    memo TEXT,
    num_shares NUMERIC(14, 4),
    portfolio_id UUID NOT NULL REFERENCES portfolio_v1(id) ON DELETE CASCADE,
    price_per_share NUMERIC(14, 4),
    source VARCHAR(128),
    source_id VARCHAR(128) NOT NULL DEFAULT uuid_generate_v4(),
    tags varchar[],
    tax_type tax_disposition,
    ticker text,
    total_cost NUMERIC(14, 4) NOT NULL,
    transaction_type tx_type NOT NULL,
    userid VARCHAR(63) NOT NULL DEFAULT current_user,
    UNIQUE (portfolio_id, source_id)
);

ALTER TABLE portfolio_transaction_v1 ENABLE ROW LEVEL SECURITY;
CREATE POLICY portfolio_transaction_v1_policy ON transaction
    USING (userid = current_user)
    WITH CHECK (userid = current_user);