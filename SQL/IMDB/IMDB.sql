-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Schema IMDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS IMDB;
CREATE SCHEMA IF NOT EXISTS `IMDB` DEFAULT CHARACTER SET utf8 ;
USE `IMDB` ;

-- -----------------------------------------------------
-- Table `IMDB`.`Actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMDB`.`Actors` (
  `Actors_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Sex` VARCHAR(45) NULL,
  `D.O.B` VARCHAR(45) NULL,
  PRIMARY KEY (`Actors_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMDB`.`Movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMDB`.`Movies` (
  `Movies_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Release_Date` DATE NULL,
  `Budget` INT NULL,
  `Actors_id` INT NOT NULL,
  PRIMARY KEY (`Movies_id`),
  CONSTRAINT `fk_Movies_Actors` FOREIGN KEY (`Actors_id`) REFERENCES `IMDB`.`Actors` (`Actors_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMDB`.`TV_series`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMDB`.`TV_series` (
  `TV_series_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Release_Date` DATE NULL,
  `Show_Time` TIME NULL,
  `Actors_id` INT NOT NULL,
  PRIMARY KEY (`TV_series_id`),
  CONSTRAINT `fk_TV_series_Actors1` FOREIGN KEY (`Actors_id`) REFERENCES `IMDB`.`Actors` (`Actors_id`))
ENGINE = InnoDB;