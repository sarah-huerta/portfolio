select * from [sah16m].information_schema.tables;
go



select * from [sah16m].information_schema.columns;
go


sp_help 'dbo.srp_hist';
go

use sah16m;
go

select * from dbo.invoice;
select inv_id, inv_total as paid_invoice_total
from dbo.paid_invoice_total
where inv_paid !=0;
print '#1 Solution';


IF OBJECT_ID (N'dbo.v_paid_invoice_total', N'V') IS NOT NULL
DROP VIEW do.v_paid_invoice_total;
GO
create view dbo.v_paid_invoice_total as
select p.per_id, per_fn=ame, per_lname, sum(inv_total) as sum_total, FORMAT (sum(inv_total), 'C', 'en-us') as paid_invoice_total
from dbo.person p
join dbo.customer c on p.per_id=c.per_id
join dbo.contact ct on c.per_id=ct.per_cid
join dbo.[order] o on ct.cnt_id=o.cnt_id
join dbo.invoice i on o.ord_id=i.ord_id
where inv_paid !=0
group by p.per_id, per_fname, per_lname
go
select per_id, per_fname, per_lname, paid_invoice_total from dbo.v_paid_invoice_total order by sum_total desc;

go

select * from information_schema.tables;
go



-- a. individual customer
select p.per_id, per_fname, per_lname,
sum(pay_amt) as total_paid, (inv_total - sum(pay_amt)) invoice_diff
from person p
join dbo.customer c on p.per_id=c.per_id
join dbo.contact ct on c.per_id=ct.per_cid
join dbo.[order] o on ct.cnt_id=o.cnt_id
join dbo.invoice i on o.ord_id=i.ord_id
join dbo.payment pt on i.inv_id=pt.inv_id
where p.per_id=7
group by p.per_id, per_fname, per_lname, inv_total;

print '#2 Solution: create procedure (displays all customers" outstanding balances)';


IF OBJECT_ID(N'dbo.sp_all_customers_outstanding_balances', N'P') IS NOT NULL
DROP PROC dbo.sp_all_customers_outstanding_balances
GO

CREATE PROC dbo.sp_all_customers_outstanding_balances AS
BEGIN
select p.per_id, per_fname, per_lname,
sum(pay_amt) as total_paid, (inv_total - sum(pay_amt)) invoice_diff
from person p
join dbo.customer c on p.per_id=c.per_id
join dbo.contact ct on c.per_id=ct.per_cid
join dbo.[order] o on ct.cnt_id=o.cnt_id
join dbo.invoice i on o.ord_id=i.ord_id
join dbo.payment pt on i.inv_id=pt.inv_id
=
group by p.per_id, per_fname, per_lname, inv_total
order by invoice_diff desc;
END
GO

exec dbo.sp_all_customers_outstanding_balances;

select * from sah16m.information_schema.routines
where routine_type = 'PROCEDURE';
go
sp_helptext 'dbo.sp_all_customers_outstanding_balances'
go


print '#3 Solution: create stored procedure to populate history table w/sales reps" data when called';

IF OBJECT_ID(N'dbo.sp_populate_srp_hist_table', N'P') IS NOT NULL
DROP PROC dbo.sp_populate_srp_hist_table
GO
CREATE PROC dbo.sp_populate_srp_hist_table AS
BEGIN
INSERT INTO dbo.srp_hist
(per_id, sht_type, sht_modified, sht_modifier, sht_date, sht_yr_sales_goal, sht_yr_total _sales, sht_yr_total_comm, sht_notes)

SELECT per_id, 'i', getDate(), SYSTEM_USER, getDate(), srp_yr sales_goal, srp_ytd_sales, srp_ytd_comm, srp_notes
FROM dbo.slsrep;
END
GO

select * from dbo.slsrep:
select * from dbo.srp_hist;

delete from dbo.srp_hist;

exec dbo.sp_populate_srp_hist_table;

print ' list table data after call';
select * from dbo.slsrep:
select * from dbo.srp_hist;

select * from sah16m.information_schema.routines
where routine_type = 'PROCEDURE';
go
sp_helptext 'dbo.sp_populate_srp_hist_table'
go
drop PROC dbo.sp_populate_srp_hist_table;
go

print '#4 Solution';

IF OBJECT_ID(N'dbo.trg_sales_history_insert', N'TR') IS NOT NULL
DROP TRIGGER dbo.trg_sales_history_insert
GO

CREATE TRIGGER dbo.trg_sales_history_insert
ON dbo.slsrep

