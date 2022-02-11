BEGIN;

REVOKE SELECT ON market_holidays_v1 FROM pvuser;
DROP TABLE IF EXISTS market_holidays_v1;

COMMIT;