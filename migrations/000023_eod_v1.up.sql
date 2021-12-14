BEGIN;

ALTER TABLE eod_v1 ADD COLUMN dividend NUMERIC(12, 4);
ALTER TABLE eod_v1 ADD COLUMN split_factor NUMERIC(9, 6);

ALTER TYPE datasource ADD VALUE IF NOT EXISTS 'api.tiingo.com' AFTER 'api.polygon.io';
ALTER TYPE datasource ADD VALUE IF NOT EXISTS 'fred.stlouisfed.org' AFTER 'api.tiingo.com';

ALTER TYPE tax_disposition ADD VALUE IF NOT EXISTS 'TAXABLE' BEFORE 'DEFERRED';

COMMIT;