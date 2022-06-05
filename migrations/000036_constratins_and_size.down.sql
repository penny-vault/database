BEGIN;

DROP VIEW relation_size;

-- seeking alpha
ALTER TABLE seeking_alpha
    ALTER COLUMN ticker TYPE text,
    ALTER COLUMN composite_figi TYPE text,
    ALTER COLUMN market_cap_mil TYPE numeric(12, 4);
ALTER TABLE seeking_alpha
    DROP CONSTRAINT seeking_alpha_pkey,
    DROP CONSTRAINT seeking_alpha_composite_figi_check,
    ADD PRIMARY KEY (ticker, composite_figi, event_date);
DROP INDEX seeking_alpha_ticker_idx;

-- zacks financials
ALTER TABLE zacks_financials
    ALTER COLUMN ticker TYPE text,
    ALTER COLUMN composite_figi TYPE text,
    ALTER COLUMN month_of_fiscal_yr_end TYPE int,
    ALTER COLUMN sector TYPE text,
    ALTER COLUMN industry TYPE text,
    ALTER COLUMN shares_outstanding_mil TYPE numeric(12,4),
    ALTER COLUMN market_cap_mil TYPE numeric(12,4),
    ALTER COLUMN avg_volume TYPE bigint,
    ALTER COLUMN wk_high_52 TYPE numeric(12,4),
    ALTER COLUMN wk_low_52 TYPE numeric(12,4),
    ALTER COLUMN zacks_rank TYPE int,
    ALTER COLUMN zacks_rank_change_indicator TYPE int,
    ALTER COLUMN zacks_industry_rank TYPE int,
    ALTER COLUMN num_brokers_in_rating TYPE int,
    ALTER COLUMN num_rating_strong_buy_or_buy TYPE int,
    ALTER COLUMN num_rating_hold TYPE int,
    ALTER COLUMN num_rating_strong_sell_or_sell TYPE int,
    ALTER COLUMN industry_rank_of_abr TYPE int,
    ALTER COLUMN rank_in_industry_of_abr TYPE int,
    ALTER COLUMN number_rating_upgrades TYPE int,
    ALTER COLUMN number_rating_downgrades TYPE int,
    ALTER COLUMN average_target_price TYPE numeric(12,4),
    ALTER COLUMN number_of_analysts_in_q0_consensus TYPE int,
    ALTER COLUMN number_of_analysts_in_q1_consensus TYPE int,
    ALTER COLUMN number_of_analysts_in_q2_consensus TYPE int,
    ALTER COLUMN number_of_analysts_in_f1_consensus TYPE int,
    ALTER COLUMN number_of_analysts_in_f2_consensus TYPE int;
ALTER TABLE zacks_financials
    DROP CONSTRAINT zacks_financials_pkey,
    DROP CONSTRAINT zacks_financials_composite_figi_check,
    ADD PRIMARY KEY (ticker, composite_figi, event_date);
DROP INDEX zacks_financials_ticker_idx;



COMMIT;