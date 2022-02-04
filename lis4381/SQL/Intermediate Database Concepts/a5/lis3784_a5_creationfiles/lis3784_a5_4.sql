-- phone table --
if object_id(N'dbo.phone', N'U') is not null
drop table dbo.phone;

create table dbo.phone
  (
    phn_id smallint not null identity(1,1),
    app_id smallint null,
    ocp_id smallint null,
    phn_num bigint not null check (phn_num >0 and phn_num <= 9999999999),
    phn_type char(1) not null check (phn_type in('c','h','w','f')),
    phn_notes varchar(255) null,
    primary key(phn_id),

    constraint ux_app_id_phn_num unique nonclustered (app_id ASC, phn_num ASC),

    constraint ux_ocp_id_phn_num unique nonclustered (ocp_id ASC, phn_num ASC),

    constraint fk_phone_applicant
    foreign key (app_id)
    references dbo.applicant(app_id)
    on delete cascade
    on update cascade,

    -- ocp id is no action bc it has multuple paths in applicant if applicant is deleted, so will ohone as well as the occupant.
    constraint fk_phone_occupant
    foreign key (ocp_id)
    references dbo.occupant (ocp_id)
    on delete no action
    on update no action
  );

  -- room type table --
  if object_id(N'dbo.room_type', N'U') is not null
  drop table dbo.room_type;

  create table dbo.room_type
  (
    rtp_id tinyint not null identity(1,1),
    rtp_name varchar(45) not null,
    rtp_notes varchar(255) null,
    primary key(rtp_id)
  );
