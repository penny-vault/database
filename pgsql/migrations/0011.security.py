from yoyo import step

__depends__ = ['0010.security',]

step(
    """
    ALTER TABLE security ADD COLUMN cik VARCHAR(12);
    ALTER TABLE security ADD COLUMN figiuid VARCHAR(18);
    ALTER TABLE security ADD COLUMN scfigi VARCHAR(12);
    ALTER TABLE security ADD COLUMN cfigi VARCHAR(12);
    ALTER TABLE security ADD COLUMN figi VARCHAR(12);
    """,
    """
    ALTER TABLE security DROP COLUMN cik;
    ALTER TABLE security DROP COLUMN figiuid;
    ALTER TABLE security DROP COLUMN scfigi;
    ALTER TABLE security DROP COLUMN cfigi;
    ALTER TABLE security DROP COLUMN figi;
    """
)