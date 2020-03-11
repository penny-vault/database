from yoyo import step

__depends__ = ['0003.security']

step(
    """
    ALTER TABLE security ADD name VARCHAR(128)
    """,
    "ALTER TABLE security DROP name"
)

