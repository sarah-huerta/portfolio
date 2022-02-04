-- -------------------- --
-- patient data --
-- -------------------- --

insert into dbo.patient (pat_ssn, pat_fname, pat_lname, pat_street, pat_city, pat_state, pat_zip, pat_phone, pat_email, pat_dob, pat_gender, pat_notes)

  values
  ('123456789', 'Abby', 'Beta', '123 A st', 'Tallahassee', 'FL', '323041234',9876543210 , 'ab@gmail.com', '05-01-1960', 'F', Null),
  ('234567890', 'Betty', 'Cameron', '456 B st', 'Panama City', 'FL', '323052345',8765432109 , 'bc@gmail.com', '05-01-1965', 'F', Null),
  ('345678901', 'Carol', 'Dawes', '789 C st', 'Pensacola', 'FL', '323063456', 7654321098, 'cd@gmail.com', '05-01-1970', 'F', Null),
  ('456789012', 'Debby', 'Elon', '246 D st', 'Jacksonville', 'FL', '323074567', 6543210987, 'de@gmail.com', '05-01-1975', 'F', Null),
  ('567890123', 'Elly', 'Frank', '357 E st', 'Bristol', 'FL', '323085678',5432109876 , 'ef@gmail.com', '05-01-1980', 'F', Null);
