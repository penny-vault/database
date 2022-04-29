BEGIN;
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
COMMIT;
