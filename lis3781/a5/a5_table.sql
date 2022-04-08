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
  per_fname VARCHAR(15) NOT NULL,
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
use master;
use sah16m;
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


SELECT * FROM information_schema.tables;
SELECT HASHBYTES('SHA2_512', 'test');
SELECT len(HASHBYTES('SHA2_512', 'test'));








-- ---------------------------------------------------------------
-- Inserts --
-- ---------------------------------------------------------------
INSERT INTO dbo.person
(per_ssn, per_fname, per_lname, per_gender, per_dob, per_street, per_city, per_state, per_zip, per_email, per_type, per_notes)
VALUES
(HASHBYTES('SHA2_512', 'test1'), 'Steve', 'Rogers', 'm', '1923-10-03', '437 Southern Drive', 'Rochester', 'NY', 324402222, 'srogers@comcast.net','s', NULL),
(HASHBYTES('SHA2_512', 'test2'), 'Bruce', 'Wayne', 'm', '1968-03-20', '1007 Mountain Drive', 'Gotham', 'NY', 983208440, 'bwayne@knology.net', 's', NULL),
(HASHBYTES('SHA2_512', 'test3'), 'Peter', 'Parker', 'm', '1988-09-12', '20 Ingram Street', 'New York', 'NY', 102862341, 'pparker@msn.com','s', NULL),
(HASHBYTES('SHA2_512', 'test4'), 'Jane', 'Thompson', 'f', '1978-05-08', '13563 Ocean View Drive', 'Seattle', 'WA', 132084409, 'Jthompson@gmail.com','s', NULL),
(HASHBYTES('SHA2_512', 'test5'), 'Debra', 'Steele', 'f', '1994-07-19', '543 Oak Ln', 'Milwaukee', 'WI', 286234178, 'dsteele@verizon.net', 's', NULL),
(HASHBYTES('SHA2_512', 'test6'), 'Tony', 'Stark', 'm', '1972-05-04', '332 Palm Avenue', 'Malibu', 'CA', 902638332, 'tstark@yahoo.com','c', NULL),
(HASHBYTES('SHA2_512', 'test7'), 'Hank', 'Pymi', 'm', '1980-08-28', '2355 Brown Street', 'Cleveland', 'OH', 822348890, 'hpym@aol.com','c', NULL),
(HASHBYTES('SHA2_512', 'test8'), 'Bob', 'Best', 'm', '1992-02-10', '4902 Avendale Avenue', 'Scottsdale', 'AZ', 872638332, 'bbest@yahoo.com', 'c', NULL),
(HASHBYTES('SHA2_512', 'test9'), 'Sandra', 'Dole', 'f', '1990-01-26', '87912 Lawrence Ave', 'Atlanta', 'GA', 672348890, 'sdole@gmail.com', 'c', NULL),
(HASHBYTES('SHA2_512', 'test10'), 'Ben', 'Avery', 'm', '1983-12-24', '6432 Thunderbird Ln', 'Sioux Falls', 'SD', 562638332, 'bavery@hotmail.com', 'c', NULL),
(HASHBYTES('SHA2_512', 'test11'), 'Arthur', 'Curry','m', '1975-12-15', '3304 Euclid Avenue', 'Miami', 'FL', 342219932, 'acurry@gmall.com','c', NULL),
(HASHBYTES('SHA2_512', 'test12'), 'Diana', 'Price', 'f', '1980-08-22', '944 Green Street', 'Las Vegas', 'NV', 332048823, 'price@symaptico.com', 'c', NULL),
(HASHBYTES('SHA2_512', 'test13'), 'Adam', 'Jurris', 'm', '1995-01-31', '98435 Valencia Dr.', 'Gulf Shores', 'AL', 870219932, 'ajurris@gmx.com', 'c', NULL),
(HASHBYTES('SHA2_512', 'test14'), 'Judy', 'Sleen', 'f', '1970-03-22', '56343 Rover Ct.', 'Billings', 'MT', 672048823, 'jsleen@symaptico.com','c', NULL),
(HASHBYTES('SHA2_512', 'test15'), 'Bill', 'Neider', 'm', '1982-06-13', '43567 Netherland Blvd', 'South Bend', 'IN', 320219932, 'bneiderheim@comcast.net', 'c', NULL);


INSERT INTO dbo.slsrep
(per_id, srp_yr_sales_goal, srp_ytd_sales, srp_ytd_comm, srp_notes)
VALUES
(1, 100000, 60000, 1800, NULL),
(2, 80000, 35000, 3500, NULL),
(3, 150000, 84000, 9650, 'Great salesperson!'),
(4, 125000, 87000, 15300, NULL),
(5, 98000, 43000, 8750, NULL);

