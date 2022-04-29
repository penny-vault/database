BEGIN;

CREATE TABLE trading_days_v1 (
    trading_day DATE NOT NULL,
    market VARCHAR(25) NOT NULL,
    PRIMARY KEY (trading_day, market)
);

GRANT SELECT ON trading_days_v1 TO pvuser;

COMMIT;
