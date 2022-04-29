BEGIN;

CREATE TABLE IF NOT EXISTS stock_splits_v1 (
    ticker text,
    composite_figi text,
    record_date date,
    ex_date date,
    declared_date date,
    payment_date date,
    ratio numeric(8, 6),
    to_factor int,
    for_factor int,
    source datasource,
    PRIMARY KEY (ticker, composite_figi, ex_date)
);

GRANT SELECT ON stock_splits_v1 TO pvuser;

CREATE TABLE IF NOT EXISTS dividend_v1 (
    ticker text,
    composite_figi text,
    record_date date,
    exdiv_date date,
    payment_date date,
    amount numeric(12, 4),
    source datasource,
    PRIMARY KEY (ticker, composite_figi, exdiv_date)
);

GRANT SELECT ON dividend_v1 TO pvuser;

CREATE TABLE IF NOT EXISTS risk_indicators_v1 (
    event_date date primary key,
    tt_market_vane smallint,
    tt_stock_momentum real,
    tt_economy_momentum real,
    tt_stock_vs_bond real,
    vix_margin real,
    draw_down_margin real,
    sg_std real,
    sg_aqr real,
    sg_armor real,
    sg_swan_guard real,
    sg_momentum real,
    sg_sentiment real,
    sg_death_x real,
    sg_double_x real,
    sg_delta real,
    sg_mcclellan real
);

GRANT SELECT ON risk_indicators_v1 TO pvuser;

COMMIT;
