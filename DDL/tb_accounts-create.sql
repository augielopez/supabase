CREATE TABLE public.tb_accounts (
                                    pk SERIAL PRIMARY KEY, -- Primary key column
                                    name VARCHAR(255) NOT NULL, -- Name of the account, required
                                    url TEXT, -- URL associated with the account, optional
                                    ownerpk INT NOT NULL, -- Foreign key to owner, required
                                    loginpk INT NOT NULL, -- Foreign key to login, required
                                    updatedby VARCHAR(255), -- User who last updated the record
                                    updatedon DATE NOT NULL, -- Date when the record was last updated
                                    createdby VARCHAR(255) NOT NULL, -- User who created the record
                                    createdon DATE NOT NULL -- Date when the record was created
);

-- Optional: Add an index for frequently queried fields
CREATE INDEX idx_tb_accounts_ownerpk ON public.tb_accounts (ownerpk);
CREATE INDEX idx_tb_accounts_loginpk ON public.tb_accounts (loginpk);
CREATE INDEX idx_tb_accounts_name ON public.tb_accounts (name);
