from yoyo import step

__depends__ = []

step(
    """
    CREATE TABLE naics (
        naics integer NOT NULL,
        name VARCHAR(200) NOT NULL
    )
    """,
    "DROP TABLE naics"
)
