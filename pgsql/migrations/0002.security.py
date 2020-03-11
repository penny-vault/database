from yoyo import step

__depends__ = ['0001.security',]

step(
    """
    CREATE INDEX security_symbol_idx ON security(symbol)
    """,
    "DROP INDEX security_symbol_idx"
)