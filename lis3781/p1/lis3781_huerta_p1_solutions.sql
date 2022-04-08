
drop schema if exists sah16m;
create schema if not exists sah16m;
use sah16m;
-- --------------------------------------------------------------
-- Person
-- --------------------------------------------------------------
drop table if exists person;
create table if not exists person
  (
    per_id smallint unsigned not null auto_increment,
    per_ssn binary(64) null,
    per_salt binary(64) null,
    per_fname varchar(15) not null,
    per_lname varchar(30) not null,
    per_street varchar(30) not null,
    per_city varchar(30) not null,
    per_state char(2) not null,
    per_zip char(9) not null,
    per_email varchar(100) not null,
    per_dob date not null,
    per_type enum('a','c','j') not null,
    per_notes varchar(255) null default null,

    primary key(per_id),

    unique index ux_per_ssn (per_ssn ASC)

  )Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;

-- --------------------------------------------------------------------------------------------------------------------------------------
START TRANSACTION;
INSERT INTO person
(per_id, per_ssn, per_salt, per_fname, per_lname, per_street, per_city, per_state, per_zip, per_email, per_dob, per_type, per_notes)
VALUES
(NULL, NULL, NULL, 'Steve', 'Rogers', '437 Southern Drive', 'Rochester', 'NY', 324402222, 'rogers@comcast.net', '1923-10-03', 'C', NULL),
(NULL, NULL, NULL, 'Bruce', 'Wayne', '1007 Mountain Drive', 'Gotham', 'NY', 003208440, 'bwayne@knology.net', '1968-03-20', 'C', NULL),
(NULL, NULL, NULL, 'Peter', 'Parker', '20 Ingram Street', 'New York', 'NY', 102862341, 'pparker@msn.com', '1988-09-12', 'C', NULL),
(NULL, NULL, NULL, 'Jane', 'Thompson', '13563 Ocean View Drive', 'Seattle', 'WA', 032084409, 'jthompson@gmail.com', '1978-05-08', 'C', NULL),
(NULL, NULL, NULL, 'Debra', 'Steele', '543 Oak Ln', 'Milwaukee', 'WI', 286234178, 'dsteele@verizon.net', '1994-07-19', 'C', NULL),
(NULL, NULL, NULL, 'Tony', 'Stark', '332 Palm Avenue', 'Malibu', 'CA', 902638332, 'tstark@yahoo.com', '1972-05-04', 'a', NULL),
(NULL, NULL, NULL, 'Hank', 'Pymi', '2355 Brown Street', 'Cleveland', 'OH', 022348890, 'hpym@aol.com', '1980-08-28', 'a', NULL),
(NULL, NULL, NULL, 'Bob', 'Best', '4902 Avendale Avenue', 'Scottsdale', 'AZ', 872638332, 'bbest@yahoo.com', '1992-02-10', 'a', NULL),
(NULL, NULL, NULL, 'Sandra', 'Dole', '87912 Lawrence Ave', 'Atlanta', 'GA', 002348890, 'dole@gmail.com', '1990-01-26', 'a', NULL),
(NULL, NULL, NULL, 'Ben', 'Avery', '6432 Thunderbird Ln', 'Sioux Falls', 'SD', 562638332, 'bavery@hotmail.com', '1983-12-24', 'a', NULL),
(NULL, NULL, NULL, 'Arthur', 'Curry', '3304 Euclid Avenue', 'Miami', 'FL', 000219932, 'acurry@gmail.com', '1975-12-15', 'j', NULL),
(NULL, NULL, NULL, 'Diana', 'Price', '944 Green Street', 'Las Vegas', 'NV', 332048823, 'price@symaptico.com', '1980-08-22', 'j', NULL),
(NULL, NULL, NULL, 'Adam', 'Jurris', '98435 Valencia Dr.', 'Gulf Shores', 'AL', 870219932, 'ajurris@gmx.com', '1995-01-31', 'j', NULL),
(NULL, NULL, NULL, 'Judy', 'Sleen', '56343 Rover Ct.', 'Billings', 'MT', 672048823, 'jsleen@symaptico.com', '1970-03-22', 'j', NULL),
(NULL, NULL, NULL, 'Bill', 'Neiderheim', '43567 Netherland Blvd', 'South Bend', 'IN', 320219932, 'bneiderheim@comcast.net', '1982-03-13', 'j', NULL);
COMMIT;

