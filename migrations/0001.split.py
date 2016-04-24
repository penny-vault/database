from yoyo import step

__depends__ = ['0001.security', '0001.source']

step(
    """
    CREATE TABLE split (
        date DATE NOT NULL,
        security INTEGER REFERENCES security(id) ON DELETE CASCADE,
        split_from smallint NOT NULL,
        split_to smallint NOT NULL
        source INTEGER REFERENCES source(id) ON DELETE CASCADE
    )
    """,
    "DROP TABLE split"
)