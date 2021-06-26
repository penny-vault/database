from yoyo import step

__depends__ = ['0001.security', '0001.source']

step(
    """
    CREATE TABLE dividend (
        date DATE NOT NULL,
        security INTEGER NOT NULL REFERENCES security(id) ON DELETE CASCADE,
        dividend DECIMAL(12, 4) NOT NULL,
        source INTEGER REFERENCES source(id) ON DELETE CASCADE,
        PRIMARY KEY (date, security)
    )
    """,
    "DROP TABLE dividend"
)