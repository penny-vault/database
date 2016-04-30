from yoyo import step

__depends__ = []

step(
    """
    CREATE TABLE corporation (
        id SERIAL PRIMARY KEY,
        name VARCHAR(45) NOT NULL,
        cik INTEGER,
        ein INTEGER,
        open_for_business DATE,
        closed DATE,
        url varchar(128)
    )
    """,
    "DROP TABLE corporation"
)