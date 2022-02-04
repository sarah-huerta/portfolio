-- ---------------
-- proptery table
-- ---------------

if object_id (N'dbo.proptery', N'U') is not null
drop table dbo.proptery;

create table dbo.proptery
  (
    prp_id smallint not null identity(1,1),
    prp_street varchar(30) not null,
    prp_city varchar(30) not null,
    prp_state char(2) not null default 'fl',
    prp_zip int not null check(prp_zip > 0 and prp_zip <= 999999999),
    prp_type varchar(15) not null check(prp_type in('house', 'condo', 'townhouse', 'duplex', 'apt', 'mobile home', 'room')),
    prp_rental_rate decimal(7,2) not null check(prp_rental_rate >0),
    prp_status char(1) not null check(prp_status in('a', 'u')),
    prp_notes varchar(255) null,
    Primary key (prp_id)
  );

  -- ----------------
  -- agreement table
  -- ----------------
  if object_id (N'dbo.agreement', N'U') is not null
  drop table dbo.agreement;

  create table dbo.agreement
  (
    agr_id smallint not null identity(1,1),
    prp_id smallint not null,
    app_id smallint not null,
    agr_signed date not null,
    agr_start date not null,
    agr_end date not null,
    agr_amt decimal (7,2) not null check (agr_amt >0),
    agr_notes varchar(255) null,
    Primary key (agr_id)

    --unique combos
    constraint ux_prp_id_app_id_agr_signed unique nonclustered (prp_id ASC, app_id ASC, agr_signed ASC),

    constraint fk_agreement_property
    foreign key (prp_id)
    references dbo.proptery (prp_id)
    on delete cascade
    on update cascade,

    constraint fk_agreement_applicant
    foreign key (app_id)
    references dbo.applicant (app_id)
    on delete cascade
    on update cascade
  );
