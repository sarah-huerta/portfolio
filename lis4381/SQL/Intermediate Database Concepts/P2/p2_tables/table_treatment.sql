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
