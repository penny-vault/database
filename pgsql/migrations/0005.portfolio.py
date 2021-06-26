from yoyo import step

__depends__ = ['0004.portfolio']

steps = [
    # portfolio access policy
    step(
        """
CREATE OR REPLACE FUNCTION portfolio_value(
	_portfolio_id text,
    _bucket_interval text
)
    RETURNS TABLE(dt date, val numeric)
    LANGUAGE 'sql'
AS $BODY$
SELECT time_bucket(_bucket_interval::interval, date) AS dt, avg(value) as val
       FROM portfolio_metric
       WHERE portfolio_id=_portfolio_id::uuid AND metric_name='value'
       GROUP BY dt
       ORDER BY dt ASC;
$BODY$;
        """,
        """
        DROP FUNCTION portfolio_value;
        """
    ),
    step(
        """
CREATE OR REPLACE FUNCTION portfolio_holdings_for_date(
	_portfolio_id text,
    _for_date text
)
    RETURNS TABLE(date date, id integer, ticker character varying(45), qty numeric, price_close numeric, price_date date, value numeric)
    LANGUAGE 'sql'
AS $BODY$
SELECT
  (SELECT date FROM holdings WHERE portfolio_id = _portfolio_id::uuid AND date <= _for_date::date ORDER BY date DESC LIMIT 1)::date AS date,
  security.id,
  ticker,
  current_holdings.value::numeric AS qty,
  price.close as price_close,
  price.date as price_date,
  current_holdings.value::numeric * price.close AS value
FROM
  ((SELECT * FROM json_each_text((SELECT holdings FROM holdings WHERE portfolio_id = _portfolio_id::uuid AND date <= _for_date::date ORDER BY date DESC LIMIT 1))) AS current_holdings
  INNER JOIN security ON security.id=current_holdings.key::integer)
  INNER JOIN LATERAL (SELECT security, close, date FROM eod WHERE security=security.id AND date <= _for_date::date ORDER BY DATE DESC LIMIT 1) AS price ON price.security=security.id
ORDER BY ticker ASC;
$BODY$;
        """,
        """
        DROP FUNCTION portfolio_holdings_for_date
        """
    ),
]
