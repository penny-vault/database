BEGIN;

CREATE VIEW health_v1 AS
    SELECT
        (SELECT (now() - INTERVAL '32 hours')::date) AS date,
        to_char((now() - INTERVAL '30 hours')::date, 'Day') as day_of_week,
        CASE WHEN (EXTRACT(isodow FROM (now() - INTERVAL '32 hours')::date) IN (6, 7)) THEN 2
             WHEN ((SELECT count(*) FROM eod_v1 WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) > 35000 AND
                   (SELECT count(*) FROM zacks_financials_v1 WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) > 3500 AND
                   (SELECT count(*) FROM risk_indicators_v1 WHERE event_date>(select (now() - INTERVAL '60 hours')::date)) >= 1) THEN 1
             ELSE 0
        END AS status,
        (SELECT count(*) FROM eod_v1 WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) AS eod_v1_cnt,
        (SELECT count(*) FROM zacks_financials_v1 WHERE event_date=(select (now() - INTERVAL '32 hours')::date)) AS zacks_financials_v1_cnt,
        (SELECT count(*) FROM risk_indicators_v1 WHERE event_date>(select (now() - INTERVAL '60 hours')::date)) AS risk_indicators_v1_cnt;

CREATE ROLE pvhealth WITH nologin;
GRANT pvhealth TO pvapi;
GRANT SELECT ON health_v1 TO pvhealth;

COMMIT;