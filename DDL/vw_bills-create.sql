CREATE OR REPLACE VIEW vw_bills AS
SELECT
    a.pk AS accountpk,
    b.pk AS billspk,
    o.name AS owner,
    a.name AS accountname,
    transactiondescription,
    b.balance AS balance,
    f.name AS chargetype,
    b.payment AS payment,
    b.duedate AS duedate,
    bt.name AS billtype,
    pt.name AS paymenttype,
    b.isincludedinmonthlypayment AS isincludedinmonthlypayment
FROM
    tb_bills b
JOIN
    tb_accounts a ON b.accountfk = a.pk
LEFT JOIN
    tb_type_bill bt ON b.typefk = bt.pk
LEFT JOIN
    tb_type_payment pt ON b.paymenttypefk = pt.pk
LEFT JOIN
    tb_owner o on o.pk = a.ownerpk
LEFT JOIN
    tb_type_bill_frequency f on f.pk = b.frequencyfk;