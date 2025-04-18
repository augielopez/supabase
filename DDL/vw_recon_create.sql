DROP VIEW vw_recon;

CREATE OR REPLACE VIEW public.vw_recon AS
SELECT
    a.name::text as account_name,
        b.sql::text,
        t.name::text as transaction_desc,
        t.date as transaction_date,
    b.duedate::text as due_date, -- Cast to text
        t.amount as transaction_amount,
    (b.payment * -1) as expected_amount,
    t.source::text,
        b.isfixed,
    a.pk as accountpk,
    a.ownerpk,
    a.loginpk,
    b.pk as billpk,
    b.priorityfk,
    b.frequencyfk,
    b.typefk,
    b.paymenttypefk,
    b.isincludedinmonthlypayment,
    b.isactive
FROM tb_accounts a
         JOIN tb_bills b ON a.pk = b.accountfk
         JOIN vw_all_transaction t ON lower(t.name) LIKE '%' || lower(b.sql) || '%'
WHERE
    (sql IN ('AMEX EPAYMENT', 'CAPITAL ONE')
        AND t.amount IS NOT NULL
        AND t.amount BETWEEN (b.payment * -1) - 50 AND (b.payment * -1) + 50)
   OR
    (sql NOT IN ('AMEX EPAYMENT', 'CAPITAL ONE')
        AND t.amount IS NOT NULL)
ORDER BY a.pk, t.date;