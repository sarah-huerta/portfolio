pst_id	pst_name	pst_street	pst_city	pst_state	pst_zip	pst_phone	pst_email	pst_url	pst_ytd_sales	pst_notes
1	Aberts	111 apple st	pensacola	FL	32401	8501234567	aberts@gmail.com	aberts.com	1230.00	no notes
2	Berthas Pet	222 beta st	panama city	FL	32401	8502345678	bertha@gmail.com	bethas.com	8394.00	 sells lots of pets
3	Charlies Pet	333 coffee dr	Atlanta	GA	68293	6783456789	charlie@gmail.com	charlie.com	321.00	no notes
4	Davids Pet	444 doggie dr	tallahassee	FL	32304	8504567890	davied@gmail.com	david.com	234.43	they have good service
5	Ellens Elephant	555 eve ave	jacksonville	FL	34636	6121234567	ellen@gmail.com	ellen.com	39204.33	does very well with sales.


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
