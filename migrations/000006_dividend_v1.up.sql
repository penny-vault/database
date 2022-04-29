BEGIN;
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
COMMIT;
