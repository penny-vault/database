from yoyo import step

__depends__ = []

steps = [
    # Strategy Table
    step(
        """
        CREATE TABLE strategy (
            name VARCHAR(63) PRIMARY KEY,
            display_name VARCHAR(63) NOT NULL,
            params JSON
        )
        """,
        """
        DROP TABLE strategy
        """
    )
]
