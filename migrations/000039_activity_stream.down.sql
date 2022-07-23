BEGIN;

ALTER TABLE portfolios DROP COLUMN status;
DROP TABLE activity_stream;
DROP TABLE announcements;

COMMIT;