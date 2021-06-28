BEGIN;

DROP POLICY user_id_policy ON portfolio_transaction_v1;
DROP TABLE IF EXISTS portfolio_transaction_v1 CASCADE;
DROP TYPE tax_disposition;
DROP TYPE tx_type;

COMMIT;