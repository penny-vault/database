BEGIN;

ALTER TYPE datasource ADD VALUE IF NOT EXISTS 'api.pennyvault.com' AFTER 'api.tiingo.com';
ALTER TYPE assettype ADD VALUE IF NOT EXISTS 'FRED' AFTER 'American Depository Receipt Common';

COMMIT;