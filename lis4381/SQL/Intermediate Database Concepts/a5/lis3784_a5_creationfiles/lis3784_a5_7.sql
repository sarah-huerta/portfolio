-- data for room --

insert into dbo.room
  (prp_id, rtp_id, rom_size, rom_notes)
  values
(1, 1, ' "10" x "10" ', Null),
(3, 2, ' "20" x "15" ', Null),
(4, 3, ' "8" x "8" ', Null),
(5, 4, ' "50" x "50" ', Null),
(2, 5, ' "30" x "30" ', Null);

-- data for property--
insert into dbo.property
  (prp_street, prp_city, prp_state, prp_zip, prp_type, prp_renta_rate, prp_status, prp_notes)
  values
('123 lakewoord circle' ,'bristol' ,'FL' ,'123456789', 'house', 1800.00, 'u', Null),
('234 brevard st' ,'tallahassee' ,'FL' ,'345678901', 'apt', 641.00, 'u', Null),
('345 academic way' ,'panama city' ,'FL' ,'567890123', 'condo', 2400.00, 'a', Null),
('456 tharpe st' ,'jacksonville' ,'FL' ,'789012345', 'townhouse', 1942.99, 'a', Null),
('567 tennesee st' ,'pensacola' ,'FL' , '901234567', 'apt', 610.00, 'u', Null);


  --applicant data --
insert into dbo.applicant
(app_ssn, app_state_id, app_fname, app_lname, app_street, app_city, app_state, app_zip, app_email, app_dob, app_gender, app_bckgd_check, app_notes)
values

('234567890','A123B456C789','Amy','Frank','098 thomasville rd','tallahassee','FL','135791234','af@gmail.com','1999-01-01','F','n', null),
('456789012','D012E345F678','Baily','Gonezo','765 monkey lane','miami','FL','246801234','bg@gmail.com','1998-02-02','F','n', null),
('678901234','G901H234I567','Cami','Huerta','432 seminole lane','crawfordville','FL','357011234','ch@gmail.com','1997-03-03','F','y', null),
('890123456','J890K123L456','Doug','Igly','109 target circle','lynn haven','FL','468021234','di@gmail.com','1996-04-04','M','y', null),
('123456789','M789N012P333','Eve','Jumper','876 money dr','springfield','FL','570131234','ej@gmail.com','1995-05-05','F','y', null);



-- agreement data --

insert into dbo.agreement
  (prp_id, app_id, agr_signed, agr_start, agr_end, agr_amt, agr_notes)
  values
  (3, 4, '2010-03-31', '2010-01-31', '2011-12-31', 100.00, Null),
  (1, 1, '2011-03-30', '2011-01-30', '2012-12-30', 200.00, Null),
  (4, 2, '2012-03-29', '2012-01-29', '2013-12-29', 300.00, Null),
  (5, 3, '2013-03-28', '2013-01-28', '2014-12-28', 400.00, Null),
  (2, 5, '2014-03-27', '2014-01-27', '2015-12-27', 500.00, Null);
