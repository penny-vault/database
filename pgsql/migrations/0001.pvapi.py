from yoyo import step

__depends__ = []

step(
    """
    CREATE ROLE pvapi_anon nologin;
    GRANT pvapi_anon TO postgres;
    GRANT USAGE ON SCHEMA public TO pvapi_anon;
    GRANT SELECT ON eod TO pvapi_anon;
    GRANT SELECT ON security TO pvapi_anon;
    GRANT SELECT ON exchange TO pvapi_anon;
    GRANT SELECT ON rating TO pvapi_anon;
    GRANT SELECT ON split TO pvapi_anon;
    GRANT SELECT ON dividend TO pvapi_anon;
    GRANT SELECT ON source TO pvapi_anon;
    """,
    """
    DROP ROLE pvapi_anon
    """
)
