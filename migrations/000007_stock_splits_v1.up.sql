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
