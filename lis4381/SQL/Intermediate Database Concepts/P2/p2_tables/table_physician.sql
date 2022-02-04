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
phy_notes varchar(255) not null,
primary key (phy_id),
);
