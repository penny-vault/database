from yoyo import step

__depends__ = ['0002.security',]

step(
    """
    ALTER TABLE security ADD COLUMN active BOOLEAN DEFAULT 'f'
    """,
    "ALTER TABLE security DROP COLUMN active"
)
