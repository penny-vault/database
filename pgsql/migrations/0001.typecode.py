from yoyo import step

__depends__ = []

step(
    """
    CREATE TABLE typecode (
        id SERIAL PRIMARY KEY,
        name VARCHAR(45) NOT NULL
    )
    """,
    "DROP TABLE typecode"
)