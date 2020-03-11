from yoyo import step

__depends__ = []

step(
    """
    CREATE TABLE quandl (
        database VARCHAR(45),
        dataset VARCHAR(45),
        security INTEGER NOT NULL REFERENCES security(id) ON DELETE CASCADE
    )
    """,
    "DROP TABLE quandl"
)
