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
