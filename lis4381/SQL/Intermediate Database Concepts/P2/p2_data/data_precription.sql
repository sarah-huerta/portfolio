-- -------------------- --
-- prescription data --
-- -------------------- --

insert into dbo.prescription
  (pat_id, med_id, pre_date, pre_dosage, pre_num_refills, pre_notes)

  values
  (1, 2, '2020-01-01', 'take as needed', '1', null),
  (2, 4, '2020-02-02', 'take on per day', '2', null),
  (3, 1, '2020-03-03', 'take one in AM', '1', null),
  (4, 3, '2020-04-04', 'take on in PM', '2', null),
  (5, 5, '2020-05-05', 'take with food', '1', null);

  
