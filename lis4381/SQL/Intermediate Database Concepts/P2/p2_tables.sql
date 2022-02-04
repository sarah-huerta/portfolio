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
