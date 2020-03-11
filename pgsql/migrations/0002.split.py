from yoyo import step

__depends__ = ['0001.split']

step(
    """
    CREATE INDEX split_symbol_idx ON split(security)
    """,
    "DROP INDEX split_symbol_idx"
)