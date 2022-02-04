-- P2 a --
use sah16m;
go

begin transaction;

select pat_fname, pat_lname, pat_notes, med_name, med_price, med_shelf_life, pre_dosage, pre_num_refills
  from medication m
  join prescription pr on pr.med_id = m.med_id
  join patient p on pr.pat_id = p.pat_id
  order by med_price desc;
  commit;


-- p2 b --
use sah16m;
go

if object_id (N'dbo.v_physician_patient_treatments', N'V') is not null
drop view dbo.v_physician_patient_treatments;
go

create view dbo.v_physician_patient_treatments as
  select phy_fname, phy_lname, trt_name, trt_price, ptr_results, ptr_date, ptr_start, ptr_end
  from physician p, patient_treatment pt, treatment t
  where p.phy_id = pt.phy_id
  and pt.trt_id = t.trt_id;

go

select * from dbo.v_physician_patient_treatments order by trt_price desc;
go

select * from information_schema.tables;
go

select view_definition
from information_schema.views;
go


-- p2 c --

use sah16m;

select * from dbo.v_physician_patient_treatments;

if object_id('AddRecord') is not null
  drop procedure AddRecord
  go

create procedure AddRecord as
  insert into dbo.patient_treatment
  (pat_id, phy_id, trt_id, ptr_date, ptr_end, ptr_results, ptr_notes)
  values
  (5,5,5, '2013-04-23', '11:10:10', '12:30:00', 'released','ok');

select * from dbo.v_physician_patient_treatments;
go

Exec AddRecord;

select * from dbo.v_physician_patient_treatments;

drop procedure AddRecord;


-- p2 d --

begin transaction;

select * from dbo.administration_lu;
delete from dbo.administration_lu where pre_id = 5 and ptr_id = 10;
select * from dbo.administration_lu;

commit;

use sah16m;

if object_id('dbo.updatepatient') is not null
drop procedure dbo.updatepatient;
go

create procedure dbo.updatepatient as

select * from dbo.patient;

update dbo.patient
set pat_lname = 'vanderbilt'
where pat_id = 3;

select * from dbo.patient;
go

exec dbo.updatepatient;
go

drop procedure dbo.updatepatient;
go


-- p2 f --

exec sp_help 'dbo.patient_treatment';

alter table dbo.patient_treatment add ptr_prognsis varchar(255) null default 'testing';

exec sp_help 'dbo.patient_treatment';


-- p2 ec --

use sah16m;

if object_id('dbo.AddShowRecords') is not null
drop procedure dbo.AddShowRecords;
go

create procedure dbo.AddShowRecords as

  select * from dbo.patient;

  insert into dbo.patient
  (pat_ssn, pat_fname, pat_lname, pat_street, pat_city, pat_state, pat_zip, pat_phone, pat_email, pat_dob, pat_gender, pat_notes)
  values
  (756889432, 'john', 'doe', '123 main st', 'tallahassee', 'fl', '32304', '8507863241', 'jdoe@fsu.edu', '1999-05-10', 'M', 'testing notes');

  select * from dbo.patient;

  select phy_fname, phy_lname, pat_fname, pat_lname, trt_name, ptr_start, ptr_end, ptr_date
    from dbo.patient p
    join dbo.patient_treatment pt on p.pat_id = pt.pat_id
    join dbo.physician pn on pn.phy_id = pt.phy_id
    join dbo.treatment t on t.trt_id = pt.trt_id
  order by ptr_date desc;
go

exec dbo.AddShowRecords;
go

drop procedure dbo.AddShowRecords;
