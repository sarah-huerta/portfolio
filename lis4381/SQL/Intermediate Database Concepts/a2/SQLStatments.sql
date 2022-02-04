/* Sarah Huerta
LIS3784 Summer 2021, Online
Assignment 2
Due 06/03/2021*/




--1) List all faculty members’ first and last names, full addresses, salaries, and hire dates.
1, Jana, Ramirez, 8405 Nisl Rd., Pocatello, ID, 27271.46, 2019-10-07
2, Kylan, Snider, P.O. Box 583, 2147 Est, Av., Racine, WI, 37591.79, 2019-07-10
3, Aurora, Kirby, 939-4206 Turpis Ave, Birmingham, AL, 20201.89, 2019-05-08
4, Gannon, Medina, 384-3154 Tellus. St., Fort Collins, CO, 92006.05, 2017-07-17
5, Patricia, Luna, 5810 Eget Rd., South Portland, ME, 15299.30, 2017-08-12

--old style join
select p.per_id, per_fname,per_lname, per_street, per_city, per_state, emp_salary, fac_start_date
from person as p, employee as e, faculty as f
where p.per_id =e.per_id
and e.per_id =f.per_id;


--join on
select p.per_id, per_fname, per_lname, per_street, per_city, per_state, emp_salary, fac_start_date
from person p
join employee e on p.per_id = e.per_id
join faculty f on e.per_id = f.per_id;

--join using
select p.per_id, per_fname, per_lname, per_street, per_city, per_state, emp_salary, fac_start_date
from person
join employee using (per_id)
join faculty using (per_id);

--natural join
select p.per_id, per_fname, per_lname, per_street, per_city, per_state, emp_salary, fac_start_date
from person
natural join  employee
natural join faculty;


--2)List the first 10 alumni’s names, genders, date of births, degree types, areas, and dates.
11, Xander, Church, m, 1957-03-13, M.S., Finances, 2013-02-15
12, Ori, Frederick, f, 1968-03-28, B.A., Media Relations, 2013-11-09
13, Connor, Bond, m, 1996-03-25, M.A., Computer Science, 2020-10-12
14, Tanisha, Gordon, f, 1977-10-17, M.S., Media Relations, 2018-09-21
15, Cade, Velez, m, 1981-04-19, B.S., Media Relations, 2014-07-02
16, Dominique, Alston, m, 1973-01-25, B.S., Finances, 2012-01-10
17, Maryam, Kirby, m, 1976-07-01, B.A., Humanities, 2016-10-18
18, Darryl, Barr, m, 1988-04-14, B.S., Advertising, 2019-05-13
19, Justina, Hughes, m, 1991-11-08, B.A., Computer Science, 2018-10-30
20, Phyllis, Hull, m, 1980-08-10, B.A., Computer Science, 2020-05-28

--old style join
select p.per_id, per_fname, per_lname, per_gender, per_dob, deg_type, deg_area. deg_date
from person p, alumnus a, degree d
where p.per_id =a.per_id and a.per_id = d.per_id
limit 0, 10;

--join on
select p.per_id, per_fname, per_lname, per_gender, per_dob, deg_type, deg_area. deg_date
from person p
join alumnus a on p.per_id = a.per_id
join degree d on a.per_id = d.per_id
limit 0,10;

--join using
select per_id, per_fname, per_lname, per_gender, per_dob, deg_type, deg_area. deg_date
from person
join alumnus using(per_id)
join degree using(per_id)
limit 0,10;

--natural join
select per_id, per_fname, per_lname, per_gender, per_dob, deg_type, deg_area, deg_date
from person
natural join alumnus
natural join degree
limit 0,10;


--3)List the last 20 undergraduate names, majors, tests, scores, and standings
25, Galena, Mccray, Accounting, act, 16, so
24, Sydney, Ford, Finances, sat, 609, sr
23, Bernard, Travis, Marketing, sat, 907, fr
22, Justine, Hamilton, Marketing, sat, 1200, fr
21, Ainsley, Macdonald, Media Relations, act, 8, jr

