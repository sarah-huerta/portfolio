-- -------------------- --
-- Warnings --
-- -------------------- --

set ansi_warnings on;
go

use master;
go

if exists(select name from master.dbo.sysdatabases where name = N'sah16m')
drop database sah16m;
go

if not exists (select name from master.dbo.sysdatabases where name = N'sah16m')
create database sah16m;
go

use sah16m;

-- -------------------- --
-- med table --
-- -------------------- --
if object_id (N'dbo.medication', N'U') is not null
drop table dbo.medication;

create table dbo.medication
(
  med_id smallint not null identity(1,1),
  med_name varchar(100) not null,
  med_price decimal(5,2) not null check (med_price >0),
  med_shelf_life date not null,
  med_notes varchar(255) null,
  primary key (med_id)
);

-- -------------------- --
-- patient table --
-- -------------------- --
if object_id (N'dbo.patient', N'U') is not null
drop table dbo.patient;
go

create table dbo.patient
(
 pat_id smallint not null identity(1,1),
 pat_ssn int not null check (pat_ssn > 0 and pat_ssn <= 999999999),
 pat_fname varchar(15) not null,
 pat_lname varchar(30) not null,
 pat_street varchar(30) not null,
 pat_city varchar(30) not null,
 pat_state char(2) not null default 'FL',
 pat_zip int not null check(pat_zip > 0 and pat_zip <= 999999999),
 pat_phone bigint not null check(pat_phone > 0 and pat_phone <= 9999999999),
 pat_email varchar(100) null,
 pat_dob date not null,
 pat_gender char(1) not null check(pat_gender in('m','f')),
 pat_notes varchar(255) null,
 primary key (pat_id),
 constraint ux_pat_ssn unique nonclustered (pat_ssn ASC)
);

-- ------------------- --
-- physician table --
-- ------------------- --
if object_id (N'dbo.physician', N'U') is not null
drop table dbo.physician;
go

create table dbo.physician
(
  phy_id smallint not null identity(1,1),
  phy_specialty varchar(25) not null,
  phy_fname varchar(15) not null,
  phy_lname varchar(30) not null,
  phy_street varchar(30) not null,
  phy_city varchar(30) not null,
  phy_state char(2) not null default 'fl',
  phy_zip int not null check (phy_zip > 0 and phy_zip <= 999999999),
  phy_phone bigint not null check(phy_phone > 0 and phy_phone <= 9999999999),
  phy_fax bigint not null check(phy_fax > 0 and phy_fax <= 9999999999),
  phy_email varchar(100) null,
  phy_url varchar(100) not null,
  phy_notes varchar(255) null,
  primary key (phy_id),
);

-- -------------------- --
-- treatment table --
-- -------------------- --
if object_id (N'dbo.treatment', N'U') is not null
drop table dbo.treatment;

create table dbo.treatment
(
  trt_id smallint not null identity(1,1),
  trt_name varchar(255) not null,
  trt_price decimal(8,2) not null check (trt_price > 0),
  trt_notes varchar(255) null,
  primary key (trt_id)
);


-- ------------------- --
-- prescription table --
-- ------------------- --
if object_id (N'dbo.prescription', N'U') is not null
drop table dbo.prescription;

create table dbo.prescription
(
  pre_id smallint not null identity(1,1),
  pat_id smallint not null,
  med_id smallint not null,
  pre_date date not null,
  pre_dosage varchar(255) not null,
  pre_num_refills varchar(3) not null,
  pre_notes varchar(255) null,
  primary key (pre_id),

  constraint ux_pat_id_med_id_pre_date unique nonclustered
  (pat_id asc, med_id asc, pre_date asc),

  constraint fk_prescription_patient
  foreign key (pat_id)
  references dbo.patient (pat_id)
  on delete no action
  on update cascade,

  constraint fk_prescription_medication
  foreign key (med_id)
  references dbo.medication (med_id)
  on delete no action
  on update cascade
);

-- -------------------- --
-- patient treatment table --
-- -------------------- --
if object_id(N'dbo.patient_treatment', N'U') is not null
drop table dbo.patient_treatment;

create table dbo.patient_treatment
(
 ptr_id smallint not null identity(1,1),
 pat_id smallint not null,
 phy_id smallint not null,
 trt_id smallint not null,
 ptr_date date not null,
 ptr_start time(0) not null,
 ptr_end time(0) not null,
 ptr_results varchar(255) null,
 ptr_notes varchar(255) null,
 primary key (ptr_id),

 constraint ux_pat_id_phy_id_trt_id_ptr_date unique nonclustered
 (pat_id asc, phy_id asc, trt_id asc, ptr_date asc),

 constraint fk_patient_treatment_patient
 foreign key (pat_id)
 references dbo.patient (pat_id)
 on delete no action
 on update cascade,

 constraint fk_patient_treatment_physician
 foreign key (phy_id)
 references dbo.physician (phy_id)
 on delete no action
 on update cascade,

 constraint fk_patient_treatment_treatment
 foreign key (trt_id)
 references dbo.treatment (trt_id)
 on delete no action
 on update cascade
);

-- -------------------- --
-- admin table --
-- -------------------- --
if object_id (N'dbo.administration_lu', N'U') is not null
drop table dbo.administration_lu;

Create table dbo.administration_lu
(
  pre_id smallint not null,
  ptr_id smallint not null,
  primary key (pre_id, ptr_id),

  constraint fk_administration_lu_prescription
  foreign key (pre_id)
  references dbo.prescription (pre_id)
  on delete no action
  on update cascade,

  constraint fk_administration_lu_patient_treatment
  foreign key (ptr_id)
  references dbo.patient_treatment (ptr_id)
  on delete no action
  on update no action

);


