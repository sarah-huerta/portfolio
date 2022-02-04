-- If LOCAL is specified, the file is read by the client program on the client host and sent to the server.
-- for default .csv file use comma-terminated

-- \r\n for files created on windows machines, \n for files created on Mac or UNIX machines

/*
And, *be sure* to log in turning on the load data infile functionality:
mysql -u fsuid -p --local-infile=1
*/

/* data for selected attributes, on CCI server (must specify LOCAL, otherwise, error) */
LOAD DATA LOCAL INFILE 'db/person.csv'
INTO TABLE person
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
(per_id, per_ssn, per_fname, per_lname, per_gender, per_dob, per_street, per_city, per_state, per_zip, per_phone, per_email, per_is_emp, per_is_alm, per_is_stu, per_notes);

show warnings;
