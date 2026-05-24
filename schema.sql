-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydbnome
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_pet_vida
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_pet_vida
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_pet_vida` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_pet_vida` ;

-- -----------------------------------------------------
-- Table `db_pet_vida`.`especies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pet_vida`.`especies` (
  `id_especies` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_especies`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_pet_vida`.`tutores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pet_vida`.`tutores` (
  `id_tutores` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tutores`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_pet_vida`.`animais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pet_vida`.`animais` (
  `id_animais` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `especies_id_especies` INT UNSIGNED NOT NULL,
  `raca` VARCHAR(30) NULL DEFAULT NULL,
  `data_nascimento` DATE NULL DEFAULT NULL,
  `tutores_id_tutores` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_animais`),
  INDEX `fk_animais_tutores1_idx` (`tutores_id_tutores` ASC) VISIBLE,
  INDEX `fk_animais_especies1_idx` (`especies_id_especies` ASC) VISIBLE,
  INDEX `tutor_id` (`tutores_id_tutores`) VISIBLE,
  CONSTRAINT `fk_animais_especies1`
    FOREIGN KEY (`especies_id_especies`)
    REFERENCES `db_pet_vida`.`especies` (`id_especies`),
  CONSTRAINT `fk_animais_tutores1`
    FOREIGN KEY (`tutores_id_tutores`)
    REFERENCES `db_pet_vida`.`tutores` (`id_tutores`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_pet_vida`.`veterinarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pet_vida`.`veterinarios` (
  `id_veterinarios` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `crmv` VARCHAR(20) NOT NULL,
  `especialidade` VARCHAR(45) NULL DEFAULT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id_veterinarios`),
  UNIQUE INDEX `crmv_UNIQUE` (`crmv` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_pet_vida`.`consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pet_vida`.`consultas` (
  `id_consultas` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `animais_id_animais` INT UNSIGNED NOT NULL,
  `veterinarios_id_veterinarios` INT UNSIGNED NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `diagnostico` VARCHAR(45) NULL DEFAULT NULL,
  `valor` DECIMAL(10,2) UNSIGNED NOT NULL,
  `status` ENUM('agendada', 'em_atendimento', 'concluida', 'cancelada') NOT NULL,
  PRIMARY KEY (`id_consultas`),
  INDEX `fk_consultas_animais_idx` (`animais_id_animais` ASC) VISIBLE,
  INDEX `fk_consultas_veterinarios1_idx` (`veterinarios_id_veterinarios` ASC) VISIBLE,
  INDEX `data_hora` (`data_hora`) VISIBLE,
  CONSTRAINT `fk_consultas_animais`
    FOREIGN KEY (`animais_id_animais`)
    REFERENCES `db_pet_vida`.`animais` (`id_animais`),
  CONSTRAINT `fk_consultas_veterinarios1`
    FOREIGN KEY (`veterinarios_id_veterinarios`)
    REFERENCES `db_pet_vida`.`veterinarios` (`id_veterinarios`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_pet_vida`.`pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pet_vida`.`pagamentos` (
  `id_pagamentos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `consultas_id_consultas` INT UNSIGNED NOT NULL,
  `valor_pago` DECIMAL(10,2) UNSIGNED NOT NULL,
  `forma_pagamento` ENUM('pix', 'cartao', 'dinheiro', 'convênio') NOT NULL,
  `data_pagamento` DATETIME NOT NULL,
  `status` ENUM('pago', 'pendente', 'cancelado') NOT NULL,
  PRIMARY KEY (`id_pagamentos`),
  INDEX `fk_pagamentos_consultas1_idx` (`consultas_id_consultas` ASC) VISIBLE,
  CONSTRAINT `fk_pagamentos_consultas1`
    FOREIGN KEY (`consultas_id_consultas`)
    REFERENCES `db_pet_vida`.`consultas` (`id_consultas`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
