DROP VIEW vw_accounts;

CREATE OR REPLACE VIEW vw_accounts AS
SELECT DISTINCT
    a.pk AS account_pk,
    a.name AS account_name,
    a.url,
    a.ownerpk AS owner_pk,
    o.name AS owner_name,
    a.loginpk AS login_pk,
    l.username,
    l.password,
    CASE WHEN b.pk IS NULL THEN false ELSE true END AS is_bill,
    CASE WHEN b.isactive IS NULL OR b.isactive = FALSE THEN FALSE ELSE TRUE END AS has_active_bill
FROM
    tb_accounts a
        LEFT JOIN
    tb_owner o ON a.ownerpk = o.pk
        LEFT JOIN
    tb_logins l ON a.loginpk = l.pk
        LEFT JOIN
    tb_bills b ON a.pk = b.accountfk
ORDER BY 1;
