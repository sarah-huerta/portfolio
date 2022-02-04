/*
i. List all financial institutions, full user names, account types and the date they were opened, only include checking accounts, group by institution, sort by institution name in ascending order and limit to two records displayed*/

--old style join
select ins_name, usr_fname, usr_lname, act_type, src_start_date
from institution as i, source as s, user as u, account as a
where i.ins_id =s.ins_id
and s.usr_id = u.usr_id
and s.act_id = a.act_id
and act_type = "checking"
group by i.ins_id, usr_fname, usr_lname, src_start_date
order by ins_name
limit 0,2;

--natural join
select ins_name, usr_fname, usr_lname, act_type, src_start_date
from institution
natural join source
natural join user
natural join account
where act_type = "checking"
group by ins_id, usr_id, and src_id
order by ins_name
limit 0,2;

--join Using
select ins_name, usr_fname, usr_lname, act_type, src_start_date
from institution
join source using(ins_id)
join user using(usr_id)
join account using(act_id)
where act_type = "checking"
group by ins_id, usr_fname, usr_lname, src_start_date
order by ins_name
limit 0,2;

--join on

select ins_name, usr_fname, usr_lname, act_type, src_start_date
from institution as i
join source as s on i.ins_id = s.ins_id
join user as u on s.usr_id = u.usr_id
join account as a on s.act_id = a.act_id
where act_type = "checking"
group by i.ins_id, usr_fname, usr_lname, src_start_date
order by ins_name
limit 0,2;
/*ii. List all user names, account types, transaction types, methods, amounts, and dates, group by user sort by transaction amount in desc order (format amounts to two decimal places, and include a dollar sign), limit to one record displayed.*/

--natural join
select usr_fname, usr_lname, act_type, trn_type, trn_method,
concat('$', format(trn_amt,2)) as 'trans amount', trn_date
from user
natural join source
natural join account
natural join transaction
group by usr_id, act_id, trn_id
order by trn_amt desc
limit 0,1;

--join Using
select usr_fname, usr_lname, act_type, trn_type, trn_method,
concat('$', format(trn_amt,2)) as 'trans amount', trn_date
from user
join source using(usr_id)
join account using(act_id)
join transaction using (src_id)
group by usr_id, act_id, trn_id
order by trn_amt desc
limit 0,1;

-- join on
select usr_fname, usr_lname, act_type, trn_type, trn_method,
concat('$', format(trn_amt,2)) as 'trans amount', trn_date
from user as u
join source as s on u.usr_id = s.usr_id
join account as a on s.act_id=a.act_id
join transation as t on s.src_id = t.src_id
group by u.usr_id, a.act_id, trn_id
group by trn_amt desc
limit 0,1;

--old style join
select usr_fname, usr_lname, act_type, trn_type, trn_method,
concat('$', format(trn_amt,2)) as 'trans amount', trn_date
from user as u, source as s, account as a, transaction as t
where u.usr_id = s.usr_id
and s.act_id = a.act_id
and s.src_id = t.src_id
group by u.usr_id a.act_id, trn_id
order by trn_amt desc
limit 0,1;

/*iii. List full user names, account types, and total spending (debit) amount for each category type, group by user, and sort by category in descending order, format dollar amounts.*/

-- natura; join
select usr_fname, usr_lname, cat_type, trn_type, act_type,
concat ('$', format(sum(trn_amt),2)) as 'total spending'
from user
natural join source
natural join account
natural join transation
natural join category
where trn_type = "debit"
group by usr_id, cat_id, act_id
order by cat_type desc;

--join using
select usr_fname, usr_lname, cat_type, trn_type, act_type,
concat ('$', format(sum(trn_amt),2)) as 'total spending'
from user
join source using (usr_id)
join account using (act_id)
join transation using(src_id)
join category using (cat_id)
where trn_type = "debit"
group by usr_id, cat_id, act_id
order by cat_type desc;

--join on
select usr_fname, usr_lname, cat_type, trn_type, act_type,
concat ('$', format(sum(trn_amt),2)) as 'total spending'
from user as u
join source as s on u.usr_id = s.usr_id
join account as a on s.act_id = a.act_id
join transation as t on s.src_id = t.src_id
join category as c on c.cat_id = t.trn_id
where trn_type = "debit"
group by u.usr_id, c.cat_id, a.act_id
order by cat_type desc;

--old style join
select usr_fname, usr_lname, cat_type, trn_type, act_type,
concat ('$', format(sum(trn_amt),2)) as 'total spending'
from user as u, source as s, account as a, transation as t, category as c
where u.usr_id =s.usr_id
and s.act_id = a.act_id
and s.src_id = t.src_id
and c.cat_id = t.cat_id
and trn_type = "debit"
group by u.usr_id, c.cat_id, a.act_id
order by cat_type desc;



/*iv. Using only SQL, add an account_history table inside of your database with the following attribute definitions (use prefix aht_ for each attribute, except act_id), all should be not null except action and notes:
act_id pf tinyint unsigned,
date pk date,
action enum: insert, update, delete COMMENT 'indicates changes to account',
notes varchar(255) DEFAULT NULL,
CONSTRAINT `fk_account_history_account` FOREIGN KEY (act_id) REFERENCES account (act_id) ON DELETE RESTRICT ON UPDATE CASCADE,
ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_general_ci*/
drop table if exists account_history;
CREATE TABLE if not exists account_history
(
act_id  tinyint unsigned NOT NULL,
aht_date date NOT NULL,
aht_action enum( 'insert', 'update', 'delete ') COMMENT 'indicates changes to account',
aht_notes varchar(255) DEFAULT NULL,
PRIMARY KEY (act_id, aht_date),
CONSTRAINT fk_account_history_account
FOREIGN KEY (act_id)
REFERENCES account (act_id)
ON DELETE RESTRICT ON UPDATE CASCADE,
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
/*v. Alter account_history table to the following options:
action enum: insert, update, delete, NOT NULL DEFAULT 'insert' and COMMENT 'reflects changes to account'*/

show create table account_history;
show full columns from account_history;
describe account_history;

ALTER TABLE account_history change aht_action aht_action enum('insert', 'update', 'delete')
NOT NULL DEFAULT 'insert' COMMENT 'reflect changes to account';

show create table account_history;
show full columns from account_history;
describe account_history;


/* vi. Create an Excel file: with 10 records for the transaction table, and save as transaction_data.csv. Insert data using the following LOAD DATA INFILE command. Loading Data Helper Video: https://www.youtube.com/watch?v=G2Vg5hUz5eg
LOAD DATA LOCAL INFILE 'db/transaction_data.csv' INTO TABLE transaction
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '''' LINES TERMINATED BY '\r\n'
(trn_id, src_id, cat_id, trn_type, trn_method, trn_amt, @date_variable, trn_notes)
SET
trn_date = STR_TO_DATE(@date_variable, '%c/%e/%Y %H:%i:%s'); show warnings; */

LOAD DATA LOCAL INFILE 'db/transaction_data.csv' INTO TABLE transaction
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '''' LINES TERMINATED BY '\r\n'
(trn_id, src_id, cat_id, trn_type, trn_method, trn_amt, @date_variable, trn_notes)
SET
trn_date = STR_TO_DATE(@date_variable, '%c/%e/%Y %H:%i:%s'); show warnings;
