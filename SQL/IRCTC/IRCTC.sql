-- MySQL Workbench Forward Engineering

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
  `Schedule_Departure` DATETIME NULL,
  `Schedule_Arrival` DATETIME NULL,
  `Reservation_Status` VARCHAR(1) BINARY NULL DEFAULT 'U',
  `Date_Of_Booking` DATE NULL,
  `Price` INT NULL,
  `Customer_User_Id` INT NOT NULL,
  PRIMARY KEY (`PNR_No`),
  CONSTRAINT `fk_Ticket_Train` FOREIGN KEY (`Train_no`) REFERENCES `IRCTC`.`Train` (`Train_no`),
  CONSTRAINT `fk_Ticket_Customer1` FOREIGN KEY (`Customer_User_Id`) REFERENCES `IRCTC`.`Customer` (`User_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IRCTC`.`Travelling_In`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IRCTC`.`Travelling_In` (
  `Customer_User_Id` INT NOT NULL,
  `PNR_No` INT NOT NULL,
  `Starting_time` TIME NOT NULL,
  PRIMARY KEY (`Customer_User_Id`, `PNR_No`),
  UNIQUE INDEX `PNR_No_UNIQUE` (`PNR_No` ASC),
  CONSTRAINT `fk_Travelling_In_Customer1` FOREIGN KEY (`Customer_User_Id`) REFERENCES `IRCTC`.`Customer` (`User_Id`),
  CONSTRAINT `fk_Travelling_In_Ticket1` FOREIGN KEY (`PNR_No`) REFERENCES `IRCTC`.`Ticket` (`PNR_No`))
ENGINE = InnoDB;

USE `IRCTC`;

DELIMITER $$
USE `IRCTC`$$
CREATE DEFINER = CURRENT_USER TRIGGER `IRCTC`.`Reservation_check` BEFORE INSERT ON `Ticket` FOR EACH ROW
BEGIN
IF(new.Reservation_status = 'R' AND new.Train_no IS NULL) THEN
	SET new.PNR_No = NULL;
    END IF;
END$$

USE `IRCTC`$$
CREATE DEFINER = CURRENT_USER TRIGGER `IRCTC`.`Reservation_update_check` BEFORE UPDATE ON `Ticket` FOR EACH ROW
BEGIN
IF(new.Reservation_status = 'R' AND new.Train_no IS NULL) THEN
	SET new.PNR_No = NULL;
    END IF;
END$$

USE `IRCTC`$$
CREATE DEFINER = CURRENT_USER TRIGGER `IRCTC`.`Customer_check` BEFORE INSERT ON `Travelling_In` FOR EACH ROW
BEGIN
IF(SELECT Customer_User_Id, Starting_time 
	FROM Travelling_In
	WHERE Starting_time = new.Starting_time AND Customer_User_Id = new.Customer_User_Id) THEN
	SET new.PNR_No = NULL AND new.Customer_User_Id = NULL;
    END IF;
END$$

USE `IRCTC`$$
CREATE DEFINER = CURRENT_USER TRIGGER `IRCTC`.`Customer_update_check` BEFORE UPDATE ON `Travelling_In` FOR EACH ROW
BEGIN
IF(SELECT Customer_User_Id, Starting_time 
	FROM Travelling_In
	WHERE Starting_time = new.Starting_time AND Customer_User_Id = new.Customer_User_Id) THEN
	SET new.PNR_No = NULL AND new.Customer_User_Id = NULL;
    END IF;
END$$


DELIMITER ;