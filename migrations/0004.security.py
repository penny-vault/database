from yoyo import step

__depends__ = ['0003.security.py']

step(
    """
    ALTER TABLE security ADD corporation REFERENCES corporation(id) ON DELETE CASCADE
    """,
    "ALTER TABLE security DROP corporation"
)
step(
    """
    ALTER TABLE security ADD name VARCHAR(128)
    """,
    "ALTER TABLE security DROP name"
)

