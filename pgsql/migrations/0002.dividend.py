from yoyo import step

__depends__ = ['0001.dividend']

step(
    """
    CREATE INDEX dividend_symbol_idx ON dividend(security)
    """,
    "DROP INDEX dividend_symbol_idx"
)