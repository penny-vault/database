-- Changes necessary for synthetic symbols
BEGIN;

ALTER TABLE eod ADD COLUMN adj_close numeric(12, 4);
ALTER TYPE assettype ADD VALUE IF NOT EXISTS 'Synthetic History' AFTER 'FRED';

CREATE OR REPLACE FUNCTION adj_close_default()
  RETURNS trigger
  LANGUAGE plpgsql AS
$func$
BEGIN
   NEW.adj_close := NEW.close;
   RETURN NEW;
END
$func$;

CREATE TRIGGER eod_adj_close_default
    BEFORE INSERT ON eod
    FOR EACH ROW
    WHEN (NEW.adj_close IS NULL AND NEW.close IS NOT NULL)
EXECUTE PROCEDURE adj_close_default();

COMMIT;