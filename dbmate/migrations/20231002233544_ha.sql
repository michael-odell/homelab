-- migrate:up transaction:false

CREATE SCHEMA ha;
CREATE ROLE ha LOGIN;
GRANT ALL PRIVILEGES ON SCHEMA "ha" to ha;

-- migrate:down transaction:false

REVOKE ALL PRIVILEGES ON SCHEMA "ha" from ha;
DROP ROLE ha;
DROP SCHEMA ha;
