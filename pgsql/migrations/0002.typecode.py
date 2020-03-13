from yoyo import step

__depends__ = ['0001.typecode', '0010.security']

step(
    """
    ALTER TABLE security DROP typecode;
    DROP TABLE typecode;
    CREATE TYPE typecode_t AS ENUM ('unknown', 'fund', 'stock', 'bond', 'index', 'etf', 'future', 'currency', 'option');
    ALTER TABLE security ADD typecode typecode_t;
    ALTER TABLE security ALTER COLUMN typecode SET DEFAULT 'unknown';
    UPDATE security SET typecode='unknown' WHERE typecode is NULL;
    ALTER TABLE security ALTER COLUMN typecode SET NOT NULL;
    """,
    """
    ALERT TABLE security DROP typecode;
    DROP TYPE typecode_t;
    CREATE TABLE typecode (
        id SERIAL PRIMARY KEY,
        name VARCHAR(45) NOT NULL
    );
    """
)
