
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sah16m
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sah16m` ;

-- -----------------------------------------------------
-- Schema sah16m
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sah16m` DEFAULT CHARACTER SET utf8mb4 ;
SHOW WARNINGS;
USE `sah16m` ;

-- -----------------------------------------------------
-- Table `sah16m`.`petstore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sah16m`.`petstore` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `sah16m`.`petstore` (
  `pst_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `pst_name` VARCHAR(30) NOT NULL,
  `pst_street` VARCHAR(30) NOT NULL,
  `pst_city` VARCHAR(30) NOT NULL,
  `pst_state` CHAR(2) NOT NULL,
  `pst_zip` CHAR(9) NOT NULL,
  `pst_phone` BIGINT UNSIGNED NOT NULL,
  `pst_email` VARCHAR(100) NOT NULL,
  `pst_url` VARCHAR(100) NOT NULL,
  `pst_ytd_sales` DECIMAL(10,2) NOT NULL,
  `pst_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`pst_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `sah16m`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sah16m`.`customer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `sah16m`.`customer` (
  `cus_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `cus_fname` VARCHAR(15) NOT NULL,
  `cus_lname` VARCHAR(30) NOT NULL,
  `cus_street` VARCHAR(30) NOT NULL,
  `cus_city` VARCHAR(30) NOT NULL,
  `cus_state` CHAR(2) NOT NULL,
  `cus_zip` CHAR(9) NOT NULL,
  `cus_phone` BIGINT UNSIGNED NOT NULL,
  `cus_email` VARCHAR(100) NOT NULL,
  `cus_balance` DECIMAL(8,2) NOT NULL,
  `cus_total_sales` DECIMAL(8,2) NOT NULL,
  `cus_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`cus_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `sah16m`.`pet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sah16m`.`pet` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `sah16m`.`pet` (
  `pet_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `pst_id` SMALLINT NOT NULL,
  `cus_id` SMALLINT NULL,
  `pet_type` VARCHAR(45) NOT NULL,
  `pet_sex` ENUM('m', 'f') NOT NULL,
  `pet_cost` DECIMAL(6,2) NOT NULL,
  `pet_price` DECIMAL(6,2) NOT NULL,
  `pet_age` TINYINT NOT NULL,
  `pet_color` VARCHAR(30) NOT NULL,
  `pet_sale_date` DATE NULL,
  `pet_vaccine` ENUM('y', 'n') NOT NULL,
  `pet_neuter` ENUM('y', 'n') NOT NULL,
  `pet_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`pet_id`),
  INDEX `fk_pet_petstore_idx` (`pst_id` ASC) VISIBLE,
  INDEX `fk_pet_customer1_idx` (`cus_id` ASC) VISIBLE,
  CONSTRAINT `fk_pet_petstore0`
    FOREIGN KEY (`pst_id`)
    REFERENCES `sah16m`.`petstore` (`pst_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pet_customer10`
    FOREIGN KEY (`cus_id`)
    REFERENCES `sah16m`.`customer` (`cus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `sah16m`.`petstore`
-- -----------------------------------------------------
START TRANSACTION;
USE `sah16m`;
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Kuphal LLC', '3 Porter Drive', 'Amarillo', 'TX', '791591234', 8064422458, 'eoldford0@nymag.com', 'bigcartel.com', 928.03, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Quigley and Sons', '9726 Center Court', 'York', 'PA', '213578907', 7175496992, 'amccrow1@baidu.com', 'seattletimes.com', 346.71, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Johnston Inc', '468 Briar Crest Terrace', 'Madison', 'WI', '537056789', 6089329505, 'tdadson2@com.com', 'creativecommons.org', 210.44, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Heidenreich', '33 Crest Line Way', 'Decatur', 'IL', '625254567', 2172382224, 'cduncanson3@npr.org', 'google.es', 673.61, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Morissette and Sons', '194 Vera Way', 'El Paso', 'TX', '799683546', 9158885799, 'lwiddop4@intel.com', 'yahoo.co.jp', 941.68, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Cormier LLC', '60956 Oriole Drive', 'Nashville', 'TN', '372286904', 6153724101, 'tcadalleder5@japanpost.jp', 'reverbnation.com', 781.35, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Rodriguez', '904 Orin Crossing', 'Nashville', 'TN', '372352468', 6155266697, 'vbartolomeu6@reddit.com', 'sohu.com', 49.87, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Rogahn-Hintz', '50 Mockingbird Junction', 'Houston', 'TX', '770707987', 8327500641, 'btipping7@jimdo.com', 'nasa.gov', 587.35, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Denesik LLC', '12188 Ridge Oak Parkway', 'Florence', 'SC', '295052356', 8434096942, 'gmccard8@lycos.com', 'upenn.edu', 164.62, NULL);
INSERT INTO `sah16m`.`petstore` (`pst_id`, `pst_name`, `pst_street`, `pst_city`, `pst_state`, `pst_zip`, `pst_phone`, `pst_email`, `pst_url`, `pst_ytd_sales`, `pst_notes`) VALUES (DEFAULT, 'Fisher-Tremblay', '66 Forest Hill', 'Albany', 'NY', '122427809', 5185386991, 'cragles9@hexun.com', 'sphinn.com', 31.33, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sah16m`.`customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `sah16m`;
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Willow', 'Campes', '25857 Loftsgordon Trail', 'Lawrenceville', 'GA', '300451234', 7703466394, 'wcampes0@paypal.com', 251.42, 7472.15, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Ruby', 'O\'Regan', '5 Huxley Alley', 'Juneau', 'AK', '998122345', 9079029516, 'roregan1@pbs.org', 1779.55, 6671.08, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Selma', 'Clappson', '97 Corscot Road', 'Virginia Beach', 'VA', '234714356', 7571135143, 'sclappson2@npr.org', 1767.57, 2268.85, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Lennard', 'Gresswood', '93 Westport Center', 'Herndon', 'VA', '220703456', 7574063582, 'lgresswood3@cmu.edu', 9516.44, 6599.25, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Hugo', 'Bemrose', '70 Meadow Ridge Crossing', 'Atlanta', 'GA', '303863456', 4046912093, 'hbemrose4@stumbleupon.com', 7918.31, 9230.17, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Ginny', 'Ambrogetti', '40229 Dakota Drive', 'Phoenix', 'AZ', '850454321', 4808822075, 'gambrogetti5@examiner.com', 8014.32, 2068.43, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Cully', 'Oven', '469 West Circle', 'Baltimore', 'MD', '212395432', 4438512885, 'coven6@booking.com', 1017.11, 1540.02, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Valle', 'Fawloe', '3939 Upham Junction', 'Boise', 'ID', '837167653', 2083567674, 'vfawloe7@last.fm', 7658.01, 2124.12, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Romola', 'Cressor', '15275 Cardinal Place', 'Fresno', 'CA', '937269403', 2096560679, 'rcressor8@rakuten.co.jp', 9507.69, 4723.89, NULL);
INSERT INTO `sah16m`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_balance`, `cus_total_sales`, `cus_notes`) VALUES (DEFAULT, 'Cissiee', 'Palmer', '2 Manley Junction', 'Richmond', 'VA', '232604839', 8041642310, 'cpalmer9@ted.com', 5709.17, 6870.09, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sah16m`.`pet`
-- -----------------------------------------------------
START TRANSACTION;
USE `sah16m`;
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (1, 2, NULL, 'Cliffchat, mocking', 'm', 267.99, 510.2, 16, 'Purple', '2021-01-21', 'y', 'n', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (2, 3, NULL, 'Fisher', 'f', 851.98, 715.95, 30, 'Puce', '2020-03-21', 'y', 'n', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (3, 4, 2, 'Barbet, levaillant\'s', 'm', 755.17, 495.86, 3, 'Goldenrod', '2019-03-23', 'y', 'y', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (4, 5, NULL, 'White-browed owl', 'f', 196.08, 858.62, 7, 'Indigo', '2021-05-05', 'n', 'y', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (5, 6, NULL, 'Cockatoo, roseate', 'm', 593.95, 541.05, 29, 'Khaki', '2021-10-02', 'n', 'n', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (6, 7, 5, 'Civet cat', 'f', 275.24, 823, 23, 'Purple', NULL, 'n', 'n', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (7, 8, 4, 'Python', 'f', 255.94, 588.4, 17, 'Indigo', NULL, 'n', 'y', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (8, 9, NULL, 'Dove, little brown', 'f', 962.02, 763.22, 4, 'Violet', NULL, 'y', 'y', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (9, 10, 7, 'Waxbill, violet-eared', 'm', 372.52, 307.8, 22, 'Violet', '2019-01-20', 'n', 'n', NULL);
INSERT INTO `sah16m`.`pet` (`pet_id`, `pst_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_age`, `pet_color`, `pet_sale_date`, `pet_vaccine`, `pet_neuter`, `pet_notes`) VALUES (10, 1, NULL, 'Goose, canada', 'm', 111.2, 727.19, 14, 'Violet', '2018-03-15', 'y', 'n', NULL);

COMMIT;
