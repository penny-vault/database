from yoyo import step

__depends__ = ['0007.security', '0001.source']

step(
    """
    ALTER TABLE security ADD source INTEGER REFERENCES source(id) ON DELETE CASCADE
    """,
    "ALTER TABLE security DROP source"
)
