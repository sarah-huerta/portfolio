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
