from yoyo import step

__depends__ = ['0001.corporation', '0001.naics']

step(
    """
    ALTER TABLE corporation ADD naics INTEGER
    """,
    """
    ALTER TABLE corporation DROP naics
    """
)
