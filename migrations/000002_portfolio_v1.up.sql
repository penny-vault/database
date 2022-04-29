--- Change the type of the name column on the portfolio to text
--- so the size is unlimited
BEGIN;

ALTER TABLE portfolio_v1 ALTER COLUMN name TYPE TEXT;

COMMIT;
