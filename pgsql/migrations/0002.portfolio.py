from yoyo import step

__depends__ = ['0001.portfolio']

steps = [
    # portfolio access policy
    step(
        """
        ALTER TABLE portfolio ENABLE ROW LEVEL SECURITY;
        """,
        """
        ALTER TABLE portfolio DISABLE ROW LEVEL SECURITY;
        """
    ),
    step(
        """
        CREATE POLICY portfolio_policy ON portfolio
            USING (owner = current_user)
            WITH CHECK (owner = current_user)
        """,
        """
        DROP POLICY portfolio_policy
        """
    ),

    # transaction access policy
    step(
        """
        ALTER TABLE transaction ENABLE ROW LEVEL SECURITY;
        """,
        """
        ALTER TABLE transaction DISABLE ROW LEVEL SECURITY;
        """
    ),
    step(
        """
        CREATE POLICY transaction_policy ON transaction
            USING (owner = current_user)
            WITH CHECK (owner = current_user)
        """,
        """
        DROP POLICY transaction_policy
        """
    ),

    # portfolio_metric access policy
    step(
        """
        ALTER TABLE portfolio_metric ENABLE ROW LEVEL SECURITY;
        """,
        """
        ALTER TABLE portfolio_metric DISABLE ROW LEVEL SECURITY;
        """
    ),
    step(
        """
        CREATE POLICY portfolio_metric_policy ON portfolio_metric
            USING (owner = current_user)
            WITH CHECK (owner = current_user)
        """,
        """
        DROP POLICY portfolio_metric_policy
        """
    ),

    # holdings access policy
    step(
        """
        ALTER TABLE holdings ENABLE ROW LEVEL SECURITY;
        """,
        """
        ALTER TABLE holdings DISABLE ROW LEVEL SECURITY;
        """
    ),
    step(
        """
        CREATE POLICY holdings_policy ON holdings
            USING (owner = current_user)
            WITH CHECK (owner = current_user)
        """,
        """
        DROP POLICY holdings_policy
        """
    ),
]
