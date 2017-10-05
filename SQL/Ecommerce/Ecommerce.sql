-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Ecommerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Ecommerce`;
CREATE SCHEMA IF NOT EXISTS `Ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `Ecommerce` ;

-- -----------------------------------------------------
-- Table `Ecommerce`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Supplier` (
  `Supplier_id` INT NOT NULL,
  `CompanyName` VARCHAR(45) NULL,
  `ContactName` VARCHAR(45) NULL,
  `Phone` INT NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`Supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Customer` (
  `Customer_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL COMMENT '	',
  `Sex` VARCHAR(45) NULL,
  `Contact_no` VARCHAR(45) NULL,
  `Email_id` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`Customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Orders` (
  `Order_id` INT NOT NULL,
  `OrderDate` DATE NULL,
  `ShippedDate` DATE NULL,
  `Freight` VARCHAR(45) NULL,
  `Customer_id` INT NOT NULL,
  PRIMARY KEY (`Order_id`),
  CONSTRAINT `fk_Order_Customer1` FOREIGN KEY (`Customer_id`) REFERENCES `Ecommerce`.`Customer` (`Customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Items` (
  `Item_id` INT NOT NULL,
  `Item_name` VARCHAR(45) NULL,
  `Unit_Price` INT NULL,
  `Units_on_Stock` INT NULL,
  `Item_category` VARCHAR(45) NULL,
  `Supplier_id` INT NOT NULL,
  `Orders_id` INT NOT NULL,
  PRIMARY KEY (`Item_id`, `Orders_id`, `Supplier_id`),
  CONSTRAINT `fk_Items_Supplier` FOREIGN KEY (`Supplier_id`) REFERENCES `Ecommerce`.`Supplier` (`Supplier_id`),
  CONSTRAINT `fk_Items_Orders1` FOREIGN KEY (`Orders_id`) REFERENCES `Ecommerce`.`Orders` (`Order_id`))
ENGINE = InnoDB;

USE `Ecommerce`;

DELIMITER $$
USE `Ecommerce`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Ecommerce`.`Orders_BEFORE_INSERT` BEFORE INSERT ON `Orders` FOR EACH ROW
BEGIN
IF(SELECT Order_id
	FROM Orders
    WHERE Customer_id = NEW.Customer_id AND OrderDate = NEW.OrderDate) THEN
    SET NEW.Order_id = NULL;
    END IF;
END$$

USE `Ecommerce`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Ecommerce`.`Orders_BEFORE_UPDATE` BEFORE UPDATE ON `Orders` FOR EACH ROW
BEGIN
IF(SELECT Order_id
	FROM Orders
    WHERE Customer_id = NEW.Customer_id AND OrderDate = NEW.OrderDate) THEN
    SET NEW.Order_id = NULL;
    END IF;
END$$


DELIMITER ;