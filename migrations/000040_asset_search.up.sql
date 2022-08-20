BEGIN;

ALTER TABLE assets
    ADD COLUMN search tsvector
        GENERATED ALWAYS AS (
            setweight(to_tsvector('pg_catalog.english', coalesce(ticker,'')), 'A') ||
            setweight(to_tsvector('pg_catalog.english', coalesce(name,'')), 'B') ||
            setweight(to_tsvector('pg_catalog.english', coalesce(composite_figi,'')), 'C')
    ) STORED;

CREATE INDEX assets_search_idx ON assets USING GIN (search);

COMMIT;