-- -----------------------------------------------------
-- Schema Paytm
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Paytm`;
CREATE SCHEMA IF NOT EXISTS `Paytm` DEFAULT CHARACTER SET utf8 ;
USE `Paytm` ;

-- -----------------------------------------------------
-- Table `Paytm`.`Branches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Paytm`.`Branches` (
  `Branch_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Manager` VARCHAR(45) NULL,
  `Contact_no` INT NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`Branch_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Paytm`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Paytm`.`Customer` (
  `Customer_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Sex` VARCHAR(45) NULL,
  `Contact_no` INT NULL,
  `Email_id` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Account_Id` INT NOT NULL COMMENT '	',
  PRIMARY KEY (`Customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Paytm`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Paytm`.`Account` (
  `Account_id` INT NOT NULL,
  `Opening_balance` INT NULL,
  `Date_opened` DATE NULL,
  `Interest` DOUBLE NULL,
  `Current_balance` INT NULL,
  `Branch_id` INT NOT NULL,
  `Customer_id` INT NOT NULL,
  PRIMARY KEY (`Account_id`, `Customer_id`),
  CONSTRAINT `fk_Account_Branches` FOREIGN KEY (`Branch_id`) REFERENCES `Paytm`.`Branches` (`Branch_id`),
  CONSTRAINT `fk_Account_Customer1` FOREIGN KEY (`Customer_id`) REFERENCES `Paytm`.`Customer` (`Customer_id`))
ENGINE = InnoDB;


USE `Paytm`;

DELIMITER $$
USE `Paytm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Account_BEFORE_INSERT` BEFORE INSERT ON `Account` FOR EACH ROW
BEGIN
IF(SELECT Account_id
	FROM Account
    WHERE Customer_id = NEW.Customer_id AND Branch_id = NEW.Branch_id) THEN
    SET NEW.Account_id = NULL;
    END IF;
END$$

USE `Paytm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Account_BEFORE_UPDATE` BEFORE UPDATE ON `Account` FOR EACH ROW
BEGIN
IF(SELECT Account_id
	FROM Account
    WHERE Customer_id = NEW.Customer_id AND Branch_id = NEW.Branch_id) THEN
    SET NEW.Account_id = NULL;
    END IF;
END$$


DELIMITER ;