-- ------------------------------------ --
select * from information_schema.tables;

exec sp_msforeachtable "alter table ? nocheck constraint all"


-- -------------------- --
-- meds data --
-- -------------------- --
insert into dbo.medication
  (med_name, med_price, med_shelf_life, med_notes)

  values
  ('Abilify', 30.00, '01-01-2020', NULL ),
  ('Adderall', 50.00, '02-02-2020', NULL ),
  ('Lamictal', 9.00, '03-03-2020', NULL ),
  ('Lithium', 150.00, '04-04-2020', NULL ),
  ('Zoloft', 3.00, '05-05-2020', NULL );

-- -------------------- --
-- patient data --
-- -------------------- --
insert into dbo.patient
  (pat_ssn, pat_fname, pat_lname, pat_street, pat_city, pat_state, pat_zip, pat_phone, pat_email, pat_dob, pat_gender, pat_notes)
  values
  ('123456789', 'Abby', 'Beta', '123 A st', 'Tallahassee', 'FL', '323041234',9876543210 , 'ab@gmail.com', '05-01-1960', 'F', NULL),
  ('234567890', 'Betty', 'Cameron', '456 B st', 'Panama City', 'FL', '323052345',8765432109 , 'bc@gmail.com', '05-01-1965', 'F', NULL),
  ('345678901', 'Carol', 'Dawes', '789 C st', 'Pensacola', 'FL', '323063456', 7654321098, 'cd@gmail.com', '05-01-1970', 'F', NULL),
  ('456789012', 'Debby', 'Elon', '246 D st', 'Jacksonville', 'FL', '323074567', 6543210987, 'de@gmail.com', '05-01-1975', 'F', NULL),
  ('567890123', 'Elly', 'Frank', '357 E st', 'Bristol', 'FL', '323085678',5432109876 , 'ef@gmail.com', '05-01-1980', 'F', NULL);

-- -------------------- --
-- physican data --
-- -------------------- --
insert into dbo.physician
  (phy_specialty, phy_fname, phy_lname, phy_street, phy_city, phy_state, phy_zip, phy_phone, phy_fax,  phy_email, phy_url, phy_notes)
  values
  ('cardiology', 'anthony', 'adams', '111 a dr', 'callaway', 'FL','321091234', '1357901357', '1324354657', 'aa@gmail.com', 'cardio.com', NULL),
  ('gynecology', 'brian', 'burns', '222 b dr', 'lynn haven', 'FL','210982345', '2468024680', '2435465768', 'bb@gmail.com', 'gyno.com', NULL),
  ('neurology', 'carlos', 'conroy', '333 c dr', 'midtown', 'FL','109873456', '3579012345', '3546576879', 'cc@gmail.com', 'neuro.com', NULL),
  ('dermatology', 'dave', 'delmar', '444 d dr', 'bradfordville', 'FL','987654567', '4680123456', '4657687980', 'dd@gmail.com', 'dermo.com', NULL),
  ('radiology', 'ethan', 'entwistle', '555 e dr', 'tallahassee', 'FL','876545678', '9876543219', '6879809123', 'ee@gmail.com', 'radio.com', NULL);

-- -------------------- --
-- treatment data --
-- -------------------- --
insert into dbo.treatment
  (trt_name, trt_price, trt_notes)
  values
  ('skin graft', 9000.00, NULL),
  ('polyp removal', 8000.00, NULL),
  ('heart removal', 7000.00, NULL),
  ('face lift', 6000.00, NULL),
  ('brain surgery', 5000.00, NULL);

-- -------------------- --
-- prescription data --
-- -------------------- --
insert into dbo.prescription
  (pat_id, med_id, pre_date, pre_dosage, pre_num_refills, pre_notes)
  values
  (1, 2, '2020-01-01', 'take as needed', '1', NULL),
  (2, 4, '2020-02-02', 'take on per day', '2', NULL),
  (3, 1, '2020-03-03', 'take one in AM', '1', NULL),
  (4, 3, '2020-04-04', 'take on in PM', '2', NULL),
  (5, 5, '2020-05-05', 'take with food', '1', NULL);

-- -------------------- --
-- patient treatment data --
-- -------------------- --
insert into dbo.patient_treatment
  (pat_id, phy_id, trt_id, ptr_date, ptr_start, ptr_end, ptr_results, ptr_notes)
  values
  (2, 1, 5, '2012-12-13', '01:01:01', '07:01:01', 'success' ,NULL),
  (4, 2, 4, '2014-12-14', '02:01:01', '08:01:01', 'complication' ,NULL),
  (1, 3, 3, '2016-12-15', '03:01:01', '09:01:01', 'success' ,NULL),
  (3, 4, 2, '2018-12-16', '04:01:01', '10:01:01', 'complication' ,NULL),
  (5, 5, 1, '2020-12-17', '05:01:01', '11:01:01', 'success' ,NULL);

-- -------------------- --
-- admin data --
-- -------------------- --
insert into dbo.administration_lu
  (pre_id, ptr_id)
  values
  (1,2),
  (3,4),
  (5,1),
  (2,3),
  (4,5);

-- -------------------------- --
  exec sp_msforeachtable "Alter table ? with check check constraint all"
  select * from dbo.patient;
  select * from dbo.medication;
  select * from dbo.prescription;
  select * from dbo.physician;
  select * from dbo.treatment;
  select * from dbo.patient_treatment;
  select * from dbo.administration_lu;
