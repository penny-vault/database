BEGIN;

ALTER TABLE portfolio_v1 ALTER COLUMN user_id DROP DEFAULT;
ALTER TABLE portfolio_v1 DROP COLUMN temporary;
ALTER TABLE portfolio_v1 DROP COLUMN benchmark;

COMMIT;