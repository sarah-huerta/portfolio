-- p2 d --

begin transaction;

select * from dbo.adminstration_lu;
delete from dbo.adminstration_lu where pre_id = 5 and ptr_id = 10;
select * from dbo.adminstration_lu;

commit;
