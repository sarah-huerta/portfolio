-- start d ---

use sah16m;
go

if object_id('dbo.applicantInfo') is not null
drop procedure dbo.applicantInfo;
go

--in MS sql, we do not have to change the delim.
create procedure dbo.applicantInfo(@appid INT) AS
--old style
  select app_ssn, app_state_id, app_fname, app_lname, phn_num, phn_type
  from applicant a, phone p
  where a.app_id = p.app_state_id
  and a.app_id = @appid;
  GO

/*join on
  select app_ssn, app_state_id, app_fname, app_lname, phn_num, phn_type
  from applicant a
  join on phone p on a.app_id and p.app_state_id
  and a.app_id = @appid;
  */

  exec abo.applicantInfo 3;
  --or--
  declare @myVar int = 2
  exec dbo.applicantInfo @myVar;

  go
  drop procedure dbo.applicantInfo;
  go

  -- end d --
