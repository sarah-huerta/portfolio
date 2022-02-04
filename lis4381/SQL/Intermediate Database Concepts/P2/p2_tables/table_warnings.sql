-- -------------------- --
-- Warnings --
-- -------------------- --

set ansi_warnings on;
go

use master;
go

if exists(select name from master.dbo.sysdatabases where name = N'sah16m')
drop database sah16m;
go

if not exists (select name from master.dbo.sysdatabases where name = N'sah16m')
create database sah16m;
go
