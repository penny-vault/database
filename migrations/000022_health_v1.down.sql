BEGIN;

REVOKE pvhealth FROM pvapi;
REVOKE SELECT ON health_v1 FROM pvhealth;
DROP ROLE pvhealth;

DROP VIEW health_v1;

COMMIT;