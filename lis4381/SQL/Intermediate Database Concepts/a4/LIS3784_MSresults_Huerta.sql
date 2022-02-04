

TABLE_CATALOG	TABLE_SCHEMA	TABLE_NAME	TABLE_TYPE
sah16m	dbo	petstore	BASE TABLE

pst_id	pst_name	pst_street	pst_city	pst_state	pst_zip	pst_phone	pst_email	pst_url	pst_ytd_sales	pst_notes
1	Aberts	111 apple st	pensacola	FL	32401	8501234567	aberts@gmail.com	aberts.com	1230.00	no notes
2	Berthas Pet	222 beta st	panama city	FL	32401	8502345678	bertha@gmail.com	bethas.com	8394.00	 sells lots of pets
3	Charlies Pet	333 coffee dr	Atlanta	GA	68293	6783456789	charlie@gmail.com	charlie.com	321.00	no notes
4	Davids Pet	444 doggie dr	tallahassee	FL	32304	8504567890	davied@gmail.com	david.com	234.43	they have good service
5	Ellens Elephant	555 eve ave	jacksonville	FL	34636	6121234567	ellen@gmail.com	ellen.com	39204.33	does very well with sales.



pet_id	pst_id	pet_type	pet_sex	pet_cost	pet_price	pet_age	pet_color	pet_sale_date	pet_vaccine	pet_neuter	pet_notes
1	    1	dog	M	123.22	223.21	2	tan	2020-01-01	Y	Y	friendly with other pets.
2	    2	cat	F	4563.11	1163.45	4	white	2020-02-02	Y	Y	very cuddly.
3	    3	bunny	M	54.00	45.00	6	black	2020-03-03	Y	Y	no notes.
4	    4	snake	F	23.99	99.23	8	red	2020-04-04	N	N	loves naps
5	    5	bird	M	342.11	112.43	10	yellow	2020-05-05	N	N	sings alot


TABLE_CATALOG	TABLE_SCHEMA	TABLE_NAME	TABLE_TYPE
sah16m	dbo	petstore	BASE TABLE
sah16m	dbo	pet	BASE TABLE



TABLE_CATALOG	TABLE_SCHEMA	TABLE_NAME	TABLE_TYPE
sah16m	dbo	petstore	BASE TABLE


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


Column_name	Type	Computed	Length	Prec	Scale	Nullable	TrimTrailingBlanks	FixedLenNullInSource	Collation
pst_id	tinyint	no	1	3    	0    	no	(n/a)	(n/a)	NULL
pst_name	varchar	no	30	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pst_street	varchar	no	30	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pst_city	varchar	no	30	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pst_state	char	no	2	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pst_zip	int	no	4	10   	0    	no	(n/a)	(n/a)	NULL
pst_phone	bigint	no	8	19   	0    	no	(n/a)	(n/a)	NULL
pst_email	varchar	no	100	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pst_url	varchar	no	100	     	     	no	no	no	SQL_Latin1_General_CP1_CI_AS
pst_ytd_sales	decimal	no	9	10   	2    	no	(n/a)	(n/a)	NULL
pst_notes	varchar	no	255	     	     	yes	no	yes	SQL_Latin1_General_CP1_CI_AS


TABLE_CATALOG	TABLE_SCHEMA	TABLE_NAME	TABLE_TYPE
sah16m	dbo	petstore	BASE TABLE
sah16m	dbo	pet	BASE TABLE

Name	Owner	Type	Created_datetime
pet	dbo	user table	2021-07-01 11:59:32.867



Identity	Seed	Increment	Not For Replication
pet_id	1	1	0

No rowguidcol column defined.

Data_located_on_filegroup
PRIMARY

index_name	index_description	index_keys
PK__pet__390CC5FE98EDA6EC	clustered, unique, primary key located on PRIMARY	pet_id

constraint_type	constraint_name	delete_action	update_action	status_enabled	status_for_replication	constraint_keys
CHECK on column pet_age	CK__pet__pet_age__2B3F6F97	(n/a)	(n/a)	Enabled	Is_For_Replication	([pet_age]>(0) AND [pet_age]<=(10500))
CHECK on column pet_cost	CK__pet__pet_cost__29572725	(n/a)	(n/a)	Enabled	Is_For_Replication	([pet_cost]>(0))
CHECK on column pet_neuter	CK__pet__pet_neuter__2D27B809	(n/a)	(n/a)	Enabled	Is_For_Replication	([pet_neuter]='n' OR [pet_neuter]='y')
CHECK on column pet_price	CK__pet__pet_price__2A4B4B5E	(n/a)	(n/a)	Enabled	Is_For_Replication	([pet_price]>(0))
CHECK on column pet_sex	CK__pet__pet_sex__286302EC	(n/a)	(n/a)	Enabled	Is_For_Replication	([pet_sex]='f' OR [pet_sex]='m')
CHECK on column pet_vaccine	CK__pet__pet_vaccine__2C3393D0	(n/a)	(n/a)	Enabled	Is_For_Replication	([pet_vaccine]='n' OR [pet_vaccine]='y')
FOREIGN KEY	fk_pet_petstore	Cascade	Cascade	Enabled	Is_For_Replication	pst_id
 	 	 	 	 	 	REFERENCES sah16m.dbo.petstore (pst_id)
PRIMARY KEY (clustered)	PK__pet__390CC5FE98EDA6EC	(n/a)	(n/a)	(n/a)	(n/a)	pet_id
