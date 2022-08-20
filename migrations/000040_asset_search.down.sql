BEGIN;

DROP INDEX assets_search_idx;
ALTER TABLE assets DROP COLUMN search;

COMMIT;