
-- ===================================
-- Supabase Schema for Personal Finance Tracker
-- ===================================

-- Accounts Table
CREATE TABLE IF NOT EXISTS bank_account_names (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    bank_name TEXT NOT NULL
    );

INSERT INTO bank_account_names (name, bank_name)
VALUES
    ('Augie', 'First Tech'),
    ('Melissa', 'First Tech'),
    ('Melissa Saving', 'First Tech'),
    ('Non Monthly', 'First Tech'),
    ('Main Checking', 'Fidelity'),
    ('Credit Card', 'Us Bank');


-- Combined Transactions Table (Unified Format)
CREATE TABLE IF NOT EXISTS combined_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID REFERENCES bank_account_names(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    amount NUMERIC NOT NULL,
    description TEXT,
    source_file_name TEXT,
    tags TEXT[],
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
    );

-- Transaction History Table
CREATE TABLE IF NOT EXISTS transaction_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    original_transaction_id UUID REFERENCES combined_transactions(id),
    account_id UUID,
    date DATE,
    amount NUMERIC,
    description TEXT,
    tags TEXT[],
    change_type TEXT CHECK (change_type IN ('insert', 'update')),
    change_time TIMESTAMPTZ DEFAULT now()
    );

-- Tags Table
CREATE TABLE IF NOT EXISTS tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT UNIQUE NOT NULL
    );
INSERT INTO tags (id, name) VALUES
                                (gen_random_uuid(), 'Groceries'),
                                (gen_random_uuid(), 'Dining'),
                                (gen_random_uuid(), 'Gas'),
                                (gen_random_uuid(), 'Utilities'),
                                (gen_random_uuid(), 'Subscriptions'),
                                (gen_random_uuid(), 'Rent'),
                                (gen_random_uuid(), 'Mortgage'),
                                (gen_random_uuid(), 'Insurance'),
                                (gen_random_uuid(), 'Kids'),
                                (gen_random_uuid(), 'Medical'),
                                (gen_random_uuid(), 'Clothing'),
                                (gen_random_uuid(), 'Entertainment'),
                                (gen_random_uuid(), 'Travel'),
                                (gen_random_uuid(), 'Savings'),
                                (gen_random_uuid(), 'Income'),
                                (gen_random_uuid(), 'Reimbursement'),
                                (gen_random_uuid(), 'Transfer'),
                                (gen_random_uuid(), 'Fees'),
                                (gen_random_uuid(), 'Taxes'),
                                (gen_random_uuid(), 'Investment'),
                                (gen_random_uuid(), 'Amazon');

INSERT INTO tags (id, name) VALUES
                                (gen_random_uuid(), 'Alcohol'),
                                (gen_random_uuid(), 'Apple'),
                                (gen_random_uuid(), 'Beauty'),
                                (gen_random_uuid(), 'DMV'),
                                (gen_random_uuid(), 'Finance'),
                                (gen_random_uuid(), 'Home Improvement'),
                                (gen_random_uuid(), 'Home Services'),
                                (gen_random_uuid(), 'Pharmacy'),
                                (gen_random_uuid(), 'Retail'),
                                (gen_random_uuid(), 'Software'),
                                (gen_random_uuid(), 'Storage'),
                                (gen_random_uuid(), 'Tech'),
                                (gen_random_uuid(), 'Uncategorized'),
                                (gen_random_uuid(), 'Venmo'),
                                (gen_random_uuid(), 'Web Services');