INSERT INTO dbo.customer
(per_id, cus_balance, cus_total_sales, cus_notes)
VALUES
(6, 120, 14789, NULL),
(7, 98.46, 234.92, NULL),
(8, 0, 4578, 'Customer always pays on time.'),
(9, 981.73, 1672.38, 'High balance.'),
(10, 541.23, 782.57, NULL),
(11, 251.02, 13782.96, 'Good customer.'),
(12, 582.67, 963.12, 'Previously paid in full.'),
(13, 121.67, 1057.45, 'Recent customer.'),
(14, 765.43, 6789.42, 'Buys bulk quantities.'),
(15, 304.39, 456.81, 'Has not purchased recently.');

INSERT INTO dbo.contact
(per_sid, per_cid, cnt_date, cnt_notes)
VALUES
(1, 6, '1999-01-01', NULL),
(2, 6, '2001-09-29', NULL),
(3, 7, '2002-08-15', NULL),
(2, 7, '2002-09-01', NULL),
(4, 7, '2004-01-05', NULL),
(5, 8, '2004-02-28', NULL),
(4, 8, '2004-03-03', NULL),
(1, 9, '2004-04-07', NULL),
(5, 9, '2004-07-29', NULL),
(3, 11, '2005-05-02', NULL),
(4, 13, '2005-06-14', NULL),
(2, 15, '2005-07-02', NULL);


INSERT INTO dbo.[order]
(cnt_id, ord_placed_date, ord_filled_date, ord_notes)
VALUES
(1, '2010-11-23', '2010-12-24', NULL),
(2, '2005-03-19', '2005-07-28', NULL),
(3, '2011-07-01', '2011-07-06', NULL),
(4, '2009-12-24', '2010-01-05', NULL),
(5, '2008-09-21', '2008-11-26', NULL),
(6, '2009-04-17', '2009-04-30', NULL),
(7, '2010-05-31', '2010-06-07', NULL),
(8, '2007-09-02', '2007-09-16', NULL),
(9, '2011-12-08', '2011-12-23', NULL),
(10, '2012-02-29', '2012-05-02', NULL);

INSERT INTO region
(reg_name, reg_notes)
VALUES
('c', NULL),
('n', NULL),
('e', NULL),
('s', NULL),
('w', NULL);
GO

INSERT INTO state
(reg_id, ste_name, ste_notes)
VALUES
(1, 'MI', NULL),
(3, 'II', NULL),
(4, 'WA', NULL),
(5, 'FL', NULL),
(2, 'TX', NULL);
GO

INSERT INTO city
(ste_id, cty_name, cty_notes)
VALUES
(1, 'Detroit', NULL),
(2, 'Aspen', NULL),
(2, 'Chicago', NULL),
(3, 'Clover', NULL),
(4, 'St. Louis', NULL);
GO

INSERT INTO dbo.store
(cty_id, str_name, str_street, str_zip, str_phone, str_email, str_url, str_notes)
VALUES
(2, 'Walgreens','14567 Walnut Ln', 475315690, 3127658127, 'info@walgreens.com','http://www.walgreens.com',NULL),
(3, 'CVS', '572 Casper Rd', 505231519, 3128926534, 'help@cvs.com', 'http://www.cvs.com', 'Rumor of merger.'),
(4, 'Lowes', '81309 Catapult Ave', 802345671, 9017653421, 'sales@lowes.com', 'http://www.lowes.com', NULL),
(5, 'Walmart','14567 Walnut Ln', 387563628, 8722718923, 'Info@walmart.com','http://www.walmart.com',NULL),
(1, 'Dollar General', '47583 Davison Rd', 482983456, 3137583492, 'ask@dollargeneral.com', 'http://www.dollargerieral.com','recently sold property');
GO

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



INSERT INTO dbo.invoice
(ord_id, str_id, inv_date, inv_total, inv_paid, inv_notes)
VALUES
(5, 1, '2001-05-03', 100.00, 0, NULL),
(4, 1,'2006-11-11', 1100.00, 0, NULL),
(1, 1, '2010-09-16', 100.00, 0, NULL),
(3, 2, '2011-01-10', 100.00, 1, NULL),
(2, 3, '2008-06-24', 100.00, 1, NULL),
(6, 4, '2009-04-20', 100.00, 0, NULL),
(7, 5, '2010-06-05', 100.00, 0, NULL),
(8, 2, '2007-09-09', 100.00, 1, NULL),
(9, 3, '2011-12-17', 100.00, 1, NULL),
(10, 4, '2012-03-18', 100.00, 0, NULL);



