-- MySQL Workbench Forward Engineering

-- Employee - Project Relation
-- Employee: Strong entity
-- Project: Weak entity

-- Employee - Report_to Relation
-- Employee: Strong entity
-- Report_to: Weak entity

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Emp_Proj
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS Emp_Proj;
CREATE SCHEMA IF NOT EXISTS `Emp_Proj` DEFAULT CHARACTER SET utf8 ;
USE `Emp_Proj` ;

-- -----------------------------------------------------
-- Table `Emp_Proj`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Emp_Proj`.`Employee` (
  `Employee_id` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Designation` VARCHAR(45) NULL,
  `Sex(M/F)` VARCHAR(45) BINARY NOT NULL DEFAULT 'M',
  `DOJ` VARCHAR(45) NULL,
  `Email_address` VARCHAR(45) NULL,
  PRIMARY KEY (`Employee_id`),
  UNIQUE INDEX `Employee_id_UNIQUE` (`Employee_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Emp_Proj`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Emp_Proj`.`Project` (
  `Project_id` INT UNSIGNED NOT NULL,
  `Title` VARCHAR(45) NULL,
  `Starting_date` VARCHAR(45) NULL,
  `Budget` INT NULL,
  `Project_Manager_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Project_id`),
  UNIQUE INDEX `idProject_UNIQUE` (`Project_id` ASC),
  INDEX `fk_Project_Employee1_idx` (`Project_Manager_id` ASC),
  CONSTRAINT `fk_Project_Employee1`
    FOREIGN KEY (`Project_Manager_id`)
    REFERENCES `Emp_Proj`.`Employee` (`Employee_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Emp_Proj`.`Report_to`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Emp_Proj`.`Report_to` (
  `Employee_id` INT UNSIGNED NOT NULL,
  `Manager_id` INT UNSIGNED NOT NULL,
  `Start_date` VARCHAR(45) NULL,
  PRIMARY KEY (`Employee_id`, `Manager_id`),
  INDEX `fk_Report_to_Employee1_idx` (`Employee_id` ASC),
  UNIQUE INDEX `Employee_id_UNIQUE` (`Employee_id` ASC),
  INDEX `fk_Report_to_Employee2_idx` (`Manager_id` ASC),
  CONSTRAINT `fk_Report_to_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `Emp_Proj`.`Employee` (`Employee_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Report_to_Employee2`
    FOREIGN KEY (`Manager_id`)
    REFERENCES `Emp_Proj`.`Employee` (`Employee_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Emp_Proj`.`Project_Emp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Emp_Proj`.`Project_Emp` (
  `Employee_id` INT UNSIGNED NOT NULL,
  `Project_id` INT UNSIGNED NOT NULL,
  `No_of_Employee` SMALLINT UNSIGNED NULL,
  `Project_joining_date` TIMESTAMP NULL,
  PRIMARY KEY (`Employee_id`, `Project_id`),
  INDEX `fk_Project_Emp_Project1_idx` (`Project_id` ASC),
  UNIQUE INDEX `Employee_id_UNIQUE` (`Employee_id` ASC),
  CONSTRAINT `fk_Project_Emp_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `Emp_Proj`.`Employee` (`Employee_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Project_Emp_Project1`
    FOREIGN KEY (`Project_id`)
    REFERENCES `Emp_Proj`.`Project` (`Project_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
