from yoyo import step

__depends__ = ['0001.exchange']

step(
    """
    ALTER TABLE exchange ADD description TEXT; 
    """,
    """
    ALTER TABLE exchange DROP description;
    """
)
