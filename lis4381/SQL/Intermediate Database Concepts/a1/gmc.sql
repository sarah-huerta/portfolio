set foreign_key_checks=0;

DROP TABLE IF EXISTS dealership;
CREATE  TABLE IF NOT EXISTS dealership (
  dlr_id INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  dlr_name VARCHAR(45) NOT NULL ,
  dlr_street VARCHAR(30) NOT NULL ,
  dlr_city VARCHAR(20) NOT NULL ,
  dlr_state CHAR(2) NOT NULL ,
  dlr_zip CHAR(9) NOT NULL COMMENT 'no dashes' ,
  dlr_phone CHAR(10) NOT NULL COMMENT 'no dashes' ,
  dlr_ytd_sales DECIMAL(10,2) NOT NULL COMMENT '12,345,678.90' ,
  dlr_url VARCHAR(100) NOT NULL ,
  dlr_notes VARCHAR(255) NULL ,
  PRIMARY KEY (dlr_id) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- show warnings;

-- -----------------------------------------------------
-- Table dealership_history
-- -----------------------------------------------------
DROP TABLE IF EXISTS dealership_history ;
CREATE  TABLE IF NOT EXISTS dealership_history (
  dhs_id INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  dlr_id INT UNSIGNED NOT NULL ,
  dhs_ytd_sales DECIMAL(10,2) NOT NULL ,
  dhs_year YEAR NOT NULL ,
  dhs_notes VARCHAR(255) NULL ,
  PRIMARY KEY (dhs_id) ,

  INDEX idx_dlr_id (dlr_id ASC) ,

  CONSTRAINT fk_dealer_history_dealership

    FOREIGN KEY (dlr_id )
    REFERENCES dealership (dlr_id )
    ON DELETE NO ACTION
    ON UPDATE CASCADE)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;

DROP TABLE IF EXISTS slsrep ;
CREATE  TABLE IF NOT EXISTS slsrep (
  srp_id INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  dlr_id INT UNSIGNED NOT NULL ,
  srp_fname VARCHAR(15) NOT NULL ,
  srp_lname VARCHAR(30) NOT NULL ,
  srp_dob DATE NOT NULL COMMENT 'for derived attribute age' ,
  srp_street VARCHAR(30) NOT NULL ,
  srp_city VARCHAR(20) NOT NULL ,
  srp_state CHAR(2) NOT NULL ,
  srp_zip CHAR(9) NOT NULL ,
  srp_phone CHAR(10) NOT NULL ,
  srp_email VARCHAR(45) NOT NULL ,
  srp_tot_sales DECIMAL(10,2) NOT NULL COMMENT '12,345,678.90, demo aggregate functions with null values' ,
  srp_comm DECIMAL(7,2) NOT NULL ,
  srp_notes VARCHAR(255) NULL ,
  PRIMARY KEY (srp_id) ,

  INDEX idx_dlr_id (dlr_id ASC) ,

  CONSTRAINT fk_slsrep_dealership
    FOREIGN KEY (dlr_id )
    REFERENCES dealership (dlr_id )
    ON DELETE NO ACTION
    ON UPDATE CASCADE)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

show warnings;

DROP TABLE IF EXISTS customer ;
CREATE  TABLE IF NOT EXISTS customer (
  cus_id INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  cus_fname VARCHAR(15) NOT NULL ,
  cus_lname VARCHAR(30) NOT NULL ,
  cus_street VARCHAR(30) NOT NULL ,
  cus_city VARCHAR(20) NOT NULL ,
  cus_state CHAR(2) NOT NULL ,
  cus_zip CHAR(9) NOT NULL ,
  cus_phone CHAR(10) NOT NULL COMMENT 'otherwise, cannot contact customer' ,
  cus_email VARCHAR(45) NULL ,
  cus_balance DECIMAL(9,2) NOT NULL ,
  cus_tot_sales DECIMAL(9,2) NOT NULL ,
  cus_notes VARCHAR(255) NULL ,
  PRIMARY KEY (cus_id) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table assignment
-- -----------------------------------------------------
DROP TABLE IF EXISTS assignment ;
CREATE  TABLE IF NOT EXISTS assignment (
  asn_id INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  srp_id INT UNSIGNED NOT NULL ,
  cus_id INT UNSIGNED NOT NULL ,
  asn_date DATE NOT NULL ,
  asn_notes VARCHAR(45) NULL ,
  PRIMARY KEY (asn_id) ,

  INDEX idx_srp_id (srp_id ASC) ,
  INDEX idx_cus_id (cus_id ASC) ,

  UNIQUE INDEX idx_cus_id_srp_id_asn_date 
  (cus_id ASC, srp_id ASC, asn_date ASC),

  CONSTRAINT fk_assignment_slsrep
    FOREIGN KEY (srp_id )
    REFERENCES slsrep (srp_id )
    ON DELETE NO ACTION
    ON UPDATE CASCADE,

  CONSTRAINT fk_assignment_customer
    FOREIGN KEY (cus_id )
    REFERENCES customer (cus_id )
    ON DELETE NO ACTION
    ON UPDATE CASCADE)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;

DROP TABLE IF EXISTS vehicle ;
CREATE  TABLE IF NOT EXISTS vehicle (
  veh_vin CHAR(17) NOT NULL COMMENT 'assume vehicle made after 1980' ,
  dlr_id INT UNSIGNED NOT NULL ,
  asn_id INT UNSIGNED NULL ,
  veh_type VARCHAR(5) NOT NULL DEFAULT 'auto' COMMENT 'auto, suv, truck, van' ,
  veh_make VARCHAR(20) NOT NULL ,
  veh_model VARCHAR(25) NOT NULL ,
  veh_year YEAR NOT NULL ,
  veh_cost DECIMAL(8,2) NOT NULL ,
  veh_price DECIMAL(8,2) NOT NULL COMMENT '123,456.78' ,
  veh_discount DECIMAL(3,2) NULL COMMENT 'percentage discounted' ,
  veh_comm DECIMAL(3,2) NULL COMMENT 'percentage of price for sales rep' ,
  veh_inventory_date DATE NULL COMMENT 'stocked in inventory' ,
  veh_sold_date DATE NULL COMMENT 'date sales rep and customer finalized purchase' ,
  veh_notes VARCHAR(255) NULL ,
  PRIMARY KEY (veh_vin) ,

  INDEX idx_dlr_id (dlr_id ASC) ,
  INDEX idx_asn_id (asn_id ASC) ,

  CONSTRAINT fk_vehicle_dealership
    FOREIGN KEY (dlr_id )
    REFERENCES dealership (dlr_id )
    ON DELETE NO ACTION
    ON UPDATE CASCADE,

  CONSTRAINT fk_vehicle_assignment
    FOREIGN KEY (asn_id )
    REFERENCES assignment (asn_id )
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;

--
-- Dumping data for table dealership
--

LOCK TABLES dealership WRITE;
INSERT INTO dealership 
VALUES 
       (NULL,'Dealer1','20th Ave.','Seattle','WA','981226749','2065559857','12345678.00','http://www.http://technologies.ci.fsu.edu/node/72','Notes for Dealership1'),
       (NULL,'Dealer2','908 W. Capital Way','Tacoma','WA','984011298','2065559482','9945678.00','http://www.qcitr.com','Notes for Dealership2'),
       (NULL,'Dealer3','722 Moss Bay Blvd.','LA','CA','980337845','2065553412','1345678.00','http://www.markjowett.com','Notes for Dealership3'),
       (NULL,'Dealer4','4110 Old Redmond Rd.','Detroit','MI','980529021','2065558122','678345.00','http://www.thejowetts.com','Notes for Dealership4'),
       (NULL,'Dealer5','4726 11th Ave. N.E.','Phoenix','AZ','981051082','2065551189','345678.00','http://www.qualityinstruction.com','Notes for Dealership5');
UNLOCK TABLES;

show warnings;

--
-- Dumping data for table vehicle
--

LOCK TABLES vehicle WRITE;
INSERT INTO vehicle 
VALUES 
       ('1FTCR15X0TTA01050',5,1,'Truck','Ford','Ranger',2010,50000.00,53995.00,.03,.01,'2011-01-02', '2011-05-05','Heavy Duty'),
       ('1G1FP22PXS2100001',2,NULL,'Auto','Chevrolet','Corvette ZR1',2011,95000.00,110000.00,0.00,.05,'2011-01-02', '2011-05-05','Viper Killer!'),
       ('2FMZU62E02ZB78590',1,5,'SUV','Jeep','Liberty',2008,25000.00,32000.00,.10,.05,'2011-01-02', '2011-05-05','Off-road vehicle'),
       ('4S4BP67C454326621',4,7,'Auto','Suburu','Outback XT Limited XT',2005,18000.00,21785.00,.05,.03,'2011-01-02', '2011-05-05','Utility vehicle'),
       ('WDBCA45EXKA478654',3,9,'Auto','Dodge','Viper',2011,75000.00,85000.00,0.02,.06,'2011-01-02', '2011-05-05','Super fast!'),
       ('456874AKXE54ACBDW',2,NULL,'Truck','GMC','3500',2009,54000.00,58000.00,0.04,.02,'2011-01-02', '2011-05-05','Good hauler!'),
       ('AUT674IQOP1VZ32H6',1,9,'SUV','Toyota','Status',2010,35000.00,40000.00,0.07,.02,'2011-01-02', '2011-05-05','Seats six!'),
       ('NZVJ854GKRWI190AQ',3,NULL,'Van','Chevrolet','Traveler',2008,25000.00,30000.00,0.10,.05,'2011-01-02', '2011-05-05','Seats twelve!'),
       ('197FDJUE6W435C298',5,3,'Auto','Nissan','350Z',2011,55000.00,65000.00,0.01,.02,'2011-01-02', '2011-05-05','Good sports car buy!'),
       ('HFIDOYRT54637FDVS',4,2,'Van','Ford','Econoline',2012,30000.00,35000.00,0.08,.03,'2011-01-02', '2011-05-05','Seats ten!');
UNLOCK TABLES;

show warnings;

--
-- Dumping data for table slsrep
--

LOCK TABLES slsrep WRITE;
INSERT INTO slsrep 
VALUES 
       (NULL,3,'Nancy','Davolio','1948-12-08','173 Harbor Way','Benton','AR','720018976','5015559857','test1@email.com','256678.00',987.30,'sales rep1 notes'),
       (NULL,2,'Andrew','Fuller','1952-02-19','862 Valkarie Dr.','Fort Smith','AR','780927934','5015559482','test2@email.com','478678.00',1857.69,'sales rep2 notes'),
       (NULL,4,'Janet','Leverling','1963-08-30','784 Universal Blvd.','Springdale','AR','763451251','5015553412','test3@email.com','964678.00',2532.84,'sales rep3 notes'),
       (NULL,5,'Margaret','Peacock','1937-09-19','778 Broadway Cliff','Pine Bluff','AR','679620956','5015558122','test4@email.com','1378345.00',7354.21,'sales rep4 notes'),
       (NULL,1,'Laura','Callahan','1958-01-09','438 Callaway Ave.','Texarkana','AR','736215489','5015551189','test5@email.com','876543.00',98.10,'sales rep5 notes');
UNLOCK TABLES;

show warnings;

--
-- Dumping data for table customer
--

LOCK TABLES customer WRITE;
INSERT INTO customer 
VALUES 
       (NULL,'Wilbur','Denaway','23 Billing\'s Gate','El Paso','TX','885703412','2145559857','test1@mymail.com','8391.87','37642.00','customer1 notes'),
       (NULL,'Bradford','Casis','891 Drift Dr.','Stanton','TX','885819045','2145559482','test2@mymail.com','675.57','87341.00','customer2 notes'),
       (NULL,'Valerie','Lieblong','421 Calamari Vista','Odessa','TX','797621134','2145553412','test3@mymail.com','8730.23','92678.00','customer3 notes'),
       (NULL,'Kathy','Jeffries','915 Drive Past','Penwell','TX','799135674','2145558122','test4@mymail.com','2651.19','78345.00','customer4 notes'),
       (NULL,'Steve','Rogers','329 Volume Ave.','Tarzan','TX','885954426','2145551189','test5@mymail.com','782.73','23471.00','customer5 notes');
UNLOCK TABLES;

show warnings;

LOCK TABLES assignment WRITE;
INSERT INTO assignment 
VALUES 
       (NULL,1,1,'2005-11-12','assignment1 notes'),
       (NULL,2,1,'2005-12-22','assignment2 notes'),
       (NULL,3,1,'2006-01-02','assignment3 notes'),
       (NULL,3,2,'2006-05-03','assignment4 notes'),
       (NULL,4,3,'2006-06-04','assignment5 notes'),
       (NULL,5,2,'2007-03-18','assignment6 notes'),
       (NULL,5,1,'2007-07-31','assignment7 notes'),
       (NULL,2,2,'2007-08-09','assignment8 notes'),
       (NULL,2,3,'2008-02-14','assignment9 notes'),
       (NULL,4,4,'2008-10-07','assignment10 notes'),
       (NULL,5,5,'2009-04-01','assignment11 notes');
UNLOCK TABLES;

show warnings;

   LOCK TABLES dealership_history WRITE;
INSERT INTO dealership_history
VALUES 
       (NULL,1,15000000,2009,'Decent year.'),
       (NULL,1,8000000.00,2010,'Good year.'),
       (NULL,1,10000000.00,2011,'Bad year.'),
       (NULL,1,12345678.00,2012,'Average year.'),
       (NULL,2,4500000.00,2008,'Decent year.'),
       (NULL,2,7800000.00,2009,'Average year.'),
       (NULL,2,6000000.00,2010,'Decent year.'),
       (NULL,2,8625678.00,2011,'Good year.'),
       (NULL,2,9945678.00,2012,'Decent year.'),
       (NULL,3,999786.00,2011,'Average year.'),
       (NULL,3,1345678.00,2012,'Good year.'),
       (NULL,4,1200000.00,2011,'Bad year.'),
       (NULL,4,678345.00,2012,'Decent year.'),
       (NULL,5,556741.00,2010,'Average year.'),
       (NULL,5,1300000.00,2011,'Good year.'),
       (NULL,5,345678.00,2012,'Bad year.');
UNLOCK TABLES;

show warnings;

set foreign_key_checks=1;
