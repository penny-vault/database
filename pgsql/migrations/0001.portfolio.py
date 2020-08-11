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
        CREATE TYPE tx_type AS ENUM ('buy', 'sell', 'short', 'reinvest-dividend', 'reinvest-ltc', 'reinvest-stc', 'dividend', 'ltc', 'stc', 'deposit', 'withdraw');
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

    # Transaction trigger
    # We keep this here for reference
    #step(
    #    """
    #    CREATE OR REPLACE FUNCTION update_transaction_shares_held() RETURNS trigger AS $$
    #        DECLARE
    #            my_shares_held int := 0;
    #            my_security_id int;
    #            my_portfolio_id uuid;
    #            my_date timestamp;
    #            r transaction%rowtype;
    #        BEGIN
    #            IF (TG_OP = 'INSERT') THEN
    #                my_portfolio_id := NEW.portfolio_id;
    #                my_security_id := NEW.security_id;
    #                my_date := NEW.date;
    #            ELSIF (TG_OP = 'DELETE') THEN
    #                my_portfolio_id := OLD.portfolio_id;
    #                my_security_id := OLD.security_id;
    #                my_date := OLD.date;
    #            END IF;
    #
    #            -- Determine the number of shares held up to this point
    #            FOR r IN
    #                SELECT * FROM transaction
    #                WHERE portfolio_id = my_portfolio_id AND security_id = my_security_id AND date < my_date
    #                ORDER BY date DESC, sequence_num DESC
    #                LIMIT 1
    #            LOOP
    #                IF (r.shares_held is NULL) THEN
    #                    my_shares_held := 0;
    #                ELSE
    #                    my_shares_held := r.shares_held;
    #                END IF;
    #            END LOOP;
    #
    #            -- Update shares_held for this transaction and everything above it
    #            FOR r IN
    #                SELECT * FROM transaction
    #                WHERE portfolio_id = my_portfolio_id AND security_id = my_security_id AND date >= my_date
    #                ORDER BY date ASC, sequence_num ASC
    #            LOOP
    #                IF (r.num_shares is not NULL) THEN
    #                    my_shares_held := r.num_shares + my_shares_held;
    #                END IF;
    #                UPDATE transaction SET shares_held = my_shares_held WHERE id = r.id;
    #            END LOOP;
    #
    #            RETURN NULL;
    #        END;
    #    $$ LANGUAGE plpgsql;
    #    """,
    #    """
    #    DROP FUNCTION update_transaction_shares_held;
    #    """
    #),
    
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
