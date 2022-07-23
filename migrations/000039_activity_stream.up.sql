BEGIN;

ALTER TABLE portfolios ADD COLUMN status TEXT;

CREATE TABLE activity_stream (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    user_id CHARACTER VARYING(63) DEFAULT CURRENT_USER NOT NULL,
    portfolio_id uuid NOT NULL REFERENCES portfolios(id) ON DELETE CASCADE,
    event_date TIMESTAMP NOT NULL DEFAULT NOW(),
    activity TEXT NOT NULL,
    tags TEXT[]
);

ALTER TABLE activity_stream ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_id_policy ON activity_stream USING (((user_id)::text = CURRENT_USER)) WITH CHECK (((user_id)::text = CURRENT_USER));
GRANT select, insert, update, delete ON activity_stream TO pvuser;

CREATE TABLE announcements (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    event_date TIMESTAMP NOT NULL DEFAULT NOW(),
    expires TIMESTAMP NOT NULL DEFAULT NOW() + '30 days',
    announcement TEXT NOT NULL,
    tags TEXT[]
);

GRANT select, insert, update, delete ON announcements TO pvuser;

COMMIT;