BEGIN;
ALTER TABLE portfolio_measurement_v1 ADD COLUMN holdings JSONB NOT NULL;
COMMIT;
