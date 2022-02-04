-- ******************************** --
-- start a --

use sah16m;
go
begin transaction;
-- test before after
select * from dbo.property;
select * from dbo.prop_feature;
select * from dbo.room;
select * from dbo.aggrement;

delete from dbo.property
  where prp_id = 1;

  select * from dbo.property;
  select * from dbo.prop_feature;
  select * from dbo.room;
  select * from dbo.aggrement;

commit;
--end a ---
-- ******************************** --
-- answer b --
use sah16m;
go

if object_id (N'dbo.v_prop_info', N'V') is not null
drop view dbo.v_prop_info;
go

create view dbo.v_prop_info as
  select p.prp_id, prp_type, prp_rental_rate, rtp_name,rom_size
  from property p
    join room r on p.prp_id = r.prp_id
    join room_type r on p.prp_id = r.prp_id
    join room_type rt on r.rtp_id = rt.rtp_id
  where p.prp_id = 3;

  /*
  old style join
  select p.prp_id, prp_type, prp_rental_rate, rtp_name,rom_size
  from property p, room r, room_type rt
  where
  p.prp_id = r.prp_id
  and r.rtp_id = rt.rtp_id
  and p.prp_id =3;
  */
go

select * from information_schema.tables;
go

--show view definition
select view_definition
from information_schema.views;
go
select * from dbo.v_prop_info;
go

-- end b --
-- ******************************** --
-- start c ---
use sah16m;
go
--1) using TOP and order by in views
if object_id (N'dbo.v_prop_info_feature', N'V') is not null
drop view dbo.v_prop_info_feature;
go

--join on
create view dbo.v_prop_info_feature as
  select p.prp_id, prp_type, prp_rental_rate, ftr_type
  from property p
  join prop_feature pf on p.prp_id = pf.prp_id
  join feature f on pf.ftr_id = f.ftr_id
  where p.prp_id >=4 and p.prp_id < 6;
go

--use order by outside of views
select * from dbo.v_prop_info_feature order by prp_rental_rate desc;
go

select * from information_schema.tables;
go

--show view definition
select view_definition
from information_schema.views;
go
select * from dbo.v_prop_info;
go

-- end c ---
-- ******************************** --
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
-- ******************************** --
  -- start e --
  use sah16m;
  go

  if object_id('dbo.occupantInfo') is not null
  drop proceduredbo.occupantInfo;
  go

  create procedure dbo.occupantInfo as
    --left outer
    select ocp_ssn, ocp_state_id, ocp_fname, ocp_lname, phn_num, phn_type
    from phone p
    left outer join occupant o on o.ocp_id = p.ocp_id;
    go
    /*or right outer join
    from occupant o
    right outer join phone p on o.ocp_id = p.ocp_id;
    */
    exec dbo.occupantInfo;

    go

    drop procedure dbo.occupantInfo;
    go

    -- end e
