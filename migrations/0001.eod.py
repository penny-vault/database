from yoyo import step

__depends__ = ['0001.security', '0001.source']

step(
    """
    CREATE TABLE eod (
        date DATE NOT NULL,
        security INTEGER NOT NULL REFERENCES security(id) ON DELETE CASCADE,
        open DECIMAL(12, 4),
        close DECIMAL(12, 4),
        adj_close DECIMAL(12, 4),
        high DECIMAL(12, 4),
        low DECIMAL(12, 4),
        volume bigint,
        source INTEGER REFERENCES source(id) ON DELETE CASCADE
    )
    """,
    "DROP TABLE eod"
)