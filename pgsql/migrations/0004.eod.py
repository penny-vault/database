from yoyo import step

__depends__ = ['0003.eod']

step(
    """
    ALTER TABLE eod ADD CONSTRAINT date_security_key UNIQUE (date, security);
    """,
    """
    ALTER TABLE  eod DROP CONSTRAINT date_security_key
    """
)
