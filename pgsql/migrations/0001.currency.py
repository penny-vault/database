from yoyo import step

__depends__ = []

step(
    """
    CREATE TABLE currency (
        id SERIAL PRIMARY KEY,
        name VARCHAR(45),
        country VARCHAR(45),
        symbol CHAR(1),
        isocode VARCHAR(3) NOT NULL
    )
    """,
    "DROP TABLE currency"
)