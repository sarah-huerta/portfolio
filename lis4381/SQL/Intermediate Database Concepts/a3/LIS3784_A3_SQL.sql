--i. List the members' first and last names, book ISBNs and titles, loan and due dates, and authors' first and last names sorted in descending order of due dates.


# mem_fname, mem_lname, bok_isbn, lon_loan_date, lon_due_date, aut_fname, aut_lname
Clint, Soall, 1234567890345, 2021-02-05, 2021-05-27, Trixy, Simo
Cornie, Wibrew, 1234567890123, 2020-07-31, 2021-04-11, Innis, Tarver
Avis, Lawless, 1234567890567, 2021-01-24, 2021-01-13, Erny, Mewrcik
Wilhelm, McPhilemy, 1234567890901, 2020-04-22, 2020-10-04, Berkly, Girardy
Nickey, Toppes, 1234567890789, 2020-03-23, 2020-07-06, Rachelle, Wooderson


# mem_fname, mem_lname, lon_loan_date, lon_due_date, aut_fname, aut_lname
Clint, Soall, 2021-02-05, 2021-05-27, Trixy, Simo
Cornie, Wibrew, 2020-07-31, 2021-04-11, Innis, Tarver
Avis, Lawless, 2021-01-24, 2021-01-13, Erny, Mewrcik
Wilhelm, McPhilemy, 2020-04-22, 2020-10-04, Berkly, Girardy
Nickey, Toppes, 2020-03-23, 2020-07-06, Rachelle, Wooderson

--old style join

select mem_fname, mem_lname, b.bok_isbn, lon_loan_date, lon_due_date, aut_fname, aut_lname
from member m, loaner l, book b, attribution at, author a
where m.mem_id= l.mem_id
and l.bok_isbn = b.bok_isbn
and b.bok_isbn = at.bok_isbn
and at.aut_id = a.aut_id
order by lon_due_date desc;

-- join on
select mem_fname, mem_lname, b.bok_isbn, lon_loan_date, lon_due_date, aut_fname, aut_lname
from member m
join loaner l on m.mem_id = l.mem_id
join book b on l.bok_isbn = b.bok_isbn
join attribution at on b.bok_isbn = at.bok_isbn
join author a on at.aut_id = a.aut_id
order by lon_due_date desc;

-- join Using

select mem_fname, mem_lname, lon_loan_date, lon_due_date, aut_fname, aut_lname
from member
join loaner using (mem_id)
join book using (bok_isbn)
join attribution using (bok_isbn)
join author using (aut_id)
order by lon_due_date desc;

-- natural join

select mem_fname, mem_lname, lon_loan_date, lon_due_date, aut_fname, aut_lname
from member
natural join loaner
natural join book
natural join attribution
natural join author
order by lon_due_date desc;


--ii. List an unstored derived attribute called "book sale price," that displays the current price, which is marked down 15% from the original book price (format the number to two decimal places, and include a dollar sign).

# bok_price, bok_price *.85, format(bok_price * .85,2)
564.40, 479.7400, 479.74
717.69, 610.0365, 610.04
62.60, 53.2100, 53.21
333.50, 283.4750, 283.48
325.13, 276.3605, 276.36

# book_sale_price
$479.74
$610.04
$53.21
$283.48
$276.36


select bok_price, bok_price *.85, format(bok_price * .85,2)
from book


select concat ('$', format(bok_price*.85,2)) as book_sale_price
from book;



--iii. Create a stored derived attribute based upon the calculation above for the second book in the book table, and place the results in member #3's notes attribute.

# mem_id, mem_fname, mem_lname, mem_street, mem_city, mem_state, mem_zip, mem_phone, mem_email, mem_notes
1, Cornie, Wibrew, 09 Bellgrove Center, Saint Louis, MO, 192837465, 3143498462, cwibrew0@spotify.com,
2, Clint, Soall, 38911 Garrison Trail, Brooklyn, NY, 584930285, 7186134950, csoall1@vistaprint.com,
3, Avis, Lawless, 974 Arkansas Alley, Salt Lake City, UT, 185948375, 8011745778, alawless2@army.mil, this member is great
4, Nickey, Toppes, 29119 Shelley Circle, Columbia, MO, 284574893, 5735580972, ntoppes3@marriott.com,
5, Wilhelm, McPhilemy, 8638 Petterle Street, Evansville, IN, 574823958, 8124616338, wmcphilemy4@slate.com,

# mem_id, mem_fname, mem_lname, mem_street, mem_city, mem_state, mem_zip, mem_phone, mem_email, mem_notes
1, Cornie, Wibrew, 09 Bellgrove Center, Saint Louis, MO, 192837465, 3143498462, cwibrew0@spotify.com,
2, Clint, Soall, 38911 Garrison Trail, Brooklyn, NY, 584930285, 7186134950, csoall1@vistaprint.com,
3, Avis, Lawless, 974 Arkansas Alley, Salt Lake City, UT, 185948375, 8011745778, alawless2@army.mil, Purchased book at discounted price  $610.04
4, Nickey, Toppes, 29119 Shelley Circle, Columbia, MO, 284574893, 5735580972, ntoppes3@marriott.com,
5, Wilhelm, McPhilemy, 8638 Petterle Street, Evansville, IN, 574823958, 8124616338, wmcphilemy4@slate.com,

