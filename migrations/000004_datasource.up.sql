-- Create the datasource type
BEGIN;
CREATE TYPE datasource AS ENUM ('finance.yahoo.com', 'quandl.com', 'api.tradier.com', 'eoddata.com', 'finra.org', 'marketwatch.com', 'marketbeat.com', 'primecap.com', 'troweprice.com', 'pimco.com', 'tcw.com', 'treasury.gov', 'nasdaq.com', 'api.polygon.io');
COMMIT;
