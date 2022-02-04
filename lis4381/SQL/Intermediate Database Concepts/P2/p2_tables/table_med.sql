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
