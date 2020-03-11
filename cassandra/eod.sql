CREATE TABLE IF NOT EXISTS pennyvault.eod (
       date date,
       security int,
       open decimal,
       close decimal,
       adj_close decimal,
       high decimal,
       low decimal,
       volume bigint,
       source int,
       PRIMARY KEY (security, date)      
) WITH CLUSTERING ORDER BY (date DESC);
