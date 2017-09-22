-- MySQL Workbench Forward Engineering

-- Driver - Drives Relation
-- Driver: Strong entity
-- Drives: Weak entity

-- Driver - Cab
-- Driver: Strong entity
-- Cab: Weak entity

-- Cab - Drives_In
-- Cab: Strong entity
-- Drives_In: Weak entity

-- Customer - Driver_In
-- Customer: Strong entity
-- Drives_In: Weak entity

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
  `Driver_id` INT UNSIGNED UNIQUE NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Sex(M/F)` VARCHAR(45) BINARY NULL DEFAULT 'M',
  `License_No` VARCHAR(45) UNIQUE NULL,
  `Date_of_Joining` TIMESTAMP NULL,
  PRIMARY KEY (`Driver_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cab_Rental`.`Cab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cab_Rental`.`Cab` (
  `Cab_id` INT UNSIGNED UNIQUE NOT NULL,
  `Model` VARCHAR(45) NULL,
  `Vehicle_registration_no` VARCHAR(45) NULL,
  `Date_of_Purchase` TIMESTAMP NULL,
  `Accessories` MEDIUMTEXT NULL,
  `Driver_id` INT UNSIGNED UNIQUE NOT NULL,
  PRIMARY KEY (`Cab_id`),
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
  `Ride_start_time` DATETIME NOT NULL,
  PRIMARY KEY (`Customer_Customer_id`, `Ride_start_time`),
  CONSTRAINT `fk_Drives_In_Customer1` FOREIGN KEY (`Customer_Customer_id`) REFERENCES `Cab_Rental`.`Customer` (`Customer_id`),
  CONSTRAINT `fk_Drives_In_Cab1` FOREIGN KEY (`Cab_Cab_id`) REFERENCES `Cab_Rental`.`Cab` (`Cab_id`))
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `Cab_Rental`.`Drives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cab_Rental`.`Drives` (
  `Driver_id` INT UNSIGNED UNIQUE NOT NULL,
  `Cab_id` INT UNSIGNED UNIQUE NOT NULL,
  `Driving_Since` TIMESTAMP NULL,
  PRIMARY KEY (`Driver_id`, `Cab_id`),
  CONSTRAINT `fk_Drives_Driver1` FOREIGN KEY (`Driver_id`) REFERENCES `Cab_Rental`.`Driver` (`Driver_id`),
  CONSTRAINT `fk_Drives_Cab1` FOREIGN KEY (`Cab_id`) REFERENCES `Cab_Rental`.`Cab` (`Cab_id`))
ENGINE = InnoDB;

USE `Cab_Rental`;

/*USING TRIGGER TO SATISFY THE CONDITION*/

DELIMITER $$
USE `Cab_Rental`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Cab_Rental`.`Drives_In_BEFORE_INSERT` BEFORE INSERT ON `Drives_In` FOR EACH ROW
BEGIN
IF (SELECT Ride_start_time 
	FROM Drives_In
	WHERE Ride_start_time = new.Ride_start_time) THEN
    set new.Ride_start_time = NULL;
END IF;

END$$

USE `Cab_Rental`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Cab_Rental`.`Drives_In_BEFORE_UPDATE` BEFORE UPDATE ON `Drives_In` FOR EACH ROW
BEGIN
IF (SELECT Ride_start_time 
	FROM Drives_In
	WHERE Ride_start_time = new.Ride_start_time) THEN
    set new.Ride_start_time = NULL;
END IF;
END$$


DELIMITER ;

