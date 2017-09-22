-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Schema Food Delivery
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Food Delivery`;
CREATE SCHEMA IF NOT EXISTS `Food Delivery` DEFAULT CHARACTER SET utf8 ;
USE `Food Delivery` ;

-- -----------------------------------------------------
-- Table `Food Delivery`.`Restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food Delivery`.`Restaurant` (
  `Restaurant_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Cuisine_Type` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Contact_no` INT NULL,
  PRIMARY KEY (`Restaurant_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food Delivery`.`Delivery person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food Delivery`.`Delivery person` (
  `Person_Id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Contact_no` INT NULL,
  `Joining_Date` DATE NULL,
  `No_of_Orders` SMALLINT NULL,
  PRIMARY KEY (`Person_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food Delivery`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food Delivery`.`Customer` (
  `Customer_Id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Contact_no` INT NULL,
  PRIMARY KEY (`Customer_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food Delivery`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food Delivery`.`Orders` (
  `Order_Id` INT NOT NULL,
  `Billing_Amount` INT NULL,
  `Address` VARCHAR(45) NULL,
  `Menu_Items` VARCHAR(45) NULL,
  `Time_of_Order` DATE NULL,
  `Delivery_Person_Id` INT NOT NULL,
  `Restaurant_Id` INT NOT NULL,
  `Customer_Id` INT NOT NULL,
  PRIMARY KEY (`Order_Id`),
  CONSTRAINT `fk_Order_Delivery person` FOREIGN KEY (`Delivery_Person_Id`) REFERENCES `Food Delivery`.`Delivery person` (`Person_Id`),
  CONSTRAINT `fk_Order_Restaurant1` FOREIGN KEY (`Restaurant_Id`) REFERENCES `Food Delivery`.`Restaurant` (`Restaurant_id`),
  CONSTRAINT `fk_Order_Customer1` FOREIGN KEY (`Customer_Id`) REFERENCES `Food Delivery`.`Customer` (`Customer_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food Delivery`.`Check_In`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food Delivery`.`Check_In` (
  `Check_In_Id` INT NOT NULL,
  `Customer_Id` INT NOT NULL,
  `Restaurant_id` INT NOT NULL,
  `Check_In_Time` TIME NULL,
  PRIMARY KEY (`Check_In_Id`),
  CONSTRAINT `fk_Check_In_Customer1` FOREIGN KEY (`Customer_Id`) REFERENCES `Food Delivery`.`Customer` (`Customer_Id`),
  CONSTRAINT `fk_Check_In_Restaurant1` FOREIGN KEY (`Restaurant_id`) REFERENCES `Food Delivery`.`Restaurant` (`Restaurant_id`))
ENGINE = InnoDB;

USE `Food Delivery`;

DELIMITER $$
USE `Food Delivery`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Food Delivery`.`Order_BEFORE_INSERT` BEFORE INSERT ON `Orders` FOR EACH ROW
BEGIN
IF(SELECT Order_Id
	FROM Orders
    WHERE Customer_Id = NEW.Customer_Id AND Restaurant_Id = NEW.Restaurant_Id AND Time_of_Order = NEW.Time_of_Order) THEN
    SET NEW.Order_Id = NULL;
    END IF;
END$$

USE `Food Delivery`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Food Delivery`.`Order_BEFORE_UPDATE` BEFORE UPDATE ON `Orders` FOR EACH ROW
BEGIN
IF(SELECT Order_Id
	FROM Orders
    WHERE Customer_Id = NEW.Customer_Id AND Restaurant_Id = NEW.Restaurant_Id AND Time_of_Order = NEW.Time_of_Order) THEN
    SET NEW.Order_Id = NULL;
    END IF;
END$$

USE `Food Delivery`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Food Delivery`.`Check_In_BEFORE_INSERT` BEFORE INSERT ON `Check_In` FOR EACH ROW
BEGIN
IF(SELECT Customer_Id
	FROM Check_In
    WHERE Check_In_Time = NEW.Check_In_Time) THEN
    SET NEW.Check_In_Id = NULL;
    END IF;
END$$

USE `Food Delivery`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Food Delivery`.`Check_In_BEFORE_UPDATE` BEFORE UPDATE ON `Check_In` FOR EACH ROW
BEGIN
IF(SELECT Customer_Id
	FROM Check_In
    WHERE Check_In_Time = NEW.Check_In_Time) THEN
    SET NEW.Check_In_Id = NULL;
    END IF;
END$$


DELIMITER ;