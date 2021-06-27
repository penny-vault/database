ALTER TABLE portfolio_v1 ENABLE ROW LEVEL SECURITY;

CREATE POLICY portfolio_v1_policy ON portfolio_v1
    USING (userid = current_user)
    WITH CHECK (userid = current_user);