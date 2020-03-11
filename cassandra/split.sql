CREATE TABLE IF NOT EXISTS pennyvault.split (
    security int,
    date date,
    split_from smallint,
    split_to smallint,
    source int,
    PRIMARY KEY (security, date)
) WITH CLUSTERING ORDER BY (date DESC);
