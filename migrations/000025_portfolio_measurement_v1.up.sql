BEGIN;

ALTER TABLE portfolio_measurement_v1 ADD COLUMN justification jsonb DEFAULT '{}';

COMMIT;
