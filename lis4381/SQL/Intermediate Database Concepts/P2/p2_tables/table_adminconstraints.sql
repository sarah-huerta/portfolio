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

select * from information_schema.tables;

exec sp_msforeachtable "alter table ? nocheck constraint all"
