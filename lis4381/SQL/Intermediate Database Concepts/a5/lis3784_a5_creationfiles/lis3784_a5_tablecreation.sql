--A5 MS Sql server
--(not the same, but) similar to show warnings;
set ansi_warnings on;
go

use master;
go

--drop existing database if it exists
If exists (select name from master.dbo.sysdatabases where name = N'sah16m')
Drop database sah16m;
GO

--create database if not exists

If not exists (select name from master.dbo.sysdatabases where name = N'sah16m')
Create database sah16m;
GO

use sah16m;
GO

-- feature table
if object_id (N'dbo.feature',N'U') is not null
drop table dbo.feature;
create table dbo.feature
  (
    ftr_id tinyint not null identity(1,1),
    ftr_type varchar(45) not null,
    ftr_notes varchar(255) null,
    primary key (ftr_id)
  );

-- property table --
if object_id (N'dbo.property', N'U') is not null
drop table dbo.property;

create table dbo.property
  (
    prp_id smallint not null identity(1,1),
    prp_street varchar(30) not null,
    prp_city varchar(30) not null,
    prp_state char(2) not null default 'fl',
    prp_zip int not null check(prp_zip > 0 and prp_zip <= 999999999),
    prp_type varchar(15) not null check(prp_type in('house', 'condo', 'townhouse', 'duplex', 'apt', 'mobile home', 'room')),
    prp_rental_rate decimal(7,2) not null check(prp_rental_rate >0),
    prp_status char(1) not null check(prp_status in('a', 'u')),
    prp_notes varchar(255) null,
    Primary key (prp_id)
    );

-- room type table --
  if object_id(N'dbo.room_type', N'U') is not null
  drop table dbo.room_type;
  create table dbo.room_type
    (
      rtp_id tinyint not null identity(1,1),
      rtp_name varchar(45) not null,
      rtp_notes varchar(255) null,
      primary key(rtp_id)
    );

-- room table --
if object_id (N'dbo.room',N'U') is not null
drop table dbo.room;
create table dbo.room
  (
    rom_id smallint not null identity(1,1),
    prp_id smallint not null,
    rtp_id tinyint not null,
    rom_size varchar (45) not null,
    rom_notes varchar(255) null,
    primary key (rom_id),

    --can have dupe rooms in same prop
    -- make sure prp and rtp id is unx
    constraint ux_prp_id_rtp_id unique nonclustered (prp_id ASC, rtp_id ASC),

    constraint fk_room_property
    foreign key (prp_id)
    references dbo.property (prp_id)
    on delete cascade
    on update cascade,

    constraint fk_room_roomtype
    foreign key (rtp_id)
    references dbo.room_type (rtp_id)
    on delete cascade
    on update cascade
  );

-- property feature table --
if object_id (N'dbo.prop_feature',N'U') is not null
drop table dbo.prop_feature;
create table dbo.prop_feature
  (
    pft_id smallint not null identity(1,1),
    prp_id smallint not null,
    ftr_id tinyint not null,
    pft_notes varchar(255) null,
    primary key (pft_id),
    --unique combo for  prp and ftr id
    constraint ux_prp_id_ftr_id unique nonclustered (prp_id ASC, ftr_id ASC),
    constraint fk_prop_feat_property
    foreign key (prp_id)
    references dbo.property(prp_id)
    on delete cascade
    on update cascade
  );

-- applicant table --
If object_id (N'dbo.applicant',N'U') is not null
Drop table dbo.applicant;
go
create table dbo.applicant
  (
    app_id SMALLINT not null identity(1,1),
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
    Primary key(app_id),

    --make sure ssn and id is unique
    constraint ux_app_ssn unique nonclustered(app_ssn ASC),
    constraint ux_app_state_id unique nonclustered (app_state_id ASC)
  );

-- agreement table --
if object_id (N'dbo.agreement', N'U') is not null
drop table dbo.agreement;
create table dbo.agreement
  (
    agr_id smallint not null identity(1,1),
    prp_id smallint not null,
    app_id smallint not null,
    agr_signed date not null,
    agr_start date not null,
    agr_end date not null,
    agr_amt decimal (7,2) not null check (agr_amt >0),
    agr_notes varchar(255) null,
    Primary key (agr_id),
    --unique combos
    constraint ux_prp_id_app_id_agr_signed unique nonclustered (prp_id ASC, app_id ASC, agr_signed ASC),
    constraint fk_agreement_property
    foreign key (prp_id)
    references dbo.property (prp_id)
    on delete cascade
    on update cascade,

    constraint fk_agreement_applicant
    foreign key (app_id)
    references dbo.applicant (app_id)
    on delete cascade
    on update cascade
  );

-- occupant table --
if object_id (N'dbo.occupant', N'U') is not null
drop table dbo.occupant;
create table dbo.occupant
  (
   ocp_id smallint not null identity(1,1),
    app_id smallint not null,
    ocp_ssn int not null check(ocp_ssn > 0 and ocp_ssn <= 999999999),
    ocp_state_id varchar(45) null,
    ocp_fname varchar(15) not null,
    ocp_lname varchar(30) not null,
    ocp_email varchar(100) null,
    ocp_dob DATE not null,
    ocp_gender char(1) not null check(ocp_gender in('m','f')),
    ocp_bckgd_check char(1) not null check(ocp_bckgd_check in('y','n')),
    ocp_notes varchar(255) null,
    primary key (ocp_id),

    constraint ux_ocp_ssn unique nonclustered (ocp_ssn ASC),
    constraint ux_ocp_state_id unique nonclustered (ocp_state_id ASC),

    constraint fk_occupant_applicant
    foreign key (app_id)
    references dbo.applicant (app_id)
    on delete cascade
    on update cascade
  );

-- phone table --
if object_id(N'dbo.phone', N'U') is not null
drop table dbo.phone;
create table dbo.phone
  (
    phn_id smallint not null identity(1,1),
    app_id smallint null,
    ocp_id smallint null,
    phn_num bigint not null check (phn_num >0 and phn_num <= 9999999999),
    phn_type char(1) not null check (phn_type in('c','h','w','f')),
    phn_notes varchar(255) null,
    primary key(phn_id),

    constraint ux_app_id_phn_num unique nonclustered (app_id ASC, phn_num ASC),

    constraint ux_ocp_id_phn_num unique nonclustered (ocp_id ASC, phn_num ASC),

    constraint fk_phone_applicant
    foreign key (app_id)
    references dbo.applicant(app_id)
    on delete cascade
    on update cascade,

    -- ocp id is no action bc it has multuple paths in applicant if applicant is deleted, so will ohone as well as the occupant.
    constraint fk_phone_occupant
    foreign key (ocp_id)
    references dbo.occupant (ocp_id)
    on delete no action
    on update no action
  );
