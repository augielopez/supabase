BEGIN
  RETURN QUERY
  SELECT a.name::text as account_name,
         b.sql::text,
         t.name::text as transaction_desc,
         t.date as transaction_date,
         b.duedate::text as due_date, -- Cast to text
         t.amount as transaction_amount,
         b.payment as expected_amount,
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
  LEFT JOIN vw_all_transaction t ON lower(t.name) LIKE '%' || lower(b.sql) || '%'
  WHERE (t.amount is null OR t.amount < -.99)
  ORDER BY t.date, a.name;
END;
