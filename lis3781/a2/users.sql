Create user if not exists 'user1'@'localhost' Identified by 'test1';
Create user if not exists 'user2'@'localhost' Identified by 'test2';

grant select, update, delete
  on sah16m.* to user1@"localhost";
  show warnings;

grant select, insert
  on sah16m.customer
  to user2@"localhost";
  show warnings;

  show grants for user1@localhost;
  show grants for user2@localhost;


select * from company;
