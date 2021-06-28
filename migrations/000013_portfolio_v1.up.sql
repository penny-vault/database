BEGIN;

ALTER TABLE portfolio_v1 ENABLE ROW LEVEL SECURITY;

CREATE POLICY user_id_policy ON portfolio_v1
    USING (user_id = current_user)
    WITH CHECK (user_id = current_user);

COMMIT;