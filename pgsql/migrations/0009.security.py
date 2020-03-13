from yoyo import step

__depends__ = ['0008.security']

step(
    """
    ALTER TABLE security DROP name;
    ALTER TABLE security ADD name TEXT;
    """,
    """
    ALTER TABLE security DROP name;
    ALTER TABLE security ADD name VARCHAR(128);
    """
)

