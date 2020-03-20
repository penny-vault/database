from yoyo import step

__depends__ = ['0001.security', '0001.source']

step(
    """
    CREATE TYPE rating_action_t AS ENUM ('downgrade', 'upgrade', 'drop', 'initiate', 'reiterate', 'target lowered', 'target raised', 'target set');
    CREATE TYPE rating_t AS enUM ('sell', 'underperform', 'hold', 'outperform', 'buy'); 
    CREATE TABLE rating (
        date DATE NOT NULL,
        security INTEGER REFERENCES security(id) ON DELETE CASCADE,
        firm VARCHAR(128) NOT NULL,
        action rating_action_t NOT NULL,
        rating_from rating_t,
        rating_to rating_t,
        target_price_from NUMERIC(12,4),
        target_price_to NUMERIC(12,4),
        currency VARCHAR(8),
        source INTEGER REFERENCES source(id) ON DELETE CASCADE
    )
    """,
    """
    DROP TYPE rating_action_t;
    DROP TYPE rating_t;
    DROP TABLE rating;
    """
)
