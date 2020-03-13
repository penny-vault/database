from yoyo import step

__depends__ = ['0006.security']

step(
    """
    ALTER TABLE security ADD start_date TIMESTAMP;
    ALTER TABLE security ADD end_date TIMESTAMP;
    """,
    """
    ALTER TABLE security DROP start_date;
    ALTER TABLE security DROP end_date;
    """
)
