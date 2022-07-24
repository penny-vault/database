BEGIN;

ALTER TABLE portfolios DROP COLUMN status;
DROP TABLE activity;
DROP TABLE announcements;

COMMIT;