from yoyo import step

__depends__ = ['0002.portfolio']

steps = [
    # Add security name and ticker to transaction table
    step(
        """
        ALTER TABLE Transaction ADD COLUMN security_name text;
        """,
        """
        ALTER TABLE Transaction DROP COLUMN security_name;
        """
    ),
    step(
        """
        ALTER TABLE Transaction ADD COLUMN security_ticker VARCHAR(45);
        """,
        """
        ALTER TABLE Transaction DROP COLUMN security_ticker;
        """
    )
]
