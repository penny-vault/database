import psycopg2
import psycopg2.extras
import bz2
from csv import DictReader
import os
import logging

logger = logging.getLogger(__name__)

def load_into_db(fn):
    db = psycopg2.connect(dbname="pennyvault", host="neverland", user="pennyvault", cursor_factory=psycopg2.extras.DictCursor)
    with bz2.open(fn, 'rt') as fh:
        reader = DictReader(fh)
        data = list(reader)
    for row in data:
        try:
            row['Date'] = row['\ufeffDate']
            row['Adj Close'] = '0'
        except:
            pass

    ticker = fn.replace('.csv.bz2', '')
    logger.info(f"importing {ticker}")

    with db.cursor() as cur:
        # Get security id
        cur.execute("""
        SELECT id FROM security WHERE ticker=%(ticker)s
        """, {"ticker": ticker})
        rows = cur.fetchall()
        if len(rows) > 1:
            logger.error(f"cannot determine security, found multiple")
            for row in rows:
                logger.error(f"\t{row}")
            return

        try:
            security_id = rows[0]["id"]
            logger.info(f"{ticker} security id is {security_id}")
        except IndexError:
            logger.error(f"cannot determine security id for {ticker}")
            return

        # Get source ID
        cur.execute("""
        SELECT * FROM source WHERE name=%(name)s
        """, {"name": "finance.yahoo.com"})
        source_id = cur.fetchone()["id"]

        for row in data:
            row["security_id"] = security_id
            row["source_id"] = source_id
            try:
                if row["Open"] != "null":
                    cur.execute("""
                    INSERT INTO eod ("date", "security", "open", "close", "adj_close", "high", "low", "volume", "source")
                    VALUES (%(Date)s, %(security_id)s, %(Open)s, %(Close)s, %(Adj Close)s, %(High)s, %(Low)s, %(Volume)s, %(source_id)s)
                    ON CONFLICT (date, security) DO NOTHING
                    """, row)
                else:
                    logger.warning(f"skipping row {row}")
            except psycopg2.errors.InvalidTextRepresentation as err:
                logger.error(err)
                db.rollback()
            except psycopg2.errors.NumericValueOutOfRange as err:
                logger.error(err)
                db.rollback()

    db.commit()


def main():
    from argparse import ArgumentParser
    parser = ArgumentParser(description="Load Yahoo Finance csv into database")
    parser.add_argument("fns", nargs="+", help="Files to import must be named: <TICKER>.csv.bz2")
    parser.add_argument("--debug", action="store_true", help="Print debug messages")
    args = parser.parse_args()

    log_params = {
        "level": logging.DEBUG if args.debug else logging.INFO,
        "format": "%(asctime)s [%(levelname)s]  %(message)s"
    }
    logging.basicConfig(**log_params)

    for fn in args.fns:
        load_into_db(fn)

if __name__ == '__main__':
    main()
