-- ------------
-- room table
-- ------------
if object_id (N'dbo.room',N'U') is not null
drop table dbo.room;

create table dbo.room
  (
    rom_id smallint not null identity(1,1),
    prp_id smallint not null,
    rtp_id tinyint not null,
    rom_size varchar (45) not null,
    rom_notes varchar(255) null,
    primary key (rom_id),

  -- can have dupe rooms in same prop
  -- make sure prp and rtp id is unx
  constraint ux_prp_id_rtp_id unique nonclustered (prp_id ASC, rtp_id ASC),

  constraint fk_room_property
  foreign key (prp_id)
  references dbo.property (prp_id)
  on delete cascade
  on update cascade,

  constraint fk_room_roomtype
  foreign key (rtp_id)
  references dbo.room_type (rtp_id)
  on delete cascade
  on update cascade
);

--show tables
Select * from information_schema.tables;

--disable contraints (do this *after* table creattion but before inserts)

EXEC sp_msforeachtabe "Alter table ? NOCHECK constraint all"
