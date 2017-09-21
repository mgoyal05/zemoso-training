-- MySQL Workbench Forward Engineering

-- Employee - Project Relation
-- Employee: Strong entity
-- Project: Weak entity

-- Employee - Report_to Relation
-- Employee: Strong entity
-- Report_to: Weak entity

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
  CONSTRAINT `fk_Project_Employee1` FOREIGN KEY (`Project_Manager_id`) REFERENCES `Emp_Proj`.`Employee` (`Employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Emp_Proj`.`Report_to`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Emp_Proj`.`Report_to` (
  `Employee_id` INT UNSIGNED NOT NULL,
  `Manager_id` INT UNSIGNED NOT NULL,
  `Start_date` VARCHAR(45) NULL,
  PRIMARY KEY (`Employee_id`, `Manager_id`),
  UNIQUE INDEX `Employee_id_UNIQUE` (`Employee_id` ASC),
  CONSTRAINT `fk_Report_to_Employee1` FOREIGN KEY (`Employee_id`) REFERENCES `Emp_Proj`.`Employee` (`Employee_id`),
  CONSTRAINT `fk_Report_to_Employee2` FOREIGN KEY (`Manager_id`) REFERENCES `Emp_Proj`.`Employee` (`Employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Emp_Proj`.`Works_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Emp_Proj`.`Works_in` (
  `Employee_Employee_id` INT UNSIGNED NOT NULL,
  `Project_Project_id` INT UNSIGNED NOT NULL,
  `No_of_Employee` SMALLINT UNSIGNED NULL,
  `Project_joining_date` TIMESTAMP NULL,
  PRIMARY KEY (`Employee_Employee_id`),
  UNIQUE INDEX `Employee_Employee_id_UNIQUE` (`Employee_Employee_id` ASC),
  CONSTRAINT `fk_Works_in_Employee1` FOREIGN KEY (`Employee_Employee_id`) REFERENCES `Emp_Proj`.`Employee` (`Employee_id`),
  CONSTRAINT `fk_Works_in_Project1` FOREIGN KEY (`Project_Project_id`) REFERENCES `Emp_Proj`.`Project` (`Project_id`))