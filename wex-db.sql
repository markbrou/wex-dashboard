-- MySQL Script generated by MySQL Workbench
-- Mon Feb 26 15:48:56 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bio-con
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bio-con
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bio-con` DEFAULT CHARACTER SET utf8 ;
USE `bio-con` ;

-- -----------------------------------------------------
-- Table `bio-con`.`Article_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Article_Type` (
  `article_type_id` INT NOT NULL AUTO_INCREMENT,
  `article_type_description` VARCHAR(125) NULL,
  PRIMARY KEY (`article_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Relation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Relation` (
  `relation_id` INT NOT NULL AUTO_INCREMENT,
  `relation_name` VARCHAR(145) NULL,
  `address` VARCHAR(145) NULL,
  `city` VARCHAR(145) NULL,
  `postal` VARCHAR(6) NULL,
  `relation_type` TINYINT NULL,
  PRIMARY KEY (`relation_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Quality_Set`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Quality_Set` (
  `set_id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(20) NULL,
  `description` VARCHAR(150) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`set_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Composition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Composition` (
  `composition_id` INT NOT NULL AUTO_INCREMENT,
  `active` TINYINT NULL,
  PRIMARY KEY (`composition_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Article_Uom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Article_Uom` (
  `article_uom_id` INT NOT NULL AUTO_INCREMENT,
  `article_uom_description` VARCHAR(155) NULL,
  PRIMARY KEY (`article_uom_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Article` (
  `article_id` INT NOT NULL AUTO_INCREMENT,
  `article_code` VARCHAR(45) NULL,
  `article_name` VARCHAR(45) NULL,
  `minimum_stock_amount` INT NULL,
  `minimum_order_amount` INT NULL,
  `article_type_id` INT NOT NULL,
  `supplier` INT NOT NULL,
  `quality_set` INT NOT NULL,
  `composition_id` INT NOT NULL,
  `article_uom_id` INT NOT NULL,
  PRIMARY KEY (`article_id`, `article_type_id`, `supplier`, `quality_set`, `composition_id`, `article_uom_id`),
  INDEX `fk_Article_Article_Type_idx` (`article_type_id` ASC),
  INDEX `fk_Article_Relation1_idx` (`supplier` ASC),
  INDEX `fk_Article_Quality_Set1_idx` (`quality_set` ASC),
  INDEX `fk_Article_Composition1_idx` (`composition_id` ASC),
  INDEX `fk_Article_Article_Uom1_idx` (`article_uom_id` ASC),
  CONSTRAINT `fk_Article_Article_Type`
    FOREIGN KEY (`article_type_id`)
    REFERENCES `bio-con`.`Article_Type` (`article_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Relation1`
    FOREIGN KEY (`supplier`)
    REFERENCES `bio-con`.`Relation` (`relation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Quality_Set1`
    FOREIGN KEY (`quality_set`)
    REFERENCES `bio-con`.`Quality_Set` (`set_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Composition1`
    FOREIGN KEY (`composition_id`)
    REFERENCES `bio-con`.`Composition` (`composition_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Article_Uom1`
    FOREIGN KEY (`article_uom_id`)
    REFERENCES `bio-con`.`Article_Uom` (`article_uom_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Quality_Rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Quality_Rules` (
  `rule_id` INT NOT NULL AUTO_INCREMENT,
  `rule_description` VARCHAR(45) NULL,
  PRIMARY KEY (`rule_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Stock` (
  `stock_id` INT NOT NULL AUTO_INCREMENT,
  `stock_amount` INT NULL,
  `article_id` INT NOT NULL,
  PRIMARY KEY (`stock_id`, `article_id`),
  INDEX `fk_Stock_Article1_idx` (`article_id` ASC),
  CONSTRAINT `fk_Stock_Article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `bio-con`.`Article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`User_Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`User_Role` (
  `user_role_id` INT NOT NULL AUTO_INCREMENT,
  `user_role_description` VARCHAR(255) NULL,
  PRIMARY KEY (`user_role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(145) NULL,
  `user_password` VARCHAR(255) NULL,
  `first_name` VARCHAR(145) NULL,
  `last_name` VARCHAR(145) NULL,
  `user_role_id` INT NOT NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`user_id`, `user_role_id`),
  INDEX `fk_User_User_Role1_idx` (`user_role_id` ASC),
  CONSTRAINT `fk_User_User_Role1`
    FOREIGN KEY (`user_role_id`)
    REFERENCES `bio-con`.`User_Role` (`user_role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Article_Log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Article_Log` (
  `article_log_id` INT NOT NULL AUTO_INCREMENT,
  `log_description` VARCHAR(255) NULL,
  `user_id` INT NOT NULL,
  `article_id` INT NOT NULL,
  PRIMARY KEY (`article_log_id`, `user_id`, `article_id`),
  INDEX `fk_Article_Log_User1_idx` (`user_id` ASC),
  INDEX `fk_Article_Log_Article1_idx` (`article_id` ASC),
  CONSTRAINT `fk_Article_Log_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bio-con`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Log_Article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `bio-con`.`Article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Quality_Set_has_Quality_Rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Quality_Set_has_Quality_Rules` (
  `Quality_Set_set_id` INT NOT NULL,
  `Quality_Rules_rule_id` INT NOT NULL,
  PRIMARY KEY (`Quality_Set_set_id`, `Quality_Rules_rule_id`),
  INDEX `fk_Quality_Set_has_Quality_Rules_Quality_Rules1_idx` (`Quality_Rules_rule_id` ASC),
  INDEX `fk_Quality_Set_has_Quality_Rules_Quality_Set1_idx` (`Quality_Set_set_id` ASC),
  CONSTRAINT `fk_Quality_Set_has_Quality_Rules_Quality_Set1`
    FOREIGN KEY (`Quality_Set_set_id`)
    REFERENCES `bio-con`.`Quality_Set` (`set_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quality_Set_has_Quality_Rules_Quality_Rules1`
    FOREIGN KEY (`Quality_Rules_rule_id`)
    REFERENCES `bio-con`.`Quality_Rules` (`rule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Article_has_Composition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Article_has_Composition` (
  `composition_id` INT NOT NULL,
  `amount` INT NULL,
  `article_id` INT NOT NULL,
  PRIMARY KEY (`composition_id`, `article_id`),
  INDEX `fk_Article_has_Composition_Composition1_idx` (`composition_id` ASC),
  INDEX `fk_Article_has_Composition_Article1_idx` (`article_id` ASC),
  CONSTRAINT `fk_Article_has_Composition_Article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `bio-con`.`Article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_has_Composition_Composition1`
    FOREIGN KEY (`composition_id`)
    REFERENCES `bio-con`.`Composition` (`composition_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Order_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Order_Type` (
  `order_type_id` INT NOT NULL AUTO_INCREMENT,
  `order_type_code` VARCHAR(45) NULL,
  `order_type_description` VARCHAR(145) NULL,
  PRIMARY KEY (`order_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Order_Kind`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Order_Kind` (
  `order_kind_id` INT NOT NULL AUTO_INCREMENT,
  `order_kind_description` VARCHAR(145) NULL,
  PRIMARY KEY (`order_kind_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `relation_id` INT NOT NULL,
  `date` DATE NULL,
  `order_type` INT NOT NULL,
  `order_kind_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `relation_id`, `order_type`, `order_kind_id`),
  INDEX `fk_Order_Relation1_idx` (`relation_id` ASC),
  INDEX `fk_Order_Order_Type1_idx` (`order_type` ASC),
  INDEX `fk_Order_Order_Kind1_idx` (`order_kind_id` ASC),
  CONSTRAINT `fk_Order_Relation1`
    FOREIGN KEY (`relation_id`)
    REFERENCES `bio-con`.`Relation` (`relation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Order_Type1`
    FOREIGN KEY (`order_type`)
    REFERENCES `bio-con`.`Order_Type` (`order_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Order_Kind1`
    FOREIGN KEY (`order_kind_id`)
    REFERENCES `bio-con`.`Order_Kind` (`order_kind_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Order_has_Article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Order_has_Article` (
  `order_id` INT NOT NULL,
  `article_id` INT NOT NULL,
  `amount` INT NULL,
  PRIMARY KEY (`order_id`, `article_id`),
  INDEX `fk_Order_has_Article_Article1_idx` (`article_id` ASC),
  INDEX `fk_Order_has_Article_Order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_Order_has_Article_Order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `bio-con`.`Order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_Article_Article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `bio-con`.`Article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`Permissions` (
  `permission_id` INT NOT NULL AUTO_INCREMENT,
  `permission_description` VARCHAR(145) NULL,
  PRIMARY KEY (`permission_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bio-con`.`User_has_Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bio-con`.`User_has_Permissions` (
  `User_user_id` INT NOT NULL,
  `Permissions_permission_id` INT NOT NULL,
  PRIMARY KEY (`User_user_id`, `Permissions_permission_id`),
  INDEX `fk_User_has_Permissions_Permissions1_idx` (`Permissions_permission_id` ASC),
  INDEX `fk_User_has_Permissions_User1_idx` (`User_user_id` ASC),
  CONSTRAINT `fk_User_has_Permissions_User1`
    FOREIGN KEY (`User_user_id`)
    REFERENCES `bio-con`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Permissions_Permissions1`
    FOREIGN KEY (`Permissions_permission_id`)
    REFERENCES `bio-con`.`Permissions` (`permission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