select * from member;

select bok_price, bok_price*.85
from book
where bok_isbn = '1234567890345';

select concat( 'Purchased book at discounted price', '$', format(bok_price*.85,2))
from book
where bok_isbn = '1234567890345';

select * from member;

update member
  set mem_notes =
  (
    select concat( 'Purchased book at discounted price', '$', format(bok_price*.85,2))
    from book
    where bok_isbn = '1234567890345'
  )
  where mem_id = 3;

/*iv. Using only SQL, add a test table inside of your database with the following attribute definitions (use prefix tst_ for each attribute), all should be not null except email, and notes:
id pk int unsigned AUTO INCREMENT, fname varchar(15),
lname varchar(30),
street varchar(30),
city varchar(20),
state char(2),
zip int unsigned,
phone bigint unsigned COMMENT 'otherwise, cannot make contact', email varchar(45) DEFAULT NULL,
notes varchar(255) DEFAULT NULL,
ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_general_ci*/

# Tables_in_sah16m
attribution
author
book
book_cat
category
loaner
member
publisher

# Tables_in_sah16m
attribution
author
book
book_cat
category
loaner
member
publisher
test


show tables;
drop table if not exists test
create table if not exists test
  (
tst_id pk int unsigned AUTO_INCREMENT,
tst_fname varchar(15),
tst_lname varchar(30),
tst_street varchar(30),
tst_city varchar(20),
tst_state char(2) NOT NULL DEFAULT 'FL',
tst_zip int unsigned,
tst_phone bigint unsigned COMMENT 'otherwise, cannot make contact',
tst_email varchar(45) DEFAULT NULL,
tst_notes varchar(255) DEFAULT NULL,
PRIMARY KEY (tst_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;


--v. Insert data into test table from member table

# tst_id, tst_fname, tst_lname, tst_street, tst_city, tst_state, tst_zip, tst_phone, tst_email, tst_notes
1, Cornie, Wibrew, 09 Bellgrove Center, Saint Louis, MO, 192837465, 3143498462, cwibrew0@spotify.com,
2, Clint, Soall, 38911 Garrison Trail, Brooklyn, NY, 584930285, 7186134950, csoall1@vistaprint.com,
3, Avis, Lawless, 974 Arkansas Alley, Salt Lake City, UT, 185948375, 8011745778, alawless2@army.mil, Purchased book at discounted price  $610.04
4, Nickey, Toppes, 29119 Shelley Circle, Columbia, MO, 284574893, 5735580972, ntoppes3@marriott.com,
5, Wilhelm, McPhilemy, 8638 Petterle Street, Evansville, IN, 574823958, 8124616338, wmcphilemy4@slate.com,


insert into test
  (tst_id, tst_fname, tst_lname, tst_street,tst_city, tst_state, tst_zip, tst_phone, tst_email, tst_notes)
  select mem_id, mem_fname, mem_lname, mem_street, mem_city, mem_state, mem_zip, mem_phone, mem_email, mem_notes
  from member;


--vi. Alter the last name attribute in test table to the following options: tst_last varchar(35) not null, default 'Doe' and comment "testing"

# Field, Type, Null, Key, Default, Extra
tst_id, int unsigned, NO, PRI, , auto_increment
tst_fname, varchar(15), YES, , ,
tst_lname, varchar(30), YES, , ,
tst_street, varchar(30), YES, , ,
tst_city, varchar(20), YES, , ,
tst_state, char(2), NO, , FL,
tst_zip, int unsigned, YES, , ,
tst_phone, bigint unsigned, YES, , ,
tst_email, varchar(45), YES, , ,
tst_notes, varchar(255), YES, , ,

# Field, Type, Collation, Null, Key, Default, Extra, Privileges, Comment
tst_id, int unsigned, , NO, PRI, , auto_increment, select,insert,update,references,
tst_fname, varchar(15), utf8_general_ci, YES, , , , select,insert,update,references,
tst_last, varchar(35), utf8_general_ci, NO, , Doe, , select,insert,update,references, testing
tst_street, varchar(30), utf8_general_ci, YES, , , , select,insert,update,references,
tst_city, varchar(20), utf8_general_ci, YES, , , , select,insert,update,references,
tst_state, char(2), utf8_general_ci, NO, , FL, , select,insert,update,references,
tst_zip, int unsigned, , YES, , , , select,insert,update,references,
tst_phone, bigint unsigned, , YES, , , , select,insert,update,references, otherwise, cannot make contact
tst_email, varchar(45), utf8_general_ci, YES, , , , select,insert,update,references,
tst_notes, varchar(255), utf8_general_ci, YES, , , , select,insert,update,references,


show create table test;
show full columns from test;

describe test;
ALTER TABLE test change tst_lname tst_last varchar(35) not null DEFAULT 'Doe' COMMENT 'testing';

show create table test;
show full columns from test;