AFTER INSERT AS
BEGIN

DECLARE
@per_id_v smallint,
@sht_type_v char(1),
@sht_modified_v date,
@sht_modifier_v varchar(45),
@sht_date_v date,
@sht_yr_sales_goal_v decimal(8,2),
@sht_yr_total_sales_v decimal(8,2).
@sht_yr_total_comm_v decimal(7,2),
@sht_notes_v varchar(255);

SELECT
@per_id_v = per_id,
@sht_type_v = 'i'
@sht_modified_v = getDate(),
@sht_modifier_v = SYSTEM_USER,
@sht_date_v = getDate(),
@sht_yr_sales_goal_v = srp_yr_sales_goal,
@sht_yr_total_sales_v = srp_ytd_sales,
@sht_yr_total_comm_v = srp_ytd_comm,
@sht_notes_v = sp_notes
FROM INSERTED;


INSERT INTO dbo.srp_hist
(per_id, sht_type, sht_modified, sht_modifier, sht_date, sht_yr_sales_goal, sht_yr_total_sales, sht_yr_total_comm, sht_notes)
VALUES
(@per_id_v, @sht_type_v, @sht_modified_v, @sht_modifier_v, @sht_date_v, @sht_yr_sales_goal_v, @sht_yr_total_sales_v, @sht_yr_total_comm_v,@sht_notes_v);
END
GO
print 'list table data before trigger fires';

select * from slsrep;
select * from srp_hist;

INSERT INTO dbo.slsrep
(per_id, srp_yr_sales_goal, srp_ytd_sales, srp_ytd_comm, srp_notes)
VALUES
(6, 98000, 43000, 8750, 'per_id values 1-5 already used');
print 'list table data after trigger fires';
select * from slsrep;
select * from srp_hist;

SELECT * FROM sys.triggers;
GO

sp_helptext 'dbo.trg_sales_history_insert'
go

DROP TRIGGER dbo.trg_sales_history_insert;
go


print 'Solution #5';



DROP TRIGGER dbo.trg_product_history_insert
GO

CREATE TRIGGER dbo.trg_product_history_insert
ON dbo.product

AFTER INSERT AS
BEGIN
DECLARE

@pro_id_v smallint,
@pht_type_v,
@pht_modified_v date,
@pht modifier_v,
@pht_cost_v decimal(7,2),
@pht_price_v decimal(7,2),
@pht_discount_v decimal (3,0),
@pht_notes_v varchar(255);
SELECT
@pro_id_v = pro_id,
@pht_modified_v = getDate(),
@pht_cost_v = pro_cost,
@pht_price_v = pro_price,
@pht_discount_v = pro_discount,
@pht_notes_v = pro_notes
FROM INSERTED;

INSERT INTO dbo.product_hist
(pro_id, pht_date, pht_cost, pht_price, pht_discount, pht_notes)
VALUES
(@pro_id_ v, @pht_modified_v,@pht_cost_v, @pht_price_v, @pht_discount_v,@pht_notes_v);
END
GO


print 'list table data before trigger fires:';
select * from product;
(select * from product_hist;

- fire trigger
(INSERT INTO dbo.product
(ven_id, pro_name, pro_descript, pro_weight, pro_qoh, pro_cost, pro_price, pro_discount, pro_notes)
VALUES
(3, 'desk lamp', 'small desk lamp with led lights', 3.6, 14, 5.98, 11.99, 15, 'No discounts after sale.');
print 'list table data after trigger fires: ';

select * from product;
select * from product_hist;

select * from sys.triggers;
go
sp_helptext 'dbo.trg_product_history_insert'
go

DROP TRIGGER dbo.trg_product_history_insert;
go


print 'Extra Credit';


IF OBJECT_ID(N'dbo.sp_annual_salesrep_sales_goal', N'P') IS NOT NULL
DROP PROC dbo.sp_annual_salesrep_sales_goal
GO
CREATE PROC dbo.sp-annual-salesrep_sales_ goal AS
BEGIN

UPDATE slsrep
SET srp_yr_sales_goal = sht_yr_total_sales * 1.08
from slsrep as sr
JOIN srp_hist as sh
ON sr.per_id = sh.per_id
where sht_date=(select max(sht_date) from srp_hist);
END
GO

select * from dbo.slsrep;
select * from dbo.srp_hist;

exec dbo.sp_annual_salesrep_sales_goal;

print 'list table after call';

select * from dbo.slsrep;

select * from sah16m.information_schema.routines
where routine_type = 'PROCEDURE';
go
