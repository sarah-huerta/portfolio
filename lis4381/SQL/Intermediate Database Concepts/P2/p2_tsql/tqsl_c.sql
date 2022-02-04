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
