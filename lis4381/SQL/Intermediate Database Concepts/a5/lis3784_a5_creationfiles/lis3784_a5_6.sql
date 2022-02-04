-- data for feature table--
insert into dbo.feature
  (ftr_type, ftr_notes)

  values
('central A/C', Null),
('Pool', Null),
('Close to school', Null),
('furnished', Null),
('cable', Null),
('washer/dryer', Null),
('refrigerator', Null),
('microwave', Null),
('oven', Null),
('1-car garage', Null),
('2-car garage', Null),
('sprinkler system', Null),
('security', Null),
('wi-fi', Null),
('storage', Null),
('fireplace', Null);

--data for room type --
insert into dbo.room_type
  (rtp_name, rtp_notes)
  values
('bed', Null),
('bath', Null),
('kitchen', Null),
('lanai', Null),
('dining', Null),
('living', Null),
('basement', Null),
('office', Null);

-- data for property feature --
insert into dbo.prop_feature
  (prp_id, ftr_id, pft_notes)
  values
(1, 4, NULL),
(2, 5, NULL),
(3, 3, NULL),
(4, 2, NULL),
(5, 1, NULL),
(1, 1, NULL),
(1, 5, NULL);
