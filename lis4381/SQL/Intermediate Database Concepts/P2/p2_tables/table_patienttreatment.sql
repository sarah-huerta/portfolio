-- -------------------- --
-- patient treatment table --
-- -------------------- --

if object_id(N'dbo.patient_treatment', N'U') is not null
drop table dbo.patient_treatment;

create table dbo.patient_treatment
(
 ptr_id smallint not null identity(1,1),
 pat_id smallint not null,
 phy_id smallint not null,
 trt_id smallint not null,
 ptr_date date not null,
 ptr_start time(0) not null,
 ptr_end time(0) not null,
 ptr_results varchar(255) null,
 ptr_notes varchar(255) null,
 primary key (ptr_id),

 constraint ux_pat_id_phy_id_trt_id_ptr_date unique nonclustered
 (pat_id asc, phy_id asc, trt_id asc, ptr_date asc),

 constraint fk_patient_treatment_patient
 foreign key (pat_id)
 references dbo.patient (pat_id)
 on delete no action
 on update cascade,

 constraint fk_patient_treatment_physician
 foreign key (phy_id)
 references dbo.physician (phy_id)
 on delete no action
 on update cascade,

 constraint fk_patient_treatment_treatment
 foreign key (trt_id)
 references dbo.treatment (trt_id)
 on delete no action
 on update cascade
);
