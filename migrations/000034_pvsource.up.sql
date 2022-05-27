BEGIN;

ALTER TYPE datasource ADD VALUE IF NOT EXISTS 'api.pennyvault.com' AFTER 'api.tiingo.com';

COMMIT;