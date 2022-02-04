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

    constraint fk_prop_feat_feature
    foreign key (ftr_id)
    references dbo.feature(ftr_id)
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



  -- data creation --


--feature data--
insert into dbo.feature
  (ftr_type, ftr_notes)
  values
  ('central A/C', Null),
  ('Pool', Null),
  ('Close to school', Null),
  ('furnished', Null),
  ('cable', Null),
  ('washer/dryer', Null),
  ('refrigerator', Null),
  ('microwave', Null),
  ('oven', Null),
  ('1-car garage', Null),
  ('2-car garage', Null),
  ('sprinkler system', Null),
  ('security', Null),
  ('wi-fi', Null),
  ('storage', Null),
  ('fireplace', Null);


-- data for property--
insert into dbo.property
  (prp_street, prp_city, prp_state, prp_zip, prp_type, prp_rental_rate, prp_status, prp_notes)
  values
  ('123 lakewoord circle' ,'bristol' ,'FL' ,'123456789', 'house', 1800.00, 'u', Null),
  ('234 brevard st' ,'tallahassee' ,'FL' ,'345678901', 'apt', 641.00, 'u', Null),
  ('345 academic way' ,'panama city' ,'FL' ,'567890123', 'condo', 2400.00, 'a', Null),
  ('456 tharpe st' ,'jacksonville' ,'FL' ,'789012345', 'townhouse', 1942.99, 'a', Null),
  ('567 tennesee st' ,'pensacola' ,'FL' , '901234567', 'apt', 610.00, 'u', Null);

--property feature data --
insert into dbo.prop_feature
  (prp_id, ftr_id, pft_notes)
  values
  (1, 4, NULL),
  (2, 5, NULL),
  (3, 3, NULL),
  (4, 2, NULL),
  (5, 1, NULL),
  (1, 1, NULL),
  (1, 5, NULL);

-- room type data --
insert into dbo.room_type
  (rtp_name, rtp_notes)
  values
  ('bed', Null),
  ('bath', Null),
  ('kitchen', Null),
  ('lanai', Null),
  ('dining', Null),
  ('living', Null),
  ('basement', Null),
  ('office', Null);

-- room data--
insert into dbo.room
  (prp_id, rtp_id, rom_size, rom_notes)
  values
  (1, 1, ' "10" x "10" ', Null),
  (3, 2, ' "20" x "15" ', Null),
  (4, 3, ' "8" x "8" ', Null),
  (5, 4, ' "50" x "50" ', Null),
  (2, 5, ' "30" x "30" ', Null);


--applicant data --
insert into dbo.applicant
  (app_ssn, app_state_id, app_fname, app_lname, app_street, app_city, app_state, app_zip, app_email, app_dob, app_gender, app_bckgd_check, app_notes)
  values
  ('234567890','A123B456C789','Amy','Frank','098 thomasville rd','tallahassee','FL','135791234','af@gmail.com','1999-01-01','F','n', null),
  ('456789012','D012E345F678','Baily','Gonezo','765 monkey lane','miami','FL','246801234','bg@gmail.com','1998-02-02','F','n', null),
  ('678901234','G901H234I567','Cami','Huerta','432 seminole lane','crawfordville','FL','357011234','ch@gmail.com','1997-03-03','F','y', null),
  ('890123456','J890K123L456','Doug','Igly','109 target circle','lynn haven','FL','468021234','di@gmail.com','1996-04-04','M','y', null),
  ('123456789','M789N012P333','Eve','Jumper','876 money dr','springfield','FL','570131234','ej@gmail.com','1995-05-05','F','y', null);

  -- agreement data --
  insert into dbo.agreement
    (prp_id, app_id, agr_signed, agr_start, agr_end, agr_amt, agr_notes)
    values
    (3, 4, '2009-03-31', '2010-01-31', '2011-12-31', 100.00, Null),
    (1, 1, '2010-03-30', '2011-01-30', '2012-12-30', 200.00, Null),
    (4, 2, '2011-03-29', '2012-01-29', '2013-12-29', 300.00, Null),
    (5, 3, '2012-03-28', '2013-01-28', '2014-12-28', 400.00, Null),
    (2, 5, '2013-03-27', '2014-01-27', '2015-12-27', 500.00, Null);

-- occupant data --
insert into dbo.occupant
  (app_id,ocp_ssn, ocp_state_id, ocp_fname, ocp_lname, ocp_email, ocp_dob, ocp_gender, ocp_bckgd_check, ocp_notes)
  values
  (1, '987654321', 'z123y456x789', 'abby', 'adams', 'aa@gmail.com', '1990-03-01', 'F', 'y', null),
  (1, '876543210', 'w234v567u890', 'brian', 'bonston', 'bb@gmail.com', '1989-04-02', 'M', 'y', null),
  (2, '765432109', 't345s678r901', 'crystal', 'collins', 'cc@gmail.com', '1988-05-05', 'F', 'y', null),
  (2, '654321098', 'q456p789o012', 'david', 'dawson', 'dd@gmail.com', '1987-06-06', 'M', 'n', null),
  (5, '543210987', 'n567m890l123', 'ellie', 'evans', 'ee@gmail.com', '1986-07-07', 'F', 'n', null);

-- phone data --
insert into dbo.phone
  (app_id, ocp_id, phn_num, phn_type, phn_notes)
  values
  (1, Null, '9753109753', 'H', Null),
  (2, Null, '8642086420', 'F', Null),
  (5, 5, '7531097531', 'H', Null),
  (Null,1, '6420864208', 'C', 'occupant"s only number'),
  (null, 1, '5310975310', 'W', Null),
  (null, 3, '4208642086', 'W', Null),
  (4, Null, '3109753109', 'W', Null),
  (3, 2, '2086420864',  'W', Null),
  (3, 4, '1097531097', 'C', Null),
  (3,1, '1234567890', 'C', Null);

--enable constraints --
exec sp_msforeachtable "Alter table ? with check check constraint all"

--show all data
select * from dbo.feature;
select * from dbo.prop_feature;
select * from dbo.room_type;
select * from dbo.room;
select * from dbo.property;
select * from dbo.applicant;
select * from dbo.agreement;
select * from dbo.occupant;
select * from dbo.phone;
