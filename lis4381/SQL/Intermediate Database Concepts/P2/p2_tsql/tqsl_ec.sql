-- p2 ec --

use sah16m;

if object_id('dbo.AddShowRecords') is not null
drop procdure dbo.AddShowRecords;
go

create procdure dbo.AddShowRecords as

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

drop procdure dbo.AddShowRecords;
