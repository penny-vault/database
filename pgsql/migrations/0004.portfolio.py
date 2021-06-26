from yoyo import step

__depends__ = ['0003.portfolio']

steps = [
    # portfolio access policy
    step(
        """
        CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
        """,
        """
        DROP EXTENSION timescaledb CASCADE;
        """
    ),
    step(
        """
        SELECT create_hypertable('portfolio_metric', 'date');
        """,
        """
        """
    ),
    step(
        """
        SELECT set_chunk_time_interval('portfolio_metric', INTERVAL '60 days');
        """,
        """
        """
    )
]