-- --------------------------------------------------------------
-- attorney
-- --------------------------------------------------------------
drop table if exists attorney;
create table if not exists attorney
  (
    per_id smallint unsigned not null,
    aty_start_date date not null,
    aty_end_date date null default null,
    aty_hourly_rate DECIMAL(5,2) not null,
    aty_years_in_practice tinyint not null,
    aty_notes varchar(255) null default null,
    primary key(per_id),

    INDEX idx_per_id (per_id ASC),

    CONSTRAINT fk_attorney_person
    FOREIGN KEY (per_id)
    references person(per_id)
    on delete no action
    on update CASCADE
    ) Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;
-- --------------------------------------------------------------------------------------------------------------------------------------
START TRANSACTION;
INSERT INTO attorney
(per_id, aty_start_date, aty_end_date, aty_hourly_rate, aty_years_in_practice, aty_notes)
VALUES
(6, '2006-06-12', NULL, 85, 5, NULL),
(7, '2003-08-20', NULL, 130, 28, NULL),
(8, '2009-12-12', NULL, 70, 17, NULL),
(9, '2008-06-08', NULL, 78, 13, NULL),
(10, '2011-09-12', NULL, 60, 24, NULL);
COMMIT;


-- --------------------------------------------------------------
-- client
-- --------------------------------------------------------------
drop table if exists client;
create table if not exists client
  (
    per_id smallint unsigned not null,
    cli_notes varchar(255) null default null,
    primary key(per_id),

    index idx_per_id (per_id asc),

    CONSTRAINT fk_client_person
    FOREIGN KEY (per_id)
    references person(per_id)
    on delete no action
    on update CASCADE
  ) Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;
-- --------------------------------------------------------------------------------------------------------------------------------------

START TRANSACTION;
INSERT INTO client
(per_id, cli_notes)
VALUES
(1, NULL),
(2, NULL),
(3, NULL),
(4, NULL),
(5, NULL);
COMMIT;

-- --------------------------------------------------------------
-- court
-- --------------------------------------------------------------
drop table if exists court;
create table if not exists court
  (
    crt_id tinyint unsigned not null auto_increment,
    crt_name varchar(45) not null,
    crt_street varchar(30) not null,
    crt_city varchar(30) not null,
    crt_state char(2) not null,
    crt_zip char(9) not null,
    crt_phone bigint not null,
    crt_email varchar(100) not null,
    crt_url varchar(100) not null,
    crt_notes varchar(255) null,

    primary key(crt_id)

  ) Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;
-- --------------------------------------------------------------------------------------------------------------------------------------

START TRANSACTION;
INSERT INTO court
(crt_id, crt_name, crt_street, crt_city, crt_state, crt_zip, crt_phone, crt_email, crt_url, crt_notes)
VALUES
(NULL, 'leon county circuit court', '301 south monroe street', 'tallahassee', 'fl', 323035292, 8506065504, 'Iccc@us.fl.gov', 'http://www.leoncountycircultcourt.gov/', NULL),
(NULL, 'leon country traffic court', '1921 thomasville road', 'tallahassee', 'fl', 323035292, 8505774100, 'Ictc@us.fI.gov', 'http://www.leoncountytrafficcourt.gov/', NULL),
(NULL, 'florida supreme court', '500 south duval street', 'tallahassee', 'fl', 323035292, 8504880125, 'fsc@us.fl.gov', 'http://www.floridasupremecourt.org/', NULL),
(NULL, 'orange country courthouse', '424 north orange avenue', 'orlando', 'fl', 328012248, 4078362000, 'occ@us.fl.gov', 'http://www.ninthcircuit.org/', NULL),
(NULL, 'fifth district court of appeal', '300 south beach street', 'daytona beach', 'fl', 321158763, 3862258600, 'Sdca@us.fl.gov','http://www.5dca.org/' ,NULL);
COMMIT;
-- --------------------------------------------------------------
-- judge
-- --------------------------------------------------------------
drop table if exists judge;
create table if not exists judge
  (
    per_id smallint unsigned not null,
    crt_id tinyint unsigned null default null,
    jud_salary decimal(8,2) not null,
    jud_years_in_practice tinyint unsigned not null,
    jud_notes varchar(255) null default null,
    primary key (per_id),

    index idx_per_id (per_id asc),
    index idx_crt_id (crt_id asc),

    constraint fk_judge_person
    foreign key (per_id)
    references person(per_id)
    on delete no action
    on update cascade,

    constraint fk_judge_court
    foreign key (crt_id)
    references court(crt_id)
    on delete no action
    on update cascade

  )Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;
