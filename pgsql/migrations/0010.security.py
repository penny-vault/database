from yoyo import step

__depends__ = ['0009.security']

step(
    """
    ALTER TABLE security ADD share_class VARCHAR(45);
    """,
    """
    ALTER TABLE security DROP share_class;
    """
)

