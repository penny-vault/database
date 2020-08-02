from yoyo import step

__depends__ = []

steps = [
    step(
        """
        CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
        """,
        """
        DROP EXTENSION "uuid-ossp";
        """
    ),
    # Portfolio Table
    step(
        """
        CREATE TABLE portfolio (
            id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
            owner VARCHAR(63) NOT NULL DEFAULT current_user,
            name VARCHAR(45) NOT NULL,
            strategy JSON,
            open_date DATE NOT NULL DEFAULT now(),
            close_date DATE,
            active BOOL NOT NULL DEFAULT true,
            description TEXT,
            tags VARCHAR[]
        )
        """,
        """
        DROP TABLE portfolio
        """
    ),
    # Transaction types
    step(
        """
        CREATE TYPE tx_type AS ENUM ('buy', 'sell', 'short', 'deposit', 'withdraw');
        """,
        """
        DROP TYPE tx_type
        """
    ),

    # Tax disposition
    step(
        """
        CREATE TYPE tax_disposition AS ENUM ('long-term capital gain', 'short-term capital gain')
        """,
        """
        DROP TYPE tax_disposition
        """
    ),

    # Transaction
    step(
        """
        CREATE TABLE transaction (
            id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
            portfolio_id UUID NOT NULL REFERENCES portfolio(id) ON DELETE CASCADE,
            owner VARCHAR(63) NOT NULL DEFAULT current_user,
            source_id VARCHAR(128),
            transaction_type tx_type NOT NULL,
            tax_type tax_disposition,
            date DATE NOT NULL,
            cleared BOOL NOT NULL DEFAULT false,
            source VARCHAR(128) NOT NULL,
            security_id INT,
            total_cost NUMERIC(14, 4) NOT NULL,
            num_shares NUMERIC(14, 4),
            commission NUMERIC(14, 4),
            memo TEXT,
            tags varchar[]
        );
        CREATE INDEX transaction_portfolio ON transaction(portfolio_id);
        """,
        """
        DROP TABLE transaction
        """
    ),

    # Portfolio metric
    step(
        """
        CREATE TABLE portfolio_metric (
            portfolio_id UUID NOT NULL REFERENCES portfolio(id),
            owner VARCHAR(63) NOT NULL DEFAULT current_user,
            date DATE NOT NULL,
            metric_name VARCHAR(24) NOT NULL,
            value NUMERIC(16, 4),
            PRIMARY KEY (portfolio_id, date)
        );
        """,
        """
        DROP TABLE portfolio_metric
        """
    )
]
