-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema IRCTC
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema IRCTC
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS IRCTC;
CREATE SCHEMA IF NOT EXISTS `IRCTC` DEFAULT CHARACTER SET utf8 ;
USE `IRCTC` ;

-- -----------------------------------------------------
-- Table `IRCTC`.`Train`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IRCTC`.`Train` (
  `Train_no` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Train_Type` VARCHAR(45) NULL,
  `Source` VARCHAR(45) NULL,
  `Destination` VARCHAR(45) NULL,
  `Travel_Time` TIMESTAMP NULL,
  PRIMARY KEY (`Train_no`),
  UNIQUE INDEX `Train_no_UNIQUE` (`Train_no` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IRCTC`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IRCTC`.`Customer` (
  `User_Id` INT NOT NULL,
  `First_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Mobile_No` INT UNSIGNED NULL,
  `Sex(M/F)` VARCHAR(1) NULL DEFAULT 'M',
  PRIMARY KEY (`User_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IRCTC`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IRCTC`.`Ticket` (
  `PNR_No` INT NOT NULL,
  `Train_no` INT UNSIGNED NULL,
  `Schedule_Departure` DATETIME,
  `Schedule_Arrival` DATETIME,
  `Reservation` VARCHAR(1) BINARY NULL DEFAULT 'U',
  `Date_Of_Booking` VARCHAR(1),
  `Price` INT,
  `Customer_User_Id` INT NOT NULL,
  PRIMARY KEY (`PNR_No`),
  CHECK(Schedule_Departure < Schedule_Arrival),
  CHECK((Reservation='U' AND train_id=null) OR (Reservation = 'R' AND train_id!=null)),
  CONSTRAINT `fk_Ticket_Train` FOREIGN KEY (`Train_no`) REFERENCES `IRCTC`.`Train` (`Train_no`),
  CONSTRAINT `fk_Ticket_Customer1` FOREIGN KEY (`Customer_User_Id`) REFERENCES `IRCTC`.`Customer` (`User_Id`))
ENGINE = InnoDB;
