from yoyo import step

__depends__ = ['0004.security']

step(
    """
    DROP INDEX security_symbol_idx;
    ALTER TABLE security RENAME COLUMN symbol TO ticker;
    CREATE INDEX security_ticker_idx ON security(ticker);
    """,
    """
    DROP INDEX security_ticker_idx;
    ALTER TABLE security RENAME COLUMN ticker TO symbol;
    CREATE INDEX security_symbol_idx ON security(symbol);
    """
)

