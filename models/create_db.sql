-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bachelors
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bachelors
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bachelors` DEFAULT CHARACTER SET utf8 ;
USE `bachelors` ;

-- -----------------------------------------------------
-- Table `bachelors`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`user` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` VARCHAR(20) NOT NULL,
  `username` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(255) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `last_online` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` TINYINT NULL DEFAULT 1,
  `health` INT NULL DEFAULT 200,
  `experience` INT NULL DEFAULT 0,
  `level` INT NULL DEFAULT 1,
  `gold` INT NULL DEFAULT 0,
  `gems` INT NULL DEFAULT 0,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idString_UNIQUE` (`userId` ASC));


-- -----------------------------------------------------
-- Table `bachelors`.`gameObjectType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`gameObjectType` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`gameObjectType` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `ownable` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`gameObject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`gameObject` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`gameObject` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` INT UNSIGNED NOT NULL,
  `count` INT NOT NULL DEFAULT 1,
  `gameObjectType_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_gameObject_gameObject1_idx` (`parent_id` ASC),
  INDEX `fk_gameObject_gameObjectType1_idx` (`gameObjectType_id` ASC),
  CONSTRAINT `fk_gameObject_gameObject1`
    FOREIGN KEY (`parent_id`)
    REFERENCES `bachelors`.`gameObject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gameObject_gameObjectType1`
    FOREIGN KEY (`gameObjectType_id`)
    REFERENCES `bachelors`.`gameObjectType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`locationType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`locationType` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`locationType` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`location` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`location` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `lat` DOUBLE NOT NULL,
  `lon` DOUBLE NOT NULL,
  `areacode` VARCHAR(10) NOT NULL,
  `gameObject_id` INT UNSIGNED NOT NULL,
  `locationType_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_gameObject1_idx` (`gameObject_id` ASC),
  INDEX `fk_location_locationType1_idx` (`locationType_id` ASC),
  CONSTRAINT `fk_location_gameObject1`
    FOREIGN KEY (`gameObject_id`)
    REFERENCES `bachelors`.`gameObject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_locationType1`
    FOREIGN KEY (`locationType_id`)
    REFERENCES `bachelors`.`locationType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`attributeKey`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`attributeKey` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`attributeKey` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`gameObjectTypeAttribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`gameObjectTypeAttribute` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`gameObjectTypeAttribute` (
  `gameObjectType_id` INT UNSIGNED NOT NULL,
  `attributeKey_id` INT UNSIGNED NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`gameObjectType_id`, `attributeKey_id`),
  INDEX `fk_gameObjectDefaultAttribute_gameObjectType1_idx` (`gameObjectType_id` ASC),
  INDEX `fk_gameObjectTypeAttribute_attributeKey1_idx` (`attributeKey_id` ASC),
  CONSTRAINT `fk_gameObjectDefaultAttribute_gameObjectType1`
    FOREIGN KEY (`gameObjectType_id`)
    REFERENCES `bachelors`.`gameObjectType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gameObjectTypeAttribute_attributeKey1`
    FOREIGN KEY (`attributeKey_id`)
    REFERENCES `bachelors`.`attributeKey` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`userInventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`userInventory` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`userInventory` (
  `user_id` INT UNSIGNED NOT NULL,
  `item_id` INT UNSIGNED NOT NULL,
  `count` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`, `item_id`),
  INDEX `fk_user_has_gameObjectType_gameObjectType1_idx` (`item_id` ASC),
  INDEX `fk_user_has_gameObjectType_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_gameObjectType_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bachelors`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_gameObjectType_gameObjectType1`
    FOREIGN KEY (`item_id`)
    REFERENCES `bachelors`.`gameObjectType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
