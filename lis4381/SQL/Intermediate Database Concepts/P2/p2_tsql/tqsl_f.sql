-- p2 f --

exec sp_help 'dbo.patient_treatment';

alter table dbo.patient_treatment add ptr_prognsis varchar(255) null default 'testing';

exec sp_help 'dbo.patient_treatment';