-- --------------------------------------------------------------------------------------------------------------------------------------
START TRANSACTION;
INSERT INTO judge
(per_id, crt_id, jud_salary, jud_years_in_practice, jud_notes)
VALUES
(11, 5, 150000, 10, NULL),
(12, 4, 185000, 3, NULL),
(13, 4, 135000, 2, NULL),
(14, 3, 170000, 6, NULL),
(15, 1, 120000, 1, NULL);
COMMIT;


-- --------------------------------------------------------------
-- judge history
-- --------------------------------------------------------------
drop table if exists judge_hist;
create table if not exists judge_hist
  (
    jhs_id smallint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    jhs_crt_id tinyint null,
    jhs_date timestamp not null default current_timestamp(),
    jhs_type enum('i','u','d') not null,
    jhs_salary decimal(8,2) not null,
    jhs_notes varchar(255) null,

    primary key (jhs_id),

    index idx_per_id (per_id asc),

    Constraint judge_hist_judge
    foreign key (per_id)
    references judge (per_id)
    on delete no action
    on update cascade
  )Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;
-- --------------------------------------------------------------------------------------------------------------------------------------
START TRANSACTION;
INSERT INTO judge_hist
(jhs_id, per_id, jhs_crt_id, jhs_date, jhs_type, jhs_salary, jhs_notes)
VALUES
(NULL, 11, 3, '2009-01-16', 'i', 130000, NULL),
(NULL, 15, 1, '2011-03-17', 'i', 120000, 'freshman justice'),
(NULL, 11, 5, '2010-07-05', 'i', 150000, 'assigned to another court'),
(NULL, 12, 4, '2012-10-08', 'i', 165000, 'became chief justice'),
(NULL, 14, 3, '2009-04-19', 'i', 170000, 'reassigned to court based upon local area population growth');
COMMIT;


-- --------------------------------------------------------------
-- case
-- --------------------------------------------------------------
drop table if exists `case`;
create table if not exists `case`
  (
    cse_id smallint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    cse_type varchar(45) not null,
    cse_description text not null,
    cse_start_date date not null,
    cse_end_date date null,
    cse_notes varchar(255) null,

    primary key (cse_id),

    index idx_per_id (per_id asc),

    CONSTRAINT fk_court_case_judge
    foreign key (per_id)
    references judge(per_id)
    on delete no action
    on update cascade
    ) Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;


-- --------------------------------------------------------------------------------------------------------------------------------------



INSERT INTO `case`
(cse_id, per_id, cse_type, cse_description, cse_start_date, cse_end_date, cse_notes)
Values
(NULL, 11, 'traffic', 'client ran a red light', '2010-09-01', NULL, 'illegal Actions have consesquences.'),
(NULL, 12, 'civil', 'client partied a little too hard', '2009-01-19', NULL, NULL),
(NULL, 13, 'criminal', 'client almost killed someone', '2009-01-01', '2010-02-02', 'Charges dropped'),
(NULL, 13, 'civil', 'client jay-walked on campus', '2008-12-01', NULL, 'illegal Actions have consesquences.'),
(NULL, 15, 'civil', 'client did not know that they should pay taxes', '2010-01-01', NULL, NULL);

COMMIT;

-- --------------------------------------------------------------
-- bar
-- --------------------------------------------------------------
drop table if exists bar;
create table if not exists bar
  (
    bar_id tinyint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    bar_name varchar(45) not null,
    bar_notes varchar(255) null,

    primary key (bar_id),

    INDEX idx_per_id (per_id ASC),

    constraint fk_bar_attorney
    foreign key (per_id)
    references attorney(per_id)
    on delete no action
    on update CASCADE
  ) Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;


-- --------------------------------------------------------------------------------------------------------------------------------------


START TRANSACTION;
INSERT INTO bar
(bar_id, per_id, bar_name, bar_notes)
VALUES
(NULL, 6, 'Florida bar', NULL),
(NULL, 7, 'Alabama bar', NULL),
(NULL, 8, 'Georgia bar', NULL),
(NULL, 6, 'Tallahassee Bar', NULL),
(NULL, 8, 'Bay County Bar', NULL);
COMMIT;