--old style join
select p.per_id, per_fname, per_lname, stu_major, ugd_test, ugd_score, ugd_standing
from person p, student s, undergrad u
where p.per_id =s.per_id and s.per_id = u.per_id
order by per_id desc
limit 0,20;

--join on
select p.per_id, per_fname, per_lname, stu_major, ugd_test, ugd_score, ugd_standing
from person p
join student s on p.per_id = s.per_id
join undergrad u on s.per_id = u.per_id
order by per_id desc
limity 0,20;

--join using
select per_id, per_fname, per_lname, stu_major, ugd_test, ugd_score, ugd_standing
from person
join student using (per_id)
join undergrad using (per_id)
order by per_id desc
limit 0,20;

--natural join
select per_id, per_fname, per_lname, stu_major, ugd_test, ugd_score, ugd_standing
from person
natural join student
natural join undergrad
order by per_id desc
limit 0,20;

--4)Remove the first 10 staff members; after which, display the remaining staff members’ names and positions.
6, Finances, 2020-08-18, 2020-11-09, et ipsum cursus
7, Legal, 2019-12-09, 2020-12-09, iaculis quis, pede. Praesent
8, Payroll, 2016-02-04, 2021-02-04, non arcu.
9, Finances, 2019-05-08, 2020-08-21, nulla ante,
10, Social Media, 2019-10-18, 2020-10-18, in lobortis tellus


select * from staff;

delete from staff
order by per_id limit 10;


--5)Increase one graduate student’s test score (only one score) by 10%. Display the before and after values to verify that it was updated
26, lsat, 96, 2020-10-31, 2021-05-13, quis, pede.
27, gmat, 130, 2019-03-18, 2021-04-30, nec urna
28, gre, 500, 2016-02-22, 2020-06-14, Sed pharetra, felis eget
29, lsat, 173, 2020-01-17, 2021-03-21, tellus lorem
30, gre, 485, 2018-02-26, 2020-01-31, adipiscing lobortis risus.

26, lsat, 96, 2020-10-31, 2021-05-13, quis, pede.
27, gmat, 130, 2019-03-18, 2021-04-30, nec urna
28, gre, 550, 2016-02-22, 2020-06-14, Sed pharetra, felis eget
29, lsat, 173, 2020-01-17, 2021-03-21, tellus lorem
30, gre, 485, 2018-02-26, 2020-01-31, adipiscing lobortis risus.

select * from grad;

update grad
set grd_score = grd_score *1.10
where per_id = 28 and grd_test = 'gre';

--6)Add two new alumni, using only one SQL statement (*both*, including, *and*  NOT including attributes). Then, verify that two records have been added.
11, Quisque imperdiet, erat nonummy ultricies
12, blandit at, nisi. Cum sociis
13, ultrices posuere cubilia Curae;
14, elementum, lorem ut
15, feugiat. Lorem ipsum dolor
16, turpis egestas. Fusce aliquet
17, metus facilisis
18, bibendum sed, est. Nunc laoreet
19, sed
20, scelerisque neque. Nullam nisl. Maecenas

11, Quisque imperdiet, erat nonummy ultricies
12, blandit at, nisi. Cum sociis
13, ultrices posuere cubilia Curae;
14, elementum, lorem ut
15, feugiat. Lorem ipsum dolor
16, turpis egestas. Fusce aliquet
17, metus facilisis
18, bibendum sed, est. Nunc laoreet
19, sed
20, scelerisque neque. Nullam nisl. Maecenas
97, test1
98, test2
99, test1
100, test2


select * from alumnus;

insert into alumnus
(per_id, alm_notes)
values
(97, "test1"), (98, "test2");


insert into alumnus
values
(99, "test1"), (100, "test2");
