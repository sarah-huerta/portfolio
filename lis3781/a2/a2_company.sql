-- set foreign_key_checks=0;

drop database if exists sah16m;
create database if not exists sah16m;
use sah16m;

-- ----------
-- Company table
-- -----------

DROP TABLE if Exists company;
create table if not exists company
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