INSERT INTO tags (id, name) VALUES
                                (gen_random_uuid(), 'Paypal Stonehillvenue'),
                                (gen_random_uuid(), 'Paypal Stonehill Events'),
                                (gen_random_uuid(), 'Paypal Christmascalls'),
                                (gen_random_uuid(), 'Paypal Thedomesticthug'),
                                (gen_random_uuid(), 'Paypal Augielopez'),
                                (gen_random_uuid(), 'Prime'),
                                (gen_random_uuid(), 'Amex Augie'),
                                (gen_random_uuid(), 'Amex Melissa'),
                                (gen_random_uuid(), 'Capital One Melissa'),
                                (gen_random_uuid(), 'Capital One Augie'),
                                (gen_random_uuid(), 'Chapter One'),
                                (gen_random_uuid(), 'Chase Ink'),
                                (gen_random_uuid(), 'Chase Sapphire Melissa'),
                                (gen_random_uuid(), 'Chase Sapphire Augie'),
                                (gen_random_uuid(), 'Dustin Pest Control'),
                                (gen_random_uuid(), 'Google One'),
                                (gen_random_uuid(), 'Google GSuite Stonehi'),
                                (gen_random_uuid(), 'Google GSuite Krmwc'),
                                (gen_random_uuid(), 'Groceries'),
                                (gen_random_uuid(), 'Hellofresh'),
                                (gen_random_uuid(), 'Betty Flora'),
                                (gen_random_uuid(), 'Dept Education'),
                                (gen_random_uuid(), 'PG&E'),
                                (gen_random_uuid(), 'Peacock'),
                                (gen_random_uuid(), 'United Fin'),
                                (gen_random_uuid(), 'Fresno County Tax Coll'),
                                (gen_random_uuid(), 'Mosaic'),
                                (gen_random_uuid(), 'Spotify'),
                                (gen_random_uuid(), 'Verizon Wireless'),
                                (gen_random_uuid(), 'VW Credit'),
                                (gen_random_uuid(), 'Fresno Association'),
                                (gen_random_uuid(), 'Supra'),
                                (gen_random_uuid(), 'Utility Bill Payments'),
                                (gen_random_uuid(), 'Ronnie Ramirez'),
                                (gen_random_uuid(), 'Comcast'),
                                (gen_random_uuid(), 'Silviana'),
                                (gen_random_uuid(), 'So Cal Gas'),
                                (gen_random_uuid(), 'Assurant'),
                                (gen_random_uuid(), 'Hiya'),
                                (gen_random_uuid(), 'Amazon Web Services'),
                                (gen_random_uuid(), 'Best Buy'),
                                (gen_random_uuid(), 'Dbamr Coopnsm'),
                                (gen_random_uuid(), 'YouTube TV'),
                                (gen_random_uuid(), 'DocuSign'),
                                (gen_random_uuid(), 'Notion'),
                                (gen_random_uuid(), 'ChatGPT'),
                                (gen_random_uuid(), 'Gas Melissa'),
                                (gen_random_uuid(), 'Storland'),
                                (gen_random_uuid(), 'Gas Augie')
    ON CONFLICT (name) DO NOTHING;

insert into tags
values (gen_random_uuid(), 'Credit Card Payment');

select * from tags where name = 'Etsy';

-- Transaction <-> Tags Mapping Table
CREATE TABLE IF NOT EXISTS transaction_tags (
    transaction_id UUID REFERENCES combined_transactions(id),
    tag_id UUID REFERENCES tags(id),
    PRIMARY KEY (transaction_id, tag_id)
    );

-- View: Transactions with tags and account info
CREATE OR REPLACE VIEW v_all_transactions_with_tags AS
SELECT
    ct.id AS transaction_id,
    a.name AS account_name,
    a.bank_name,
    ct.date,
    ct.amount,
    ct.description,
    array_agg(t.name) AS tag_names
FROM combined_transactions ct
         JOIN bank_account_names a ON ct.account_id = a.id
         LEFT JOIN transaction_tags tt ON ct.id = tt.transaction_id
         LEFT JOIN tags t ON t.id = tt.tag_id
GROUP BY ct.id, a.name, a.bank_name, ct.date, ct.amount, ct.description;

-- Raw Tables for Uploads

-- First Tech Format
CREATE TABLE IF NOT EXISTS raw_transactions_first_tech (
                                                           id SERIAL PRIMARY KEY,
                                                           posting_date TEXT,
                                                           effective_date TEXT,
                                                           transaction_type TEXT,
                                                           amount TEXT,
                                                           reference_number TEXT,
                                                           description TEXT,
                                                           transaction_category TEXT,
                                                           type TEXT,
                                                           balance TEXT,
                                                           extended_description TEXT,
                                                           source_file_name TEXT
);

