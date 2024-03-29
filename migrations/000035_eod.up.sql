BEGIN;

ALTER TABLE eod ALTER COLUMN open SET DEFAULT 0.0;
UPDATE eod SET open = close WHERE open IS NULL;
UPDATE eod SET open = 0.0 WHERE open IS NULL;
ALTER TABLE eod ALTER COLUMN open SET NOT NULL;

ALTER TABLE eod ALTER COLUMN high SET DEFAULT 0.0;
UPDATE eod SET high = 0.0 WHERE high IS NULL;
ALTER TABLE eod ALTER COLUMN high SET NOT NULL;

ALTER TABLE eod ALTER COLUMN low SET DEFAULT 0.0;
UPDATE eod SET low = 0.0 WHERE low IS NULL;
ALTER TABLE eod ALTER COLUMN low SET NOT NULL;

ALTER TABLE eod ALTER COLUMN close SET DEFAULT 0.0;
UPDATE eod SET close = 0.0 WHERE close IS NULL;
ALTER TABLE eod ALTER COLUMN close SET NOT NULL;

ALTER TABLE eod ALTER COLUMN volume SET DEFAULT 0;
UPDATE eod SET volume = 0.0 WHERE volume IS NULL;
ALTER TABLE eod ALTER COLUMN volume SET NOT NULL;

ALTER TABLE eod ALTER COLUMN dividend SET DEFAULT 0.0;
UPDATE eod SET dividend = 0.0 WHERE dividend IS NULL;
ALTER TABLE eod ALTER COLUMN dividend SET NOT NULL;

ALTER TABLE eod ALTER COLUMN split_factor SET DEFAULT 1.0;
UPDATE eod SET split_factor = 1.0 WHERE split_factor IS NULL;
ALTER TABLE eod ALTER COLUMN split_factor SET NOT NULL;

COMMIT;