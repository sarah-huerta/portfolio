pet_id	pst_id	pet_type	pet_sex	pet_cost	pet_price	pet_age	pet_color	pet_sale_date	pet_vaccine	pet_neuter	pet_notes
1	1	dog	M	123.22	223.21	2	tan	2020-01-01	Y	Y	friendly with other pets.
2	2	cat	F	4563.11	1163.45	4	white	2020-02-02	Y	Y	very cuddly.
3	3	bunny	M	54.00	45.00	6	black	2020-03-03	Y	Y	no notes.
4	4	snake	F	23.99	99.23	8	red	2020-04-04	N	N	loves naps
5	5	bird	M	342.11	112.43	10	yellow	2020-05-05	N	N	sings alot

Column_name	Type	Computed	Length	Prec	Scale	Nullable	TrimTrailingBlanks	FixedLenNullInSource	Collation
pet_id	smallint	no	2	5    	0    	no	(n/a)	(n/a)	NULL
pst_id	tinyint	no	1	3    	0    	yes	(n/a)	(n/a)	NULL
pet_type	varchar	no	45	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pet_sex	char	no	1	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pet_cost	decimal	no	5	6    	2    	no	(n/a)	(n/a)	NULL
pet_price	decimal	no	5	6    	2    	no	(n/a)	(n/a)	NULL
pet_age	smallint	no	2	5    	0    	no	(n/a)	(n/a)	NULL
pet_color	varchar	no	30	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pet_sale_date	date	no	3	10   	0    	no	(n/a)	(n/a)	NULL
pet_vaccine	char	no	1	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pet_neuter	char	no	1	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pet_notes	varchar	no	255	     	     	yes	no	yes	SQL_Latin1_General_CP1_CI_AS