-- US Bank Format
CREATE TABLE IF NOT EXISTS raw_transactions_us_bank_credit (
                                                               id SERIAL PRIMARY KEY,
                                                               date TEXT,
                                                               transaction TEXT,
                                                               name TEXT,
                                                               memo TEXT,
                                                               amount TEXT,
                                                               source_file_name TEXT
);

-- Fidelity Format
CREATE TABLE IF NOT EXISTS raw_transactions_fidelity_cash (
                                                              id SERIAL PRIMARY KEY,
                                                              run_date TEXT,
                                                              action TEXT,
                                                              symbol TEXT,
                                                              description TEXT,
                                                              type TEXT,
                                                              quantity TEXT,
                                                              price TEXT,
                                                              commission TEXT,
                                                              fees TEXT,
                                                              accrued_interest TEXT,
                                                              amount TEXT,
                                                              cash_balance TEXT,
                                                              settlement_date TEXT,
                                                              source_file_name TEXT
);

-- Trigger: Insert History
CREATE OR REPLACE FUNCTION log_transaction_insert()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO transaction_history (
    original_transaction_id,
    account_id,
    date,
    amount,
    description,
    tags,
    change_type
)
VALUES (
           NEW.id,
           NEW.account_id,
           NEW.date,
           NEW.amount,
           NEW.description,
           NEW.tags,
           'insert'
       );
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_insert
    AFTER INSERT ON combined_transactions
    FOR EACH ROW
    EXECUTE FUNCTION log_transaction_insert();

-- Trigger: Update History
CREATE OR REPLACE FUNCTION log_transaction_update()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO transaction_history (
    original_transaction_id,
    account_id,
    date,
    amount,
    description,
    tags,
    change_type
)
VALUES (
           NEW.id,
           NEW.account_id,
           NEW.date,
           NEW.amount,
           NEW.description,
           NEW.tags,
           'update'
       );
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_update
    AFTER UPDATE ON combined_transactions
    FOR EACH ROW
    EXECUTE FUNCTION log_transaction_update();


CREATE TABLE transaction_tag_history (
                                         id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                         transaction_id UUID REFERENCES combined_transactions(id) ON DELETE CASCADE,
                                         tag_id UUID REFERENCES tags(id),
                                         action TEXT CHECK (action IN ('added', 'removed')),
                                         changed_by UUID, -- Optional: who made the change (auth.uid())
                                         changed_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE bill_reconciliation_history (
                                             id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                             bill_pk integer REFERENCES tb_bills(pk) ON DELETE CASCADE,
                                             transaction_id UUID REFERENCES combined_transactions(id), -- nullable for unpaid
                                             match_status TEXT CHECK (match_status IN ('paid', 'unpaid', 'partial', 'overpaid')),
                                             match_type TEXT CHECK (match_type IN ('auto', 'manual')),
                                             matched_at TIMESTAMPTZ DEFAULT now(),
                                             expected_amount NUMERIC,
                                             actual_amount NUMERIC,
                                             month_start DATE NOT NULL, -- first of the month for filtering
                                             matched_by UUID, -- auth.uid(), nullable for auto
                                             notes TEXT -- optional for manual overrides or discrepancies
);

CREATE INDEX idx_bill_recon_month ON bill_reconciliation_history (month_start, bill_pk);

create table temporary_table (
                                 transaction text,
                                 tag text
);


INSERT INTO transaction_tags (transaction_id, tag_id)
SELECT ct.id, t.id
FROM combined_transactions ct
         JOIN temporary_table tt ON ct.description = tt.transaction
         JOIN tags t ON t.name = tt.tag
WHERE ct.date BETWEEN '2025-03-01' AND '2025-03-31'
    ON CONFLICT DO NOTHING;

create or replace function get_all_transactions_from_view()
    returns setof v_all_transactions_with_tags
    language sql
as $$
select * from v_all_transactions_with_tags;
$$;





