-- A variety of changes that makes postgresql more efficient
-- at storing individual rows
BEGIN;

-- Create a view showing table disk space used
CREATE VIEW relation_size AS (
    WITH my_relation_size AS (
        SELECT
            t.schemaname,
            t.tablename,
            pg_table_size('"' || t.schemaname || '"."' || t.tablename || '"') / (1024*1024) AS table_size_mb,
            NULL as indexname,
            NULL as index_size_mb
        FROM pg_tables t

        UNION ALL

        SELECT
            i.schemaname,
            i.tablename,
            NULL,
            i.indexname,
            pg_relation_size('"' || i.schemaname || '"."' || i.indexname || '"') / (1024 * 1024)
        FROM pg_indexes i
        )
    SELECT
        COALESCE(tablename, indexname) as table_name,
        indexname as index_name,
        COALESCE(table_size_mb, index_size_mb) AS size_mb
    FROM my_relation_size
    WHERE schemaname='public' AND (table_size_mb >= 1 OR index_size_mb >= 1)
    ORDER BY size_mb DESC
);

-- seeking alpha
DELETE FROM seeking_alpha WHERE composite_figi='';
ALTER TABLE seeking_alpha
    ALTER COLUMN ticker TYPE VARCHAR(10),
    ALTER COLUMN composite_figi TYPE CHAR(12),
    ALTER COLUMN market_cap_mil TYPE int USING market_cap_mil::int;
ALTER TABLE seeking_alpha
    DROP CONSTRAINT seeking_alpha_pkey,
    ADD CONSTRAINT seeking_alpha_composite_figi_check
        CHECK (LENGTH(TRIM(BOTH composite_figi)) = 12),
    ADD PRIMARY KEY (composite_figi, event_date);
CREATE INDEX seeking_alpha_ticker_idx ON seeking_alpha (ticker);

-- zacks financials
DELETE FROM zacks_financials WHERE composite_figi='';
ALTER TABLE zacks_financials
    ALTER COLUMN ticker TYPE VARCHAR(10),
    ALTER COLUMN composite_figi TYPE CHAR(12),
    ALTER COLUMN month_of_fiscal_yr_end TYPE smallint USING month_of_fiscal_yr_end::smallint,
    ALTER COLUMN sector TYPE VARCHAR(25),
    ALTER COLUMN industry TYPE VARCHAR(75),
    ALTER COLUMN shares_outstanding_mil TYPE int,
    ALTER COLUMN market_cap_mil TYPE int USING market_cap_mil::int,
    ALTER COLUMN avg_volume TYPE int USING avg_volume::int,
    ALTER COLUMN wk_high_52 TYPE real,
    ALTER COLUMN wk_low_52 TYPE real,
    ALTER COLUMN zacks_rank TYPE smallint USING zacks_rank::smallint,
    ALTER COLUMN zacks_rank_change_indicator TYPE smallint USING zacks_rank_change_indicator::smallint,
    ALTER COLUMN zacks_industry_rank TYPE smallint USING zacks_industry_rank::smallint,
    ALTER COLUMN num_brokers_in_rating TYPE smallint USING num_brokers_in_rating::smallint,
    ALTER COLUMN num_rating_strong_buy_or_buy TYPE smallint USING num_rating_strong_buy_or_buy::smallint,
    ALTER COLUMN num_rating_hold TYPE smallint USING num_rating_hold::smallint,
    ALTER COLUMN num_rating_strong_sell_or_sell TYPE smallint USING num_rating_strong_sell_or_sell::smallint,
    ALTER COLUMN industry_rank_of_abr TYPE smallint USING industry_rank_of_abr::smallint,
    ALTER COLUMN rank_in_industry_of_abr TYPE smallint USING rank_in_industry_of_abr::smallint,
    ALTER COLUMN number_rating_upgrades TYPE smallint USING number_rating_upgrades::smallint,
    ALTER COLUMN number_rating_downgrades TYPE smallint USING number_rating_downgrades::smallint,
    ALTER COLUMN average_target_price TYPE real USING average_target_price::real,
    ALTER COLUMN number_of_analysts_in_q0_consensus TYPE smallint USING number_of_analysts_in_q0_consensus::smallint,
    ALTER COLUMN number_of_analysts_in_q1_consensus TYPE smallint USING number_of_analysts_in_q1_consensus::smallint,
    ALTER COLUMN number_of_analysts_in_q2_consensus TYPE smallint USING number_of_analysts_in_q2_consensus::smallint,
    ALTER COLUMN number_of_analysts_in_f1_consensus TYPE smallint USING number_of_analysts_in_f1_consensus::smallint,
    ALTER COLUMN number_of_analysts_in_f2_consensus TYPE smallint USING number_of_analysts_in_f2_consensus::smallint;
ALTER TABLE zacks_financials
    DROP CONSTRAINT zacks_financials_pkey,
    ADD CONSTRAINT zacks_financials_composite_figi_check
        CHECK (LENGTH(TRIM(BOTH composite_figi)) = 12),
    ADD PRIMARY KEY (composite_figi, event_date);
CREATE INDEX zacks_financials_ticker_idx ON zacks_financials (ticker);

-- eod
DROP INDEX eod_composite_figi_idx;
ALTER TABLE eod
    ALTER COLUMN ticker TYPE VARCHAR(10),
    ALTER COLUMN composite_figi TYPE CHAR(12);
ALTER TABLE eod
    DROP CONSTRAINT eod_pkey,
    ADD CONSTRAINT eod_composite_figi_check
        CHECK (LENGTH(TRIM(BOTH composite_figi)) = 12),
    ADD PRIMARY KEY (composite_figi, event_date);

COMMIT;