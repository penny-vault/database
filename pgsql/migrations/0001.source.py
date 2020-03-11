from yoyo import step

__depends__ = []

step(
    """
    CREATE TABLE source (
        id SERIAL PRIMARY KEY,
        name VARCHAR(45)
    )
    """,
    "DROP TABLE source"
)