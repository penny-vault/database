CREATE TABLE IF NOT EXISTS pennyvault.dividend (
    security int,
    date date,
    dividend decimal,
    source int,
    PRIMARY KEY (security, date)
) WITH CLUSTERING ORDER BY (date DESC);
