-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Schema Cab_Rental
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cab_Rental
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS Cab_Rental;
CREATE SCHEMA IF NOT EXISTS `Cab_Rental` DEFAULT CHARACTER SET utf8 ;
USE `Cab_Rental` ;

-- -----------------------------------------------------
-- Table `Cab_Rental`.`Driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cab_Rental`.`Driver` (
  `Driver_id` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Sex(M/F)` VARCHAR(45),
  `License_No` VARCHAR(45),
  `Date_of_Joining` TIMESTAMP NULL,
  PRIMARY KEY (`Driver_id`),
  UNIQUE INDEX `Driver_id_UNIQUE` (`Driver_id` ASC),
  UNIQUE INDEX `License_No_UNIQUE` (`License_No` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cab_Rental`.`Cab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cab_Rental`.`Cab` (
  `Cab_id` INT UNSIGNED NOT NULL,
  `Model` VARCHAR(45) NULL,
  `Vehicle_registration_no` VARCHAR(45) NULL,
  `Date_of_Purchase` TIMESTAMP NULL,
  `Accessories` MEDIUMTEXT NULL,
  `Driver_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Cab_id`),
  UNIQUE INDEX `Cab_id_UNIQUE` (`Cab_id` ASC),
  INDEX `fk_Cab_Driver1_idx` (`Driver_id` ASC),
  UNIQUE INDEX `Driver_id_UNIQUE` (`Driver_id` ASC),
  CONSTRAINT `fk_Cab_Driver1` FOREIGN KEY (`Driver_id`) REFERENCES `Cab_Rental`.`Driver` (`Driver_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cab_Rental`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cab_Rental`.`Customer` (
  `Customer_id` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Email_id` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Create_Date` TIMESTAMP NULL,
  PRIMARY KEY (`Customer_id`),
  UNIQUE INDEX `Customer_id_UNIQUE` (`Customer_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cab_Rental`.`Drives_In`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cab_Rental`.`Drives_In` (
  `Customer_Customer_id` INT UNSIGNED NOT NULL,
  `Cab_Cab_id` INT UNSIGNED NOT NULL,
  `Last_ride_date` TIMESTAMP NULL,
  INDEX `fk_Drives_In_Customer1_idx` (`Customer_Customer_id` ASC),
  INDEX `fk_Drives_In_Cab1_idx` (`Cab_Cab_id` ASC),
  UNIQUE INDEX `Customer_Customer_id_UNIQUE` (`Customer_Customer_id` ASC),
  PRIMARY KEY (`Customer_Customer_id`),
  CONSTRAINT `fk_Drives_In_Customer1` FOREIGN KEY (`Customer_Customer_id`) REFERENCES `Cab_Rental`.`Customer` (`Customer_id`),
  CONSTRAINT `fk_Drives_In_Cab1` FOREIGN KEY (`Cab_Cab_id`) REFERENCES `Cab_Rental`.`Cab` (`Cab_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cab_Rental`.`Drives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cab_Rental`.`Drives` (
  `Driver_Driver_id` INT UNSIGNED NOT NULL,
  `Cab_id` INT UNSIGNED NOT NULL,
  `Driving_Since` TIMESTAMP NULL,
  PRIMARY KEY (`Driver_Driver_id`, `Cab_id`),
  INDEX `fk_Drives_Cab1_idx` (`Cab_id` ASC),
  UNIQUE INDEX `Cab_id_UNIQUE` (`Cab_id` ASC),
  UNIQUE INDEX `Driver_Driver_id_UNIQUE` (`Driver_Driver_id` ASC),
  CONSTRAINT `fk_Drives_Driver1` FOREIGN KEY (`Driver_Driver_id`) REFERENCES `Cab_Rental`.`Driver` (`Driver_id`),
  CONSTRAINT `fk_Drives_Cab1` FOREIGN KEY (`Cab_id`) REFERENCES `Cab_Rental`.`Cab` (`Cab_id`))
ENGINE = InnoDB;