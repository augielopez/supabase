CREATE TABLE credit_card_info (
    card_id SERIAL PRIMARY KEY,                     -- Unique identifier for each card record
    card_name VARCHAR(100) NOT NULL,                -- Name of the credit card (e.g., Capital One, Citi Amex)
    card_type VARCHAR(50),                          -- Type of card (e.g., Visa, MasterCard, AmEx)
    card_network VARCHAR(20),                       -- Payment network (e.g., Visa, MasterCard)
    purchases_rate VARCHAR(20),                     -- Interest rate for purchases (with "V" indicating variable)
    cash_advance_rate VARCHAR(20),                  -- Interest rate for cash advances
    cash_advance_fee VARCHAR(20),                   -- Fee for cash advances (e.g., 5% Fee)
    balance_transfer_rate VARCHAR(20),              -- Interest rate for balance transfers
    balance_transfer_fee VARCHAR(20),               -- Fee for balance transfers
    annual_fee NUMERIC(10, 2),                      -- Annual fee for the card
    credit_limit NUMERIC(15, 2),                    -- Maximum credit limit for the card
    available_credit NUMERIC(15, 2),                -- Available credit on the card
    current_balance NUMERIC(15, 2),                 -- Current balance on the card
    last_statement_balance NUMERIC(15, 2),          -- Balance from the last billing statement
    interest_rate NUMERIC(5, 2),                    -- Interest rate on the card
    grace_period INT,                               -- Number of days before interest is charged on new purchases
    intro_apr VARCHAR(20),                          -- Introductory APR for purchases and balance transfers
    intro_apr_period INT,                           -- Duration (in months) for which the introductory APR is valid
    minimum_payment NUMERIC(10, 2),                 -- Minimum payment amount required each billing cycle
    cash_back_rate VARCHAR(20),                     -- Cash back rate offered by the card
    credit_score_required VARCHAR(20),              -- Credit score range required to qualify for the card
    late_fee NUMERIC(10, 2),                        -- Fee for late payments
    year_issued INT,                                -- Year the card was issued
    payment_assistance TEXT,                        -- Information on payment assistance or deferment options
    additional_perks TEXT,                          -- Any additional perks or benefits of the card
    contact_number VARCHAR(15),                     -- Customer service contact number
    points_rewards TEXT,                            -- Information on rewards points (e.g., 7 points at Hilton)
    credit_card_rewards_category VARCHAR(50),       -- Category of rewards points or cash back (e.g., Travel, Dining)
    cardholder_benefits TEXT,                       -- Additional cardholder benefits (e.g., travel insurance)
    issuer_name VARCHAR(50),                        -- Name of the financial institution that issued the card
    issuer_website VARCHAR(100),                    -- URL of the credit card issuer's website
    billing_cycle VARCHAR(20),                      -- Billing cycle period (e.g., monthly, bi-weekly)
    foreign_transaction_fee VARCHAR(10),            -- Fee percentage or amount charged for foreign transactions
    auto_pay_enrolled BOOLEAN,                      -- Indicates if the cardholder is enrolled in automatic payments
    updatedby  VARCHAR(255) NOT NULL,               -- Username or identifier of the user who last updated the record
    updatedon  TIMESTAMP NOT NULL,                  -- Timestamp of the last update
    createdby  VARCHAR(255) NOT NULL,               -- Username or identifier of the user who created the record
    createdon  TIMESTAMP NOT NULL                   -- Timestamp of the record creation
);