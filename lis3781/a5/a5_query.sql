IF OBJECT_ID(N' dbo.product_days_of_week', N'P') IS NOT NULL
DROP PROC dbo.product_days_of_weekof week;
GO
CREATE PROC dbo.product_days_of_weekof week AS
BEGIN
select pro_name, pro_descript, datename(dw, tim_day-1) 'day of week'
from product p
join sale s on p.pro_id = s.pro_id
join time t on t.tim_id = s.tim_id
order by tim_day-1 asc;
END
GO

exec dbo.product_days_of_week;



IF OBJECT ID(N'dbo.product drill down', N'P') IS NOT NULL
DROP PROC dbo.product_drill_down;
GO
CREATE PROC dbo.product_drill_down AS
BEGIN
select pro_name, pro_qoh,
FORMAT(pro_cost, 'C', 'en-us') as cost,
FORMAT(pro_price, 'C', 'en-us') as price,
str_name, cty_name, ste_name, reg_name
from product p
join sale s on p.pro_id=s.pro_id
join store sr on sr.str_id=s.str_id
join city c on sr.cty_id=c.cty_id
join state st on c.ste_id=st.ste_id
join region r on st.reg_id=r.reg_id
order by pro_goh desc;
END
GO

exec do.product drill down;


IF OBJECT_ID(N'dbo.add_payment', N'P') IS NOT NULL
DROP PROC dbo.add_payment;
GO
CREATE PROC dbo.add_payment
@inv_id_p int,
@pay_ date_p datetime,
@pay_amt_p decimal(7,2),
@pay_notes p varchar(255)
AS
BEGIN

insert into payment(inv_id, pay_date, pay_amt, pay_notes)
values
(@inv_id_p, @pay_date_p, @pay_amt_p, @pay_notes_p);
END
GO
print 'list table data before call';
select * from payment;

DECLARE
@inv_id_v int = 6,
@pay_date_v DATETIME = '2014-01-05 11:56:38',
@pay_amt_v DECIMAL(7,2) = 159.99,
@pay_notes_v VARCHAR(255) = 'testing add_payment';


exec dbo.add_payment @inv_id_v, @pay_date_v, @pay_amt_v, @pay_notes_v;

print 'list table data after call';
select * from payment;

select * from test.information schema.routines
where routine type = 'PROCEDURE';
GO

sp_helptext 'dbo.add payment'
go

drop PROC dbo.add_payment;



IF OBJECT_ID(N'dbo.customer_balance', N'P') IS NOT NULL
DROP PROC dbo.customer_balance
GO
CREATE PROC dbo.customer_balance
@per_lname_p varchar(30)
AS
BEGIN
select p.per_id, per_fame, per_lname, i.inv_id,
FORMAT(sum(pay_amt), 'C', 'en-us') as total_paid,
FORMAT ((inv_total - sum(pay_amt)), 'C', 'en-us') as invoice_diff
from person p
join dbo.customer c on p.per_id=c.per_id
join dbo.contact ct on c.per_id=ct.per_cid
join dbo.[order] o on ct.cnt_id=o.cnt_id
join dbo.invoice i on o.ord_id=i.ord_id
join dbo.payment pt on i.inv_id=pt.inv_id
where per_lname=@per_lname_p
group by p.per_id, i.inv_id, per_lname, per_fname, inv_total;
END
GO
DECLARE @per_lname_v varchar(30) = 'smith';
exec dbo.customer_balance @per_lname_v;

IF OBJECT_ID(N'dbo.store sales_between_dates', N'P') IS NOT NULL
DROP PROC dbo.store_sales_between_dates
GO

CREATE PROC dbo.store_sales_between_dates
@start_date_p smallint,
@end_date_p smallint
AS
BEGIN
select st.str_id, FORMAT(sum (sal_total), 'C', 'en-us') as 'total sales', tim_yr as year
from store st
join sale s on st.str_id=s.str_id
join time t on s.tim_id=t.tim_id
where tim_yr between @start_date_p and @end_date_p
group by tim_yr, st.str_id
order by sum(sal_total) desc, tim_yr desc;
END
GO

DECLARE
@start_date_v smallint=2010,
@end_date_v smallint = 2013;
- call stored procedure
exec dbo.store_sales_between_dates @start_date_v, @end_ date_v;



DROP TRIGGER dbo.trg_check_inv_paid
GO
CREATE TRIGGER dbo.trg_check_inv_paid
ON dbo.payment
AFTER INSERT AS
BEGIN

update invoice
set inv paid=0;

UPDATE invoice
SET inv_paid=1
FROM invoice as i
JOIN
(
SELECT inv_id, sum(pay_amt) as total_paid
FROM payment
GROUP BY inv_id
) as v ON i.inv_id=v.inv_id
WHERE total_paid >= inv_total;
END
GO
print 'list table data before trigger fires (resets all invoices to unpaid, 0):';
select * from invoice;

INSERT INTO dbo.payment
(inv_id, pay_date, pay_amt, pay_notes)
VALUES
(3, '2014-07-04', 75.00, 'Paid by check.');
print 'list table data after trigger fires (after trigger validation, displays updated inv_paid attribute): ';
select * from invoice;
select * from payment;
select inv_id, sum(pay_amt) as sum_pmt
from payment
group by inv_id;



IF OBJECT ID(N'dbo.order line total', N'P') IS NOT NULL
DROP PROC dbo.order_line_total
IO
CREATE PROC dbo.order_line_total AS
BEGIN
select oln_id, p.pro_id, pro_name, pro_descript,
FORMAT (pro_price, 'C', 'en-us') as pro _price,
oln_qty,
FORMAT((on_qty * pro_price),'C', 'en-us') as oln_price,
FORMAT((oln_qty * pro_price) * 1.06, 'C', 'en-us') as total_with_6pct_tax
from product p
join order_line ol on p.pro_id=ol.pro_id
order by p.pro_id;
END
GO
