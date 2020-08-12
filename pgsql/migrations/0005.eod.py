from yoyo import step

__depends__ = ['0004.eod']

steps = [
    step(
        """
        DROP INDEX eod_symbol_idx;
        """,
        """
        CREATE INDEX eod_symbol_idx ON eod(security);
        """
    ),
    step(
        """
        DROP INDEX eod_date_idx;
        """,
        """
        CREATE INDEX eod_date_idx ON eod(date);
        """
    ),
    step(
        """
        ALTER TABLE eod DROP CONSTRAINT date_security_key;
        """,
        """
        ALTER TABLE eod ADD CONSTRAINT date_security_key UNIQUE (date, security);
        """
    ),
    step(
        """
        ALTER TABLE eod ADD CONSTRAINT eod_pkey PRIMARY KEY (date, security);
        """,
        """
        ALTER TABLE eod DROP CONSTRAINT eod_pkey PRIMARY KEY (date, security);
        """
    )
]
