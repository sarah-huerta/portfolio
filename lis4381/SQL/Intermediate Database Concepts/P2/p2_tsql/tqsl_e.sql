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
