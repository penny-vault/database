BEGIN;
ALTER TABLE portfolio_v1 ADD COLUMN performance_json JSONB;
COMMIT;
