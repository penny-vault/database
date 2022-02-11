BEGIN;

CREATE TABLE market_holidays_v1 (
    holiday TEXT NOT NULL,
    event_date DATE NOT NULL,
    market VARCHAR(25) NOT NULL,
    early_close BOOLEAN NOT NULL DEFAULT false,
    close_time TIME NOT NULL DEFAULT '16:00:00',
    PRIMARY KEY (event_date, market)
);

GRANT SELECT ON market_holidays_v1 TO pvuser;

COMMIT;