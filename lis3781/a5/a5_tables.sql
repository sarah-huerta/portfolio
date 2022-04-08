SET ANSI_WARNINGS ON;
GO
use master;
GO

IF exists (select name from master.dbo.sysdatabases WHERE name = N'sah16m')
DROP database sah16m;
GO

IF NOT exists (select name from master.dbo.sysdatabases WHERE name = N'sah16m')
Create database sah16m;
GO

use sah16m;
GO


IF OBJECT_ID (N'dbo.person', N'U') IS NOT NULL
DROP TABLE dbo.person;
GO

CREATE TABLE dbo.person
(
  per_id SMALLINT not null identity (1,1),
  per_ssn binary(64) NULL,
  per_salt binary(64) NULL,
  per_fame VARCHAR(15) NOT NULL,
  per_lname VARCHAR(30) NOT NULL,
  per_gender CHAR(1) NOT NULL CHECK (per_gender IN('m', 'f')),
  per_dob DATE NOT NULL,
  per_street VARCHAR(30) NOT NULL,
  per_city VARCHAR(30) NOT NULL,
  per_state CHAR(2) NOT NULL DEFAULT 'FL',
  per_zip int NOT NULL check (per_zip like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  per_email VARCHAR(100) NULL,
  per_type CHAR(1) NOT NULL CHECK (per_type IN('c', 's')),
  per_notes VARCHAR(45) NULL,
  PRIMARY KEY (per_id),

  CONSTRAINT ux_per_ssn unique nonclustered (per_ssn ASC)
);
GO

IF OBJECT_ID (N'dbo.phone', N'U') IS NOT NULL
DROP TABLE dbo.phone;
GO

CREATE TABLE dbo.phone
(
phn_id SMALLINT NOT NULL identity(1,1),
per_id SMALLINT NOT NULL,
phn_num bigint NOT NULL check (phn_num like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
phn_type char(1) NOT NULL CHECK (phn_type IN('h','c', 'w', 'f')),
phn_notes VARCHAR(255) NULL,
PRIMARY KEY (phn_id),

CONSTRAINT fk_phone_person
FOREIGN KEY (per_id)
REFERENCES dbo.person(per_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO


IF OBJECT_ID (N'dbo.customer', N'U') IS NOT NULL
DROP TABLE dbo.customer;
GO


CREATE TABLE dbo.customer
(
per_id SMALLINT not null,
cus_balance decimal(7,2) NOT NULL check (cus_balance >= 0),
cus_total_sales decimal(7,2) NOT NULL check (cus_total_sales >= 0),
cus_notes VARCHAR(45) NULL,
PRIMARY KEY (per_id),

CONSTRAINT fk_customer_person
FOREIGN KEY (per_id)
REFERENCES dbo.person(per_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO


IF OBJECT_ID (N'dbo.slsrep', N'U') IS NOT NULL
DROP TABLE dbo.slsrep;
GO


CREATE TABLE dbo.slsrep
(
per_id SMALLINT not null,
srp_yr_sales_goal decimal(8,2) NOT NULL check (srp_yr_sales_goal >= 0),
srp_ytd_sales decimal(8,2) NOT NULL check (srp_ytd_sales >= 0),
srp_ytd_comm decimal(7,2) NOT NULL check (srp_ytd_comm >= 0),
srp_notes VARCHAR(45) NULL,
PRIMARY KEY (per_id),

CONSTRAINT fk_slsrep_person
FOREIGN KEY (per_id)
REFERENCES dbo.person (per_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

IF OBJECT_ID (N'dbo.srp_hist', N'U') IS NOT NULL
DROP TABLE dbo.srp_hist;
GO

CREATE TABLE dbo.srp_hist
(
sht_id SMALLINT not null identity(1,1),
per_id SMALLINT not null,
sht_type char(1) not null CHECK (sht_type IN('i', 'u', 'd')),
sht_modified datetime not null,
sht_modifier varchar(45) not null default system_user,
sht_date date not null default getDate(),
sht_yr_sales_goal decimal (8,2) NOT NULL check (sht_yr_sales_goal >= 0),
sht_yr_total_sales decimal (8,2) NOT NULL check (sht_yr_total_sales >= 0),
sht_yr_total_comm decimal (7,2) NOT NULL check (sht_yr_total_comm >= 0),
sht_notes VARCHAR(45) NULL,
PRIMARY KEY (sht_id),

CONSTRAINT fk_srp_hist_slsrep
FOREIGN KEY (per_id)
REFERENCES dbo.slsrep (per_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

IF OBJECT_ID (N'dbo.contact', N'U') IS NOT NULL
DROP TABLE dbo.contact;
GO

CREATE TABLE dbo.contact
(
cnt_id int NOT NULL identity(1,1),
per_cid smallint NOT NULL,
per_sid smallint NOT NULL,
cnt_date datetime NOT NULL,
cnt_notes varchar(255) NULL,
PRIMARY KEY (cnt_id),

CONSTRAINT fk_contact_customer
FOREIGN KEY (per_cid)
REFERENCES dbo.customer (per_id)
ON DELETE CASCADE
ON UPDATE CASCADE,

CONSTRAINT fk_contact_slsrep
FOREIGN KEY (per_sid)
REFERENCES dbo.slsrep (per_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);
GO

IF OBJECT_ID (N'dbo.[order]', N'U') IS NOT NULL
DROP TABLE dbo.[order];
GO


CREATE TABLE dbo.[order]
(
ord_id int NOT NULL identity (1,1),
cnt_id int NOT NULL,
ord_placed_date DATETIME NOT NULL,
ord_filled_date DATETIME NULL,
ord_notes VARCHAR(255) NULL,
PRIMARY KEY (ord_id),

CONSTRAINT fk_order_contact
FOREIGN KEY (cnt_id)
REFERENCES dbo.contact (cnt_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

IF OBJECT_ID (N'dbo.time', N'U') IS NOT NULL
DROP TABLE dbo.time;
GO
CREATE TABLE dbo.time
(
tim_id INT NOT NULL Identity(1,1),
tim_yr SMALLINT NOT NULL,
tim_qtr TINYINT NOT NULL,
tim_month TINYINT NOT NULL,
tim_week TINYINT NOT NULL,
tim_day TINYINT NOT NULL,
tim_time TIME NOT NULL,
tim_notes VARCHAR(255) NULL,
PRIMARY KEY (tim_id)
);
GO


IF OBJECT_ID (N'dbo.region', N'U') IS NOT NULL
DROP TABLE dbo.region;
GO

CREATE TABLE region
(
reg_id TINYINT NOT NULL identity (1,1),
reg_name CHAR(1) NOT NULL,
reg_notes VARCHAR (255) NULL,
PRIMARY KEY (reg_id)
);
GO

IF OBJECT_ID (N'dbo.state', N'U') IS NOT NULL
DROP TABLE dbo.state;
GO


CREATE TABLE dbo.state
(
ste_id TINYINT NOT NULL Identity(1,1),
reg_id TINYINT NOT NULL,
ste_name CHAR(2) NOT NULL DEFAULT 'FL',
ste_notes VARCHAR(255) NULL,
PRIMARY KEY (ste_id),

CONSTRAINT fk_state_region
FOREIGN KEY (reg_id)

REFERENCES dbo.region (reg_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

IF OBJECT_ID (N'dbo.city', N'U') IS NOT NULL
DROP TABLE dbo.city;
GO


CREATE TABLE dbo.city
(
cty_id SMALLINT NOT NULL identity(1,1),
ste_id TINYINT NOT NULL,
cty_name VARCHAR(30) NOT NULL,
cty_notes VARCHAR(255) NULL,
PRIMARY KEY (cty_id),

CONSTRAINT fk_city_state
FOREIGN KEY (ste_id)
REFERENCES dbo.state (ste_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

IF OBJECT_ID (N'dbo.store', N'U') IS NOT NULL
DROP TABLE dbo.store;
GO

CREATE TABLE dbo.store
(
str_id SMALLINT NOT NULL identity(1,1),
cty_id SMALLINT NOT NULL,
str_name VARCHAR(45) NOT NULL,
str_street VARCHAR(30) NOT NULL,
str_zip int NOT NULL check (str_zip like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
str_phone bigint NOT NULL check (str_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
str_email VARCHAR(100) NOT NULL,
str_url VARCHAR(100) NOT NULL,
str_notes VARCHAR(255) NULL,
PRIMARY KEY (str_id),

CONSTRAINT fk_store_city
FOREIGN KEY (cty_id)
REFERENCES dbo.city (cty_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

IF OBJECT_ID (N'dbo.invoice', N'U') IS NOT NULL
DROP TABLE dbo.invoice;
GO

CREATE TABLE dbo.invoice
(
inv_id int NOT NULL identity(1,1),
ord_id int NOT NULL,
str_id SMALLINT NOT NULL,
inv_date DATETIME NOT NULL,
inv_total DECIMAL(8,2) NOT NULL check (inv_total >= 0),
inv_paid bit NOT NULL,
inv_notes VARCHAR(255) NULL,
PRIMARY KEY (inv_id),

CONSTRAINT ux_ord_id unique nonclustered (ord_id ASC),
CONSTRAINT fk_invoice_order
FOREIGN KEY (ord_id)
REFERENCES dbo.[order] (ord_id)
ON DELETE CASCADE
ON UPDATE CASCADE,

CONSTRAINT fk_invoice_store
FOREIGN KEY (str_id)
REFERENCES dbo.store (str_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO





IF OBJECT_ID (N'dbo.payment', N'U') IS NOT NULL
DROP TABLE dbo.payment;
GO

CREATE TABLE dbo.payment
(
pay_id int NOT NULL identity (1,1),
inv_id int NOT NULL,
pay_date DATETIME NOT NULL,
pay_amt DECIMAL(7,2) NOT NULL check (pay_amt >= 0),
pay_notes VARCHAR(255) NULL,
PRIMARY KEY (pay_id),

CONSTRAINT fk_payment_invoice
FOREIGN KEY (inv_id)
REFERENCES dbo.invoice (inv_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

IF OBJECT_ID (N'dbo.vendor', N'U') IS NOT NULL
DROP TABLE dbo.vendor;
GO

CREATE TABLE dbo.vendor
(
ven_id SMALLINT NOT NULL identity (1,1),
ven_name VARCHAR(45) NOT NULL,
ven_street VARCHAR(30) NOT NULL,
ven_city VARCHAR(30) NOT NULL,
ven_state CHAR(2) NOT NULL DEFAULT 'FL',
ven_zip int NOT NULL check (ven_zip like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
ven_phone bigint NOT NULL check (ven_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
ven_email VARCHAR(100) NULL,
ven_url VARCHAR(100) NULL,
ven_notes VARCHAR(255) NULL,
PRIMARY KEY (ven_id)
);
GO



IF OBJECT_ID (N'dbo.product', N'U') IS NOT NULL
DROP TABLE dbo.product;
GO
CREATE TABLE dbo.product
(
pro_id SMALLINT NOT NULL identity(1,1),
ven_id SMALLINT NOT NULL,
pro_name VARCHAR(30) NOT NULL,
pro_descript VARCHAR(45) NULL,
pro_weight FLOAT NOT NULL check (pro_weight >= 0),
pro_qoh SMALLINT NOT NULL check (pro_qoh >= 0),
pro_cost DECIMAL(7,2) NOT NULL check (pro_cost >= 0),
pro_price DECIMAL(7,2) NOT NULL check (pro_price >= 0),
pro_discount DECIMAL(3,0) NULL,
pro_notes VARCHAR(255) NULL,
PRIMARY KEY (pro_id),

CONSTRAINT fk_product_vendor
FOREIGN KEY (ven_id)
REFERENCES dbo.vendor (ven_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

IF OBJECT_ID (N'dbo.product_hist', N'U') IS NOT NULL
DROP TABLE dbo.product_hist;
GO

CREATE TABLE dbo.product_hist
(
pht_id int NOT NULL identity(1,1),
pro_id SMALLINT NOT NULL,
pht_date DATETIME NOT NULL,
pht_cost DECIMAL(7,2) NOT NULL check (pht_cost >= 0),
pht_price DECIMAL(7,2) NOT NULL check (pht_price >= 0),
pht_discount DECIMAL(3,0) NULL,
pht_notes VARCHAR(255) NULL,
PRIMARY KEY (pht_id),

CONSTRAINT fk_product_hist_product
FOREIGN KEY (pro_id)
REFERENCES dbo.product (pro_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO


IF OBJECT_ID (N'dbo.order_line', N'U') IS NOT NULL
DROP TABLE dbo.order_line;
GO

CREATE TABLE dbo.order_line
(
oln_id int NOT NULL identity (1,1),
ord_id int NOT NULL,
pro_id SMALLINT NOT NULL,
oln_qty SMALLINT NOT NULL check (oln_qty >= 0),
oln_price DECIMAL(7,2) NOT NULL check (oln_price >= 0),
oln_notes VARCHAR(255) NULL,
PRIMARY KEY (oln_id),

CONSTRAINT fk_order_line_order
FOREIGN KEY (ord_id)
REFERENCES dbo.[order] (ord_id)
ON DELETE CASCADE
ON UPDATE CASCADE,

CONSTRAINT fk_order_line_product
FOREIGN KEY (pro_id )
REFERENCES dbo.product (pro_id )
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO



IF OBJECT_ID (N'dbo.sale', N'U') IS NOT NULL
DROP TABLE dbo.sale;
GO

CREATE TABLE dbo.sale
(
pro_id SMALLINT NOT NULL,
str_id SMALLINT NOT NULL,
cnt_id INT NOT NULL,
tim_id INT NOT NULL,
sal_qty SMALLINT NOT NULL,
sal_price DECIMAL(8,2) NOT NULL,
sal_total DECIMAL(8,2) NOT NULL,
sal_notes VARCHAR (255) NULL,
PRIMARY KEY (pro_id, cnt_id, tim_id, str_id),


CONSTRAINT ux_pro_id_str_id_cnt_id_tim_id
unique nonclustered (pro_id ASC, str_id ASC, cnt_id ASC, tim_id ASC),

CONSTRAINT fk_sale_time
FOREIGN KEY (tim_id)
REFERENCES dbo.time (tim_id)
ON DELETE CASCADE
ON UPDATE CASCADE,

CONSTRAINT fk_sale_contact
FOREIGN KEY (cnt_id)
REFERENCES dbo.contact (cnt_id)
ON DELETE CASCADE
ON UPDATE CASCADE,


CONSTRAINT fk_sale_store
FOREIGN KEY (str_id)
REFERENCES dbo.store (str_id)
ON DELETE CASCADE
ON UPDATE CASCADE,


CONSTRAINT fk_sale_product
FOREIGN KEY (pro_id)
REFERENCES dbo.product (pro_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
GO

SELECT * FROM information_schema.tables;
SELECT HASHBYTES('SHA2_512', 'test');
SELECT len(HASHBYTES('SHA2_512', 'test'));




INSERT INTO region
(reg_name, reg_notes)
VALUES
('c', NULL),
('n', NULL),
('e', NULL),
('s', NULL),
('w', NULL);
GO
select * from dbo.region;

INSERT INTO state
(reg_id, ste_name, ste_notes)
VALUES
(1, 'MI', NULL),
(3, 'II', NULL),
(4, 'WA', NULL),
(5, 'FL', NULL),
(2, 'TX', NULL);
GO

select * from dbo.state;

INSERT INTO city
(ste_id, cty_name, cty_notes)
VALUES
(1, 'Detroit', NULL),
(2, 'Aspen', NULL),
(2, 'Chicago', NULL),
(3, 'Clover', NULL),
(4, 'St. Louis', NULL);
GO
select * from dbo.city;

INSERT INTO dbo.store
(cty_id, str _name, str _street, str _zip, str phone, str_email, str_url, str_notes)
VALUES
(2, 'Walgreens','14567 Walnut Ln', 475315690, 3127658127, 'info@walgreens.com','http://www.walgreens.com',NULL),
(3, 'CVS', '572 Casper Rd', 505231519, 3128926534, 'help@cvs.com', 'http://www.cvs.com', 'Rumor of merger.'),
(4, 'Lowes', '81309 Catapult Ave', 802345671, 9017653421, 'sales@lowes.com', 'http://www.lowes.com', NULL),
(5, 'Walmart','14567 Walnut Ln', 387563628, 8722718923, 'Info@walmart.com','http://www.walmart.com',NULL),
(1, 'Dollar General', '47583 Davison Rd', 482983456, 3137583492, 'ask@dollargeneral.com', 'http://www.dollargerieral.com','recently sold property');
GO

select * from dbo.store:

/*
INSERT INTO dbo.product_hist
(pro_id, pht_date, pht_cost, pht_price, pht_discount, pht_notes)
VALUES
(1, '2005-01-02 11:53:34', 4.99, 7.99, 30, 'Discounted only when purchased with screwdriver set.'),
(2, '2005-02-03 09:13:56', 1.99, 3.49, NULL, NULL),
(3, '2005-03-04 23:21:49', 3.89, 7.99, 40, NULL),
(4, '2006-05-06 18:09:04', 19.99, 28.99, NULL, 'gallons'),
(5, '2006-05-07 15:07:29', 8.45, 13.99, 50, 'Currently 1/2 price sale.');
GO
select * from dbo.product_hist;
*/

INSERT INTO time
(tim_yr, tim_qtr, tim_month, tim_week, tim_day, tim_time, tim_notes)
VALUES
(2008, 2, 5, 19, 7, '11:59:59', NULL),
(2010, 4, 12, 49, 4, '08:34:21', NULL),
(1999, 4, 12, 52, 5, '05:21:34', NULL),
(2011, 3, 8, 36, 1, '09:32:18', NULL),
(2001, 3, 7, 27, 2, '23:56:32', NULL),
(2008, 1, 1, 5, 4, '04:22:36', NULL),
(2010, 2, 4, 14, 5, '02:49:11', NULL),
(2014, 1, 2, 8, 2, '12:27:14', NULL),
(2013, 3, 9, 38, 4, '10:12:28', NULL),
(2012, 4, 11, 47, 3, '22:36:22', NULL),
(2014, 2, 6, 23, 3, '19:07:10', NULL);
GO


INSERT INTO sale
(pro_id, str_id, cnt_id, tim_id, sal_qty, sal_price, sal_total, sal_notes)
VALUES
(1, 5, 5, 3, 20, 9.99, 199.8, NULL),
(2, 4, 6, 2, 5, 5.99, 29.95, NULL),
(3, 3, 4, 1, 30, 3.99, 119.7, NULL),
(4, 2, 1, 5, 15, 18.99, 284.85, NULL),
(5, 1, 2, 4, 6, 11.99, 71.94, NULL),
(5, 2, 5, 6, 10, 9.99, 199.8, NULL),
(4, 3, 6, 7, 5, 5.99, 29.95, NULL),
(3, 1, 4, 8, 30, 3.99, 119.7, NULL),
(2, 3, 1, 9, 15, 18.99, 284.85, NULL),
(1, 4, 2, 10, 6, 11.99, 71.94, NULL),
(1, 2, 3, 11, 10, 11.99, 119.9, NULL):
GO
select * from dbo.sale;
