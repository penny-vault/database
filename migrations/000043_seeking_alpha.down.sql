BEGIN;

CREATE TABLE IF NOT EXISTS seeking_alpha (
    ticker text,
    composite_figi text,
    event_date date,
    market_cap_mil numeric(12, 4),
    quant_rating real,
    growth_grade smallint,
    profitability_grade smallint,
    value_grade smallint,
    eps_revisions_grade smallint,
    authors_rating_pro real,
    sell_side_rating real,
    PRIMARY KEY (ticker, composite_figi, event_date)
);

CREATE INDEX seeking_alpha_quant_idx ON seeking_alpha (event_date, quant_rating);

GRANT SELECT ON seeking_alpha TO pvuser;

COMMIT;