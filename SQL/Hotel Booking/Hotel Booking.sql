-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Schema Hotel Booking
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Hotel Booking`;
CREATE SCHEMA IF NOT EXISTS `Hotel Booking` DEFAULT CHARACTER SET utf8 ;
USE `Hotel Booking` ;

-- -----------------------------------------------------
-- Table `Hotel Booking`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel Booking`.`Customer` (
  `Customer_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Sex` VARCHAR(45) NULL,
  `Contact_no` VARCHAR(45) NULL,
  `Email_id` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`Customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel Booking`.`Hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel Booking`.`Hotel` (
  `Hotel_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Email_id` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Owner_name` VARCHAR(45) NULL,
  `Rating` VARCHAR(45) NULL,
  `No_of_Rooms` SMALLINT NULL,
  PRIMARY KEY (`Hotel_id`),
  UNIQUE INDEX `Hotel_id_UNIQUE` (`Hotel_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel Booking`.`Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel Booking`.`Booking` (
  `Booking_id` VARCHAR(45) UNIQUE NOT NULL,
  `Customer_id` INT NOT NULL,
  `Hotel_id` INT NOT NULL,
  `Loyal_Customer` TINYINT(1) NOT NULL DEFAULT 0,
  `Booking_Time` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Booking_id`),
  CONSTRAINT `fk_Having_Hotel` FOREIGN KEY (`Hotel_id`) REFERENCES `Hotel Booking`.`Hotel` (`Hotel_id`),
  CONSTRAINT `fk_Having_Customer1` FOREIGN KEY (`Customer_id`) REFERENCES `Hotel Booking`.`Customer` (`Customer_id`))
ENGINE = InnoDB;

USE `Hotel Booking`;

DELIMITER $$
USE `Hotel Booking`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Hotel Booking`.`Booking_Customer_Insert` BEFORE INSERT ON `Booking` FOR EACH ROW
BEGIN
IF(SELECT Booking_id
	FROM Booking
    WHERE Customer_id = NEW.Customer_id AND Hotel_id = NEW.Hotel_id) THEN
    SET NEW.Loyal_Customer = 1;
    END IF;
IF(SELECT Booking_id
	FROM Booking
    WHERE Customer_id = NEW.Customer_id AND Hotel_id = NEW.Hotel_id AND Booking_Time = NEW.Booking_Time) THEN
    SET NEW.Booking_id = NULL;
    END IF;
END$$

USE `Hotel Booking`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Hotel Booking`.`Booking_Customer_Update` BEFORE UPDATE ON `Booking` FOR EACH ROW
BEGIN
IF(SELECT Booking_id
	FROM Booking
    WHERE Customer_id = NEW.Customer_id AND Hotel_id = NEW.Hotel_id) THEN
    SET NEW.Loyal_Customer = 1;
    END IF;
IF(SELECT Booking_id
	FROM Booking
    WHERE Customer_id = NEW.Customer_id AND Hotel_id = NEW.Hotel_id AND Booking_Time = NEW.Booking_Time) THEN
    SET NEW.Booking_id = NULL;
    END IF;
END$$


DELIMITER ;