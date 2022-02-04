--A5 MS Sql server
--(not the same, but) similar to show warnings;
set ansi_warnings on;
go

use master;
go

--drop existing database if it exists
If exists (select name from maser.dbo.sysdatabases where name = N'sah16m')
Drop database sah16m;
GO

--create database if not exists

If not exists (select name from master.dbo.sysdatabases where name = N'sah16m')
Create database sah16m;
GO

use sah16m;
GO

-- -------------------
 --table dbo.applicant
 -- ------------------

 --drop if exists
 --N = string may be unicode
 -- U = only objecys that are tables
 --make sure to use dbo. before all table references

 If object_id (N'dbo.applicant',N'U') is not nill
 Drop table dbo.applicant;
 go

 create table dbo.applicant
   (
      app_id SMALLINT not null (1,1),
      app_ssn int not null check (app_ssn >0 and app_ssn <= 999999999),
      app_state_id varchar(45) not null,
      app_fname varchar(15) not null,
      app_lname varchar(30) not null,
      app_street varchar(30) not null,
      app_city varchar(30) not null,
      app_state char(2) not null default 'FL',
      app_zip int not null check (app_zip >0 and app_zip <= 9999999999),
      app_email varchar(100) null,
      app_dob DATE not null,
      app_gender char(1) not null check( app_gender in('m', 'f')),
      app_bckgd_check char(1) not null check (app_bckgd_check in ('y','n')),
      app_notes varchar(45) null,
      Primary key (app_id),

      -- make sure ssn and id is unique
      constraint ux_app_ssn unique nonclusted (app_ssn ASC),
      constraint ux_app_state_id unique nonclusted (app_state_id ASC)
   );

   --non clusted by default
