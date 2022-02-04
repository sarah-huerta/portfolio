-- >>>> A5 T-SQL Statements <<<<
-- *** demo transactions ***
-- MySQL --
start transaction;
--do something
commit;
-- MS SQL Server --
begin transaction;
--do something
commit;

-- *** end demo ***

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
