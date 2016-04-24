from yoyo import step

__depends__ = ['0001.typecode', '0001.currency', '0001.exchange']

step(
    """
    CREATE TABLE security (
        id SERIAL PRIMARY KEY,
        symbol VARCHAR(45) NOT NULL,
        cusip CHAR(9),
        isin CHAR(12),
        sedol CHAR(7),
        typecode INT REFERENCES typecode(id),
        currency INT REFERENCES currency(id),
        exchange INT REFERENCES exchange(id)
    )
    """,
    "DROP TABLE security"
)