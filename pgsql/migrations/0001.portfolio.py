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
        CREATE TYPE tx_type AS ENUM ('buy', 'sell', 'short', 'reinvest-dividend', 'reinvest-ltc', 'reinvest-stc', 'dividend', 'ltc', 'stc', 'deposit', 'withdraw', 'income');
        """,
        """
        DROP TYPE tx_type
        """
    ),

    # Tax disposition
    step(
        """
        CREATE TYPE tax_disposition AS ENUM ('long-term capital gain', 'short-term capital gain', 'tax deferred', 'tax free', 'taxable')
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
            sequence_num SERIAL,
            portfolio_id UUID NOT NULL REFERENCES portfolio(id) ON DELETE CASCADE,
            owner VARCHAR(63) NOT NULL DEFAULT current_user,
            source_id VARCHAR(128) NOT NULL DEFAULT uuid_generate_v4(),
            transaction_type tx_type NOT NULL,
            tax_type tax_disposition,
            date DATE NOT NULL,
            cleared BOOL NOT NULL DEFAULT false,
            source VARCHAR(128),
            security_id INT,
            total_cost NUMERIC(14, 4) NOT NULL,
            num_shares NUMERIC(14, 4),
            price_per_share NUMERIC(14, 4),
            commission NUMERIC(14, 4),
            memo TEXT,
            tags varchar[],
            created NOT NULL DEFAULT now(),
            UNIQUE (portfolio_id, source_id)
        );
        """,
        """
        DROP TABLE transaction
        """
    ),
    step(
        """
        CREATE INDEX transaction_portfolio ON transaction(portfolio_id);
        """,
        """
        DROP INDEX transaction_portfolio
        """
    ),
    step(
        """
        CREATE TABLE holdings (
            date TIMESTAMP NOT NULL,
            portfolio_id UUID NOT NULL,
            owner VARCHAR(63) NOT NULL DEFAULT current_user,
            holdings JSON,
            PRIMARY KEY(date, portfolio_id)
        );
        """,
        """
        DROP TABLE holdings;
        """
    ),
    step(
        """
        CREATE OR REPLACE FUNCTION invalidate_holdings() RETURNS TRIGGER AS $$
           DECLARE
               my_portfolio_id uuid;
               my_date timestamp;
           BEGIN
               IF (TG_OP = 'DELETE') THEN
                   my_portfolio_id := OLD.portfolio_id;
                   my_date := OLD.date;
               ELSIF (TG_OP = 'UPDATE') THEN
                   my_portfolio_id := NEW.portfolio_id;
                   my_date := NEW.date;
               ELSIF (TG_OP = 'INSERT') THEN
                   my_portfolio_id := NEW.portfolio_id;
                   my_date := NEW.date;
               END IF;

               DELETE FROM holdings WHERE portfolio_id = my_portfolio_id AND date >= my_date;
               DELETE FROM portfolio_metric WHERE portfolio_id = my_portfolio_id AND date >= my_date;
               RETURN NEW;
           END;
        $$ LANGUAGE plpgsql;
        """,
        """
        DROP FUNCTION invalidate_holdings();
        """
    ),
    step(
        """
        CREATE TRIGGER transaction_invalidate_holdings AFTER INSERT OR DELETE OR UPDATE ON transaction
            FOR EACH ROW EXECUTE PROCEDURE invalidate_holdings();
        """,
        """
        DROP TRIGGER transaction_invalidate_holdings ON transaction;
        """
    ),
    step(
        """
        CREATE OR REPLACE FUNCTION update_open_date() RETURNS TRIGGER AS $$
           DECLARE
               my_portfolio_id uuid;
           BEGIN
               IF (TG_OP = 'DELETE') THEN
                   my_portfolio_id := OLD.portfolio_id;
               ELSIF (TG_OP = 'UPDATE') THEN
                   my_portfolio_id := NEW.portfolio_id;
               ELSIF (TG_OP = 'INSERT') THEN
                   my_portfolio_id := NEW.portfolio_id;
               END IF;

               UPDATE portfolio SET open_date=coalesce((SELECT MIN(date) FROM transaction WHERE portfolio_id=my_portfolio_id),now()) where id=my_portfolio_id;
               RETURN NEW;
           END;
        $$ LANGUAGE plpgsql;
        """,
        """
        DROP FUNCTION update_open_date();
        """
    ),
    step(
        """
        CREATE TRIGGER transaction_update_open_date AFTER INSERT OR DELETE OR UPDATE ON transaction
            FOR EACH ROW EXECUTE PROCEDURE update_open_date();
        """,
        """
        DROP TRIGGER transaction_update_open_date;
        """
    ),
    # Ensure that 'buy' transactions have positive shares and 'sell'
    # transactions have negative
    step(
        """
        CREATE OR REPLACE FUNCTION check_share_sign() RETURNS TRIGGER AS $$
            BEGIN
                IF ((NEW.transaction_type = 'reinvest-dividend' OR
                     NEW.transaction_type = 'reinvest-ltc' OR
                     NEW.transaction_type = 'reinvest-stc') AND
                    NEW.num_shares <= 0) THEN
                    RAISE EXCEPTION 'BUY and REINVEST transactions must have a positive number of shares';
                END IF;

                IF (NEW.transaction_type = 'sell' AND NEW.num_shares > 0) THEN
                    RAISE EXCEPTION 'SELL transactions must have a negative number of shares';
                END IF;

                RETURN NEW;
           END;
        $$ LANGUAGE plpgsql;
        """,
        """
        DROP FUNCTION check_share_sign();
        """
    ),
    step(
        """
        CREATE TRIGGER transaction_check_share_sign BEFORE INSERT OR UPDATE ON transaction
            FOR EACH ROW EXECUTE PROCEDURE check_share_sign();
        """,
        """
        DROP TRIGGER transaction_check_share_sign ON transaction;
        """
    ),
    # Portfolio metric
    step(
        """
        CREATE TABLE portfolio_metric (
            portfolio_id UUID NOT NULL REFERENCES portfolio(id) ON DELETE CASCADE,
            owner VARCHAR(63) NOT NULL DEFAULT current_user,
            date DATE NOT NULL,
            metric_name VARCHAR(24) NOT NULL,
            value NUMERIC(16, 4),
            PRIMARY KEY (portfolio_id, date, metric_name)
        );
        """,
        """
        DROP TABLE portfolio_metric
        """
    )
]
