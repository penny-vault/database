from yoyo import step

__depends__ = ['0001.corporation', '0001.naics']

step(
    """
    ALTER TABLE corporation ADD naics INTEGER REFERENCES naics(naics) ON DELETE CASCADE
    """,
    """
    ALTER TABLE corporation DROP naics
    """
)