-- --------------------------------------------------------------
-- specialty
-- --------------------------------------------------------------
drop table if exists specialty;
create table if not exists specialty
  (
    spc_id tinyint unsigned not null auto_increment,
    per_id smallint unsigned not null,
    spc_type varchar(45) not null,
    spc_notes varchar(255) null,

    primary key(spc_id),

    index idx_per_id(per_id ASC),

    constraint fk_specialty_attorney
    foreign key (per_id)
    references attorney(per_id)
    on delete no action
    on update CASCADE
  ) Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;

-- --------------------------------------------------------------------------------------------------------------------------------------

START TRANSACTION;

INSERT INTO specialty
(spc_id, per_id, spc_type, spc_notes)
VALUES
(NULL, 6, 'business', NULL),
(NULL, 7, 'traffic', NULL),
(NULL, 10, 'judicial', NULL),
(NULL, 6, 'environmental', NULL),
(NULL, 7, 'criminal', NULL);
commit;

-- --------------------------------------------------------------
-- assignment
-- --------------------------------------------------------------
drop table if exists assignment;
create table if not exists assignment
  (
    asn_id smallint unsigned not null auto_increment,
    per_cid smallint unsigned not null,
    per_aid smallint unsigned not null,
    cse_id smallint unsigned not null,
    asn_notes varchar(255) null,

    primary key (asn_id),

    INDEX idx_per_cid (per_cid ASC),
    INDEX idx_per_aid (per_aid ASC),
    INDEX idx_cse_id (cse_id ASC),

    unique index ux_per_cid_per_aid_cse_cse_id (per_cid ASC, per_aid ASC, cse_id ASC),

    constraint fk_assignment_case
    foreign key (cse_id)
    references `case`(cse_id)
    on delete no action
    on update CASCADE,

    constraint fk_assignment_client
    foreign key (per_cid)
    references client(per_id)
    on delete no action
    on update CASCADE,

    constraint fk_assignment_attorney
    foreign key (per_aid)
    references attorney(per_id)
    on delete no action
    on update CASCADE
    )Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;

-- --------------------------------------------------------------------------------------------------------------------------------------

start transaction;
insert into assignment
(asn_id, per_cid, per_aid, cse_id, asn_notes)
values
(NULL, 1,6,1, NULL),
(NULL, 2,7,2, NULL),
(NULL, 3,8,3, NULL),
(NULL, 4,8,4, NULL),
(NULL, 5,9,5, NULL);
commit;

  -- --------------------------------------------------------------
  -- phone
  -- --------------------------------------------------------------

  drop table if exists phone;
  create table if not exists phone
    (
      phn_id smallint unsigned not null auto_increment,
      per_id smallint unsigned not null,
      phn_num bigint not null,
      phn_type enum('c', 'h', 'w') not null,
      phn_notes varchar(255) null,

      primary key(phn_id),

      index idx_per_id (per_id ASC),

      CONSTRAINT fk_phone_person
      FOREIGN KEY (per_id)
      REFERENCES person(per_id)
      on delete no action
      on update CASCADE
    ) Engine = innoDB   default character set= utf8mb4 collate = utf8mb4_0900_ai_ci;


-- --------------------------------------------------------------------------------------------------------------------------------------


START TRANSACTION;
INSERT INTO phone
(phn_id, per_id, phn_num, phn_type, phn_notes)
VALUES
(NULL, 1, 8032288827, 'c', NULL),
(NULL, 2, 2052338293, 'h', NULL),
(NULL, 4, 1034325598, 'w', 'has two office numbers'),
(NULL, 5, 6402338494, 'w', NULL),
(NULL, 6, 5508329842, 'w', 'fax number not currently working');
Commit;

-- --------------------------------------------------------------------------------------------------------------------------------------


DROP PROCEDURE IF EXISTS CreatePersonSSN;
DELIMITER $$
CREATE PROCEDURE CreatePersonSSN()
BEGIN
DECLARE x, y INT;
SET x = 1;
select count(*) into y from person;

WHILE x <= y DO
SET @salt=RANDOM_BYTES(64);
SET @ran_num=FLOOR(RAND()*(999999999-111111111+1))+111111111;
SET @ssn=unhex(sha2(concat(@salt, @ran_num), 512));

update person
set per_ssn=@ssn, per_salt=@salt
where per_id=x;
SET x = x + 1;
END WHILE;
END$$
DElIMITER ;
call CreatePersonSSN();
