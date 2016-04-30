from yoyo import step

__depends__ = ['0005.security']

step(
    """
    ALTER TABLE security ADD corporation INTEGER REFERENCES corporation(id) ON DELETE CASCADE
    """,
    "ALTER TABLE security DROP corporation"
)
