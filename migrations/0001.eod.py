from yoyo import step

__depends__ = ['0001.security', '0001.source']

step(
    """
    CREATE TABLE eod (
        date DATE NOT NULL,
        symbol INTEGER REFERENCES security(id) ON DELETE CASCADE,
        open DECIMAL(12, 4) NOT NULL,
        close DECIMAL(12, 4) NOT NULL,
        adj_close DECIMAL(12, 4) NOT NULL,
        high DECIMAL(12, 4) NOT NULL,
        low DECIMAL(12, 4) NOT NULL,
        source INTEGER REFERENCES source(id) ON DELETE CASCADE
    )
    """,
    "DROP TABLE eod"
)