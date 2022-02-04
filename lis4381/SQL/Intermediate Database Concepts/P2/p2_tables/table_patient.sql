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
