BEGIN;
CREATE TYPE tax_disposition AS ENUM ('LTC', 'STC', 'DEFERRED', 'ROTH');
CREATE TYPE tx_type AS ENUM ('DEPOSIT', 'SELL', 'DIVIDEND', 'LTC', 'STC', 'BUY', 'WITHDRAW', 'MARKER', 'SPLIT');
CREATE TABLE IF NOT EXISTS portfolio_transaction_v1 (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    cleared BOOL NOT NULL DEFAULT false,
    commission NUMERIC(9, 2) NOT NULL DEFAULT 0.0,
    composite_figi TEXT,
    event_date DATE NOT NULL,
    justification JSONB,
    memo TEXT,
    num_shares NUMERIC(15, 5),
    portfolio_id UUID NOT NULL REFERENCES portfolio_v1(id) ON DELETE CASCADE,
    price_per_share NUMERIC(15, 5) CHECK (price_per_share >= 0.0),
    sequence_num INT NOT NULL DEFAULT 0,
    source VARCHAR(128),
    source_id bytea NOT NULL DEFAULT uuid_send(uuid_generate_v4()),
    tags varchar[],
    tax_type tax_disposition,
    ticker text,
    total_value NUMERIC(15, 5) NOT NULL,
    transaction_type tx_type NOT NULL,
    user_id VARCHAR(63) NOT NULL DEFAULT current_user,
    UNIQUE (portfolio_id, source_id)
);

ALTER TABLE portfolio_transaction_v1 ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_id_policy ON portfolio_transaction_v1
    USING (user_id = current_user)
    WITH CHECK (user_id = current_user);
COMMIT;