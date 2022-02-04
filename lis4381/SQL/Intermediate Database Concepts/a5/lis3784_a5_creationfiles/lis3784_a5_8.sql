-- occupant data --

insert into dbo.occupant
  (app_id,ocp_ssn, ocp_state_id, ocp_fname, ocp_lname, ocp_email, ocp_dob, ocp_gender, ocp_bckgd_check, ocp_notes)

  values
(1, '987654321', 'z123y456x789', 'abby', 'adams', 'aa@gmail.com', '1990-03-01', 'F', 'y', null),
(1, '876543210', 'w234v567u890', 'brian', 'bonston', 'bb@gmail.com', '1989-04-02', 'M', 'y', null),
(2, '765432109', 't345s678r901', 'crystal', 'collins', 'cc@gmail.com', '1988-05-05', 'F', 'y', null),
(2, '654321098', 'q456p789o012', 'david', 'dawson', 'dd@gmail.com', '1987-06-06', 'M', 'n', null),
(5, '543210987', 'n567m890l123', 'ellie', 'evans', 'ee@gmail.com', '1986-07-07', 'F', 'n', null);

-- phone data --
insert into dbo.phone
  (app_id, ocp_id, phn_num, phn_type, phn_notes)
(1, Null, '9753109753', 'H', Null),
(2, Null, '8642086420', 'F', Null),
(5, 5, '7531097531', 'H', Null),
(Null,1, '6420864208', 'C', 'occupant"s only number'),
(null, 1, '5310975310', 'W', Null),
(null, 3, '4208642086', 'W', Null),
(4, Null, '3109753109', 'W', Null),
(3, 2, '2086420864',  'W', Null),
(3, 4, '1097531097', 'C', Null),
(3,1, '1234567890', 'C', Null);

--enable constraints --

exec sp_msforeachtable "Alter table ? with check check constraint all"

--show all data
select * from dbo.feature;
select * from dbo.prop_feature;
select * from dbo.room_type;
select * from dbo.room;
select * from dbo.property;
select * from dbo.applicant;
select * from dbo.agreement;
select * from dbo.occupant;
select * from dbo.phone;
