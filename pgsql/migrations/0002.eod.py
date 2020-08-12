from yoyo import step

__depends__ = ['0001.eod']

step(
    """
    CREATE INDEX eod_symbol_idx ON eod(security)
    """,
    "DROP INDEX eod_symbol_idx"
)