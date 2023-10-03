-- migrate:up

CREATE SCHEMA michael;
CREATE ROLE michael LOGIN;
GRANT ALL PRIVILEGES ON SCHEMA "michael" to michael;

-- migrate:down

REVOKE ALL PRIVILEGES ON DATABASE "michael" from michael;
DROP ROLE michael;
DROP SCHEMA michael;
