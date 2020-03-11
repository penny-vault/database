from yoyo import step

__depends__ = ['0002.eod']

step(
    """
    CREATE INDEX eod_date_idx ON eod(date)
    """,
    "DROP INDEX eod_date_idx"
)
