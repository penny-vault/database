BEGIN;

CREATE TABLE IF NOT EXISTS tickers_v1 (
   ticker text,
   cik text,
   composite_figi text,
   share_class_figi text,
   primary_exchange text,
   type text,
   active boolean,
   name text,
   description text,
   url text,
   ceo text,
   phone text,
   emplyees int,
   marketcap int,
   sector text,
   industry text,
   market text,
   locale text,
   currency_name text,
   currency_symbol text,
   base_currency_name text,
   base_currency_symbol text,
   logo text,
   hq_address text,
   hq_state text,
   hq_country text,
   bloomberg text,
   sic int,
   lei text,
   similar_tickers text[],
   tags text[],
   listed_utc timestamp,
   delisted_utc timestamp,
   last_updated_utc timestamp,
   source datasource,
   PRIMARY KEY (ticker, composite_figi)
);
CREATE INDEX IF NOT EXISTS tickers_v1_active ON tickers_v1(active);

CREATE TABLE IF NOT EXISTS tickers_v1_tmp (
   id serial primary key,
   ticker text,
   cik text,
   composite_figi text,
   share_class_figi text,
   primary_exchange text,
   type text,
   active boolean,
   name text,
   description text,
   url text,
   ceo text,
   phone text,
   emplyees int,
   marketcap int,
   sector text,
   industry text,
   market text,
   locale text,
   currency_name text,
   currency_symbol text,
   base_currency_name text,
   base_currency_symbol text,
   logo text,
   hq_address text,
   hq_state text,
   hq_country text,
   bloomberg text,
   sic int,
   lei text,
   similar_tickers text[],
   tags text[],
   listed_utc timestamp,
   delisted_utc timestamp,
   last_updated_utc timestamp,
   source datasource
);

COMMIT;