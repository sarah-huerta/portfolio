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
