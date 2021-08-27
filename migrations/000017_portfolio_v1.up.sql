BEGIN;

ALTER TABLE portfolio_v1 ALTER COLUMN user_id SET DEFAULT current_user;
ALTER TABLE portfolio_v1 ADD COLUMN temporary BOOLEAN DEFAULT false;

COMMIT;