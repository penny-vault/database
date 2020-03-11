from yoyo import step

__depends__ = []

step(
    """
    CREATE TABLE exchange (
        id SERIAL PRIMARY KEY,
        name VARCHAR(45)
    )
    """,
    "DROP TABLE exchange"
)