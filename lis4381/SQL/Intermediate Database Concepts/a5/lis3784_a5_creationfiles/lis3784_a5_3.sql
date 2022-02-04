-- -------------
-- feature table
-- -------------
if object_id (N'dbo.feature',N'U') is not null
drop table dbo.feature;

create table dbo.feature
  (
    ftr_id tinyint not null identity(1,1),
    ftr_type varchar(45) not null,
    ftr_notes varchar(255) null,
    primary key (ftr_id)
  );

-- ----------------
-- property feature
-- ----------------

if object_id (N'dbo.prop_feature',N'U') is not null
drop table dbo.prop_feature;

create table dbo.prop_feature
  (
    pft_id smallint not null identity(1,1),
    prp_id smallint not null,
    ftr_id tinyint not null,
    pft_notes varchar(255) null,
    primary key (pft_id),

    --unique combo for  prp and ftr id
    constraint ux_prp_id_ftr_id unique nonclustered (prp_id ASC, ftr ASC),

    constraint fk_prop_feat_property
    foreign key (prp_id)
    references dbo.property (prp_id)
    on delete cascade
    on update cascade
  );

-- ---------------
-- occupant table
-- ---------------
if object_id (N'dbo.occupant',N'U') is not null
drop table dbo.occupant;

create table dbo.occupant
  (
    ocp_id
    app_id
    ocp_ssn
    ocp_state_id
    ocp_fname
    ocp_lname
    ocp_email
    ocp_dob
    ocp_gender
    ocp_bckgd_check
    ocp_notes
    primary key (ocp_id),

    constraint ux_ocp_ssn unique nonclustered (ocp_ssn ASC),
    constraint ux_ocp_state_id unique nonclustered (ocp_state_id ASC),

    constraint fk_occupant_applicant
    foreign key (app_id)
    references dbo.applicant (app_id)
    on delete cascade
    on update cascade
  );
