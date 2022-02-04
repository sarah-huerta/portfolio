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
