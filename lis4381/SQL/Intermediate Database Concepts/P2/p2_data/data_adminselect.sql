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

exec sp_msforeachtable "Alter table ? with check check constraint all"


select * from dbo.patient;
select * from dbo.medication;
select * from dbo.prescription;
select * from dbo.physcian;
select * from dbo.treatment;
select * from dbo.patient_treatment;
select * from dbo.administration_lu;
