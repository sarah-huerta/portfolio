-- set foreign_key_checks=0;

drop database if exists sah16m;
create database if not exists sah16m;
use sah16m;

-- ----------
-- Company table
-- -----------

DROP TABLE if Exists company;
create table if not exists Company
(
  cmp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  cmp_type enum('C-Corp', 'S-Corp','Non-Profit-Corp','LLC','Partnership'),
  cmp_street VARCHAR(30) NOT NULL,
  cmp_city VARCHAR(30) NOT NULL,
  cmp_state CHAR(2) NOT NULL,
  cmp_zip int(9) unsigned ZEROFILL NOT NULL COMMENT 'no dashes',
  cmp_phone bigint unsigned NOT NULL COMMENT 'ssn and zop codes can be zero=filled, but not US area codes',
  cmp_ytd_sales DECIMAL(10,2) unsigned NOT NULL COMMENT '12,345,678.90',
  cmp_email VARCHAR(100) NULL,
  cmp_url VARCHAR(100) NULL,
  cmp_notes VARCHAR(255) NULL,
  PRIMARY KEY (cmp_id)
)
ENGINE = InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

SHOW WARNINGS;


Insert INTO company(cmp_id, cmp_type, cmp_street, cmp_city, cmp_state, cmp_zip, cmp_phone, cmp_ytd_sales, cmp_email, cmp_url, cmp_notes)
VALUES
(null,'C-Corp','123 town square dr','orlando','FL',321431234,1029384756,123456.2,'mickeymouse@magic.com',null,'President of the Mouse House'),
(null,'S-Corp', '321 main street cir','celebration','FL',312432345,9087654321,123859.3,'svenfrozen@magic.com','http://www.sven.com','Ice Creator'),
(null,'Non-Profit-Corp','452 world dr','bay lakes','FL',353213456,3849283094,5749203.4,'daisyduck@magic.com',null,null),
(null,'LLC','4328 seven seas dr','magic','FL',336534567,1234568908,432859.3,null,'http://www.mirabel.com',null),
(null,'Partnership','4382 wonder st','celebration','FL',312455678,3482930495,5749.2,'goofygoofman@magic.com',null,'Comedic Relief');

SHOW WARNINGS;


-- ---------------------
-- Table Customer
-- ---------------------

Drop Table if exists customer;
create table if not exists customer
  (
    cus_id INT UNSIGNED NOT NUll AUTO_INCREMENT,
    cmp_id INT UNSIGNED NOT NULL,
    cus_ssn binary(64) NOT NULL,
    cus_salt binary(64) NOT NULL,
    cus_type enum('Loyal', 'Discount','Impulse','Need-Based','Wandering'),
    cus_first VARCHAR(15) NOT NULL,
    cus_last VARCHAR(30) NOT NULL,
    cus_street VARCHAR(30) NOT NULL,
    cus_city VARCHAR(30) NOT NULL,
    cus_state CHAR(2) NOT NULL,
    cus_zip INT(9) unsigned ZEROFILL NOT NULL COMMENT 'snn and zip codes can be zero filled, but not US are codes',
    cus_email VARCHAR(100) NULL,
    cus_balance DECIMAL(7,2) unsigned NULL COMMENT '12,345.67',
    cus_tot_sales DECIMAL(7,2) unsigned NULL,
    cus_notes VARCHAR(255) NULL,
    PRIMARY KEY(cus_id),

    UNIQUE INDEX ux_cus_ssn (cus_ssn ASC),
    INDEX idx_cmp_id (cmp_id ASC),

    CONSTRAINT fk_customer_company
      FOREIGN KEY(cmp_id)
      REFERENCES company(cmp_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
    )
  ENGINE = InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

  SHOW WARNINGS;

  set @salt=RANDOM_BYTES(64);
  INSERT INTO customer
    values
    (null,2,unhex(SHA2(CONCAT(@salt, 123456789),512)),@salt,'Loyal','Minnie','Mouse ','1486 Buena Vista Dr','Bay Lake','FL',336261234,'minniemouse@magic.com',1234.23,12345.43,'Great at Sales'),
    (null,4,unhex(SHA2(CONCAT(@salt, 987654321),512)),@salt,'Discount','Elsa','Frozen','2901 Osceola Pkwy','Lake Buena Vista','FL',324042345,'elsafrozen@magic.com',32124.23,432.54,null),
    (null,5, unhex(SHA2(CONCAT(@salt, 192837465),512)),@salt,'Impulse','Donald ','Duck','351 S Studio Dr','Celebration','FL',324112347,'donaldduck@magic.com',432.12,23412.43,'Anger shops'),
    (null,3, unhex(SHA2(CONCAT(@salt, 918273645),512)),@salt,'Need-Based','Olaf','Oakenson','200 Epcot Center Dr','Celebration','FL',338123419,'olafoakenson@magic.com',324.12,234.43,null),
    (null,1, unhex(SHA2(CONCAT(@salt,135792468), 512)),@salt,'Wandering','Mirabel','Madrigal','3111 World Drive','Bay Lake','FL',324912342,'mirabelmadrigal@magic.com',453.12,1234.54,'Not looking');


  SHOW WARNINGS;
  select * from company;
  select * from customer;
