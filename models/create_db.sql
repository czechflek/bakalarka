-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bachelors
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bachelors` ;

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
  `id` VARCHAR(40) NOT NULL,
  `username` VARCHAR(25) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_online` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` BIT NOT NULL DEFAULT 1,
  `health` INT NOT NULL DEFAULT 200,
  `experience` INT NOT NULL DEFAULT 0,
  `level` INT NOT NULL DEFAULT 1,
  `gold` INT NOT NULL DEFAULT 0,
  `gems` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC));


-- -----------------------------------------------------
-- Table `bachelors`.`game_object_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`game_object_type` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`game_object_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `ownable` BIT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`game_object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`game_object` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`game_object` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `count` INT NOT NULL DEFAULT 1,
  `root` BIT NOT NULL DEFAULT 1,
  `game_object_type_id` INT UNSIGNED NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_object_game_object_type1_idx` (`game_object_type_id` ASC),
  CONSTRAINT `fk_game_object_game_object_type1`
    FOREIGN KEY (`game_object_type_id`)
    REFERENCES `bachelors`.`game_object_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`location_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`location_type` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`location_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`location` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`location` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `latitude` DOUBLE NOT NULL,
  `longitude` DOUBLE NOT NULL,
  `game_object_id` INT UNSIGNED NULL,
  `location_type_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_game_object1_idx` (`game_object_id` ASC),
  INDEX `fk_location_location_type1_idx` (`location_type_id` ASC),
  CONSTRAINT `fk_location_game_object1`
    FOREIGN KEY (`game_object_id`)
    REFERENCES `bachelors`.`game_object` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_type1`
    FOREIGN KEY (`location_type_id`)
    REFERENCES `bachelors`.`location_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`attribute_key`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`attribute_key` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`attribute_key` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`game_object_type_attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`game_object_type_attribute` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`game_object_type_attribute` (
  `game_object_type_id` INT UNSIGNED NOT NULL,
  `attribute_key_id` INT UNSIGNED NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`game_object_type_id`, `attribute_key_id`),
  INDEX `fk_game_object_type_attribute_attribute_key1_idx` (`attribute_key_id` ASC),
  CONSTRAINT `fk_game_object_type_attribute_game_object_type1`
    FOREIGN KEY (`game_object_type_id`)
    REFERENCES `bachelors`.`game_object_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_object_type_attribute_attribute_key1`
    FOREIGN KEY (`attribute_key_id`)
    REFERENCES `bachelors`.`attribute_key` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bachelors`.`user_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`user_inventory` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`user_inventory` (
  `user_id` VARCHAR(40) NOT NULL,
  `game_object_type_id` INT UNSIGNED NOT NULL,
  `count` INT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`, `game_object_type_id`),
  INDEX `fk_userInventory_user1_idx` (`user_id` ASC),
  INDEX `fk_user_inventory_game_object_type1_idx` (`game_object_type_id` ASC),
  CONSTRAINT `fk_userInventory_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bachelors`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_inventory_game_object_type1`
    FOREIGN KEY (`game_object_type_id`)
    REFERENCES `bachelors`.`game_object_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bachelors`.`game_object_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bachelors`.`game_object_content` ;

CREATE TABLE IF NOT EXISTS `bachelors`.`game_object_content` (
  `parent_id` INT UNSIGNED NOT NULL,
  `child_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`parent_id`, `child_id`),
  INDEX `fk_game_object_has_game_object_game_object2_idx` (`child_id` ASC),
  INDEX `fk_game_object_has_game_object_game_object1_idx` (`parent_id` ASC),
  CONSTRAINT `fk_game_object_has_game_object_game_object1`
    FOREIGN KEY (`parent_id`)
    REFERENCES `bachelors`.`game_object` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_object_has_game_object_game_object2`
    FOREIGN KEY (`child_id`)
    REFERENCES `bachelors`.`game_object` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
