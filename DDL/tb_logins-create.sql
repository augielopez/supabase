CREATE TABLE tb_logins (
    pk         INTEGER NOT NULL,                        -- Primary key identifier for the table
    username   VARCHAR(255) NOT NULL,                   -- Username of the user
    password   TEXT NOT NULL,                           -- Password of the user (Note: Consider using encryption/hashing)
    updatedby  VARCHAR(255) NOT NULL,                   -- Username or identifier of the user who last updated the record
    updatedon  TIMESTAMP NOT NULL,                      -- Timestamp of the last update
    createdby  VARCHAR(255) NOT NULL,                   -- Username or identifier of the user who created the record
    createdon  TIMESTAMP NOT NULL                       -- Timestamp of the record creation
);
