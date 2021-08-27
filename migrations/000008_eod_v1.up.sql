BEGIN;

CREATE TABLE IF NOT EXISTS eod_v1 (
   ticker text,
   composite_figi text,
   event_date date,
   open numeric(12, 4),
   high numeric(12, 4),
   low numeric(12, 4),
   close numeric(12, 4),
   volume bigint,
   source datasource,
   PRIMARY KEY (composite_figi, ticker, event_date)
);

CREATE INDEX eod_v1_event_date_idx ON eod_v1(event_date);
CREATE INDEX eod_v1_ticker_idx ON eod_v1(ticker);
CREATE INDEX eod_v1_composite_figi_idx ON eod_v1(composite_figi);

COMMIT;