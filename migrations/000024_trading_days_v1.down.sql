BEGIN;

REVOKE SELECT ON trading_days_v1 FROM pvuser;
DROP TABLE IF EXISTS trading_days_v1;

COMMIT;