INSERT INTO dbo.vendor
(ven_name, ven_street, ven_city, ven_state, ven_zip, ven_phone, ven_email, ven_url, ven_notes)
VALUES
('Sysco', '531 Dolphin Run', 'Orlano', 'FL', '344761234', '7641238543', 'sales@sysco.com', 'http://www.sysco.com',NULL),
('General Electric', '100 Happy Trails Dr.', 'Boston', 'MA', '123458743', '2134569641', 'support@ge.com', 'http://www.ge.com','Very good turnaround'),
('Cisco', '300 Cisco Dr.', 'Stanford', 'OR', '872315492', '7823456723', 'cisco@cisco.com', 'http://www.cisco.com',NULL),
('Goodyear', '100 Goodyear Dr.', 'Gary', 'IN', '485321956', '5784218427', 'sales@goodyear.com', 'http://www.goodyear.com', 'Competing well with Firestone.'),
('Snap-On', '42185 Magenta Ave', 'Lake Falls', 'ND', '387513649', '9197345632', 'support@snapon.com', 'http://www.snap-on.com', 'Good quality tools!');


INSERT INTO dbo.product
(ven_id, pro_name, pro_descript, pro_weight, pro_qoh, pro_cost, pro_price, pro_discount, pro_notes)
VALUES
(1, 'hammer','', 2.5, 45, 4.99, 7.99, 30, 'Discounted only when purchased with screwdriver set.'),
(2, 'screwdriver', '', 1.8, 120, 1.99, 3.49, NULL, NULL),
(4, 'pall', '16 Gallon', 2.8, 48, 3.89, 7.99, 40, NULL),
(5, 'cooking oil', 'Peanut oil', 15, 19, 19.99, 28.99, NULL, 'gallons'),
(3, 'frying pan', '', 3.5, 178, 8.45, 13.99, 50, 'Currently 1/2 price sale.');

INSERT INTO dbo.order_line
(ord_id, pro_id, oln_qty, oln_price, oln_notes)
VALUES
(1, 2, 10, 8.0, NULL),
(2, 3, 7, 9.88, NULL),
(3, 4, 3, 6.99, NULL),
(5, 1, 2, 12.76, NULL),
(4, 5, 13, 58.99, NULL);

INSERT INTO dbo.payment
(inv_id, pay_date, pay_amt, pay_notes)
VALUES
(5, '2008-07-01', 5.99, NULL),
(4, '2010-09-28', 4.99, NULL),
(1, '2008-07-23', 8.75, NULL),
(3, '2010-10-31', 19.55, NULL),
(2, '2011-03-29', 32.5, NULL),
(6, '2010-10-03', 20.00, NULL),
(8, '2008-08-09', 1000.00, NULL),
(9, '2009-01-10', 103.68, NULL),
(7, '2007-03-15', 25.00, NULL),
(10, '2007-05-12', 40.00, NULL),
(4, '2007-05-22', 9.33, NULL);

INSERT INTO dbo.product_hist
(pro_id, pht_date, pht_cost, pht_price, pht_discount, pht_notes)
VALUES
(1, '2005-01-02 11:53:34', 4.99, 7.99, 30, 'Discounted only when purchased with screwdriver set.'),
(2, '2005-02-03 09:13:56', 1.99, 3.49, NULL, NULL),
(3, '2005-03-04 23:21:49', 3.89, 7.99, 40, NULL),
(4, '2006-05-06 18:09:04', 19.99, 28.99, NULL, 'gallons'),
(5, '2006-05-07 15:07:29', 8.45, 13.99, 50, 'Currently 1/2 price sale.');


INSERT INTO dbo.srp_hist
(per_id, sht_type, sht_modified, sht_modifier, sht_date, sht_yr_sales_goal, sht_yr_total_sales, sht_yr_total_comm, sht_notes)
VALUES
(1, 'i', getDate(), SYSTEM_USER, getDate(), 100000, 110000, 11000, NULL),
(4, 'i', getDate(), SYSTEM_USER, getDate(), 150000, 175000, 17500, NULL),
(3, 'u', getDate(), SYSTEM_USER, getDate(), 200000, 185000, 18500, NULL),
(2, 'u', getDate(), ORIGINAL_LOGIN(), getDate(), 210000, 220000, 22000, NULL),
(5, 'i', getDate(), ORIGINAL_LOGIN(), getDate(), 225000, 230000, 2300, NULL);

insert into dbo.phone
(per_id, phn_num, phn_type,phn_notes)
values
(1,8508950394,'h', NULL),
(2,3849301923, 'c', NULL),
(3, 4832912345, 'c',NULL),
(4, 2839401923, 'h', NULL),
(5, 3910293845, 'c', NULL);

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
(1, 2, 3, 11, 10, 11.99, 119.9, NULL);
GO






INSERT INTO sale
(pro_id, str_id, cnt_id, tim_id, sal_qty, sal_price, sal_total, sal_notes)
VALUES
(1, 2, 3, 4, 20, 9.99, 199.8, NULL),
(2, 3, 4, 5, 5, 5.99, 29.95, NULL),
(3, 4, 5, 1, 30, 3.99, 119.7, NULL),
(4, 5, 1, 2, 15, 18.99, 284.85, NULL),
(5, 1, 2, 3, 6, 11.99, 71.94, NULL);

GO
