-- -------------------- --
-- patient treatment data --
-- -------------------- --
insert into dbo.patient_treatment (ptr_id, pat_id, phy_id, trt_id, ptr_date, ptr_start, ptr_end, ptr_results, ptr_notes)

  values
  (2, 1, 5, '2012-12-13', '01:01:01', '07:01:01', 'success' ,null),
  (4, 2, 4, '2014-12-14', '02:01:01', '08:01:01', 'complication' ,null),
  (1, 3, 3, '2016-12-15', '03:01:01', '09:01:01', 'success' ,null),
  (3, 4, 2, '2018-12-16', '04:01:01', '10:01:01', 'complication' ,null),
  (5, 5, 1, '2020-12-17', '05:01:01', '11:01:01', 'success' ,null);
