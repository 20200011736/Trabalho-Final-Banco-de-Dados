-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`fazenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fazenda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `area` FLOAT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `poligono` POLYGON NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`municipio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `poligono` POLYGON NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`zona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `perimetro` POLYGON NULL,
  `id_municipio` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Zona_Municipio1_idx` (`id_municipio` ASC) VISIBLE,
  CONSTRAINT `fk_Zona_Municipio1`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `mydb`.`municipio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`urbano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`urbano` (
  `area` VARCHAR(45) NULL,
  `id_zona` INT NOT NULL,
  PRIMARY KEY (`id_zona`),
  INDEX `fk_Urbano_Zona1_idx` (`id_zona` ASC) VISIBLE,
  CONSTRAINT `fk_Urbano_Zona1`
    FOREIGN KEY (`id_zona`)
    REFERENCES `mydb`.`zona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rural`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rural` (
  `id_zona` INT NOT NULL,
  `itr` VARCHAR(45) NULL,
  PRIMARY KEY (`id_zona`),
  INDEX `fk_Rural_Zona1_idx` (`id_zona` ASC) VISIBLE,
  CONSTRAINT `fk_Rural_Zona1`
    FOREIGN KEY (`id_zona`)
    REFERENCES `mydb`.`zona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gleba`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gleba` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_rural_zona` INT NOT NULL,
  `nome` VARCHAR(100) NULL,
  `poligono` POLYGON NULL,
  `rgi` VARCHAR(15) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Gleba_Rural1_idx` (`id_rural_zona` ASC) VISIBLE,
  CONSTRAINT `fk_Gleba_Rural1`
    FOREIGN KEY (`id_rural_zona`)
    REFERENCES `mydb`.`rural` (`id_zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(100) NULL,
  `cidade` VARCHAR(100) NULL,
  `logradouro` VARCHAR(250) NOT NULL,
  `bairro` VARCHAR(80) NOT NULL,
  `complemento` VARCHAR(50) NULL,
  `numero` VARCHAR(10) NULL,
  `cep` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`documento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `arquivo` VARCHAR(320) NULL,
  `data` DATE NOT NULL,
  `hora` TIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Arquivo_UNIQUE` (`arquivo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lote` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `poligono` POLYGON NOT NULL,
  `area` REAL NOT NULL,
  `codigo` VARCHAR(10) NULL,
  `situacao` VARCHAR(10) NULL,
  `Equipe` VARCHAR(20) NULL,
  `id_gleba` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `id_documento` INT NOT NULL,
  `sede` POINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_Lote_Gleba1_idx` (`id_gleba` ASC) VISIBLE,
  INDEX `fk_Lote_Endereco1_idx` (`id_endereco` ASC) VISIBLE,
  INDEX `fk_Lote_Documento1_idx` (`id_documento` ASC) VISIBLE,
  CONSTRAINT `fk_Lote_Gleba1`
    FOREIGN KEY (`id_gleba`)
    REFERENCES `mydb`.`gleba` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lote_Endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `mydb`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lote_Documento1`
    FOREIGN KEY (`id_documento`)
    REFERENCES `mydb`.`documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(320) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `CPF_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ocupante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ocupante` (
  `id` INT NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `rg` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(12) NULL,
  UNIQUE INDEX `RG_UNIQUE` (`rg` ASC) VISIBLE,
  UNIQUE INDEX `Telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_Ocupante_Pessoa_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Ocupante_Pessoa`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id` INT NOT NULL,
  `cargo` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(12) NOT NULL,
  `data_acesso` DATE NOT NULL,
  `foto` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Usuario_Pessoa1_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Pessoa1`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_documento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sigla` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fazenda_municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fazenda_municipio` (
  `id_fazenda` INT NOT NULL,
  `id_municipio` INT NOT NULL,
  PRIMARY KEY (`id_fazenda`, `id_municipio`),
  INDEX `fk_Fazenda_has_Municipio_Municipio1_idx` (`id_municipio` ASC) VISIBLE,
  INDEX `fk_Fazenda_has_Municipio_Fazenda1_idx` (`id_fazenda` ASC) VISIBLE,
  CONSTRAINT `fk_Fazenda_has_Municipio_Fazenda1`
    FOREIGN KEY (`id_fazenda`)
    REFERENCES `mydb`.`fazenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fazenda_has_Municipio_Municipio1`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `mydb`.`municipio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Documento_has_Tipo_documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Documento_has_Tipo_documento` (
  `id_documento` INT NOT NULL,
  `id_tipo_documento` INT NOT NULL,
  PRIMARY KEY (`id_documento`, `id_tipo_documento`),
  INDEX `fk_Documento_has_Tipo_documento_Tipo_documento1_idx` (`id_tipo_documento` ASC) VISIBLE,
  INDEX `fk_Documento_has_Tipo_documento_Documento1_idx` (`id_documento` ASC) VISIBLE,
  CONSTRAINT `fk_Documento_has_Tipo_documento_Documento1`
    FOREIGN KEY (`id_documento`)
    REFERENCES `mydb`.`documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Documento_has_Tipo_documento_Tipo_documento1`
    FOREIGN KEY (`id_tipo_documento`)
    REFERENCES `mydb`.`tipo_documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ocupante_lote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ocupante_lote` (
  `id_cupante` INT NOT NULL,
  `id_lote` INT NOT NULL,
  PRIMARY KEY (`id_cupante`, `id_lote`),
  INDEX `fk_Ocupante_has_Lote_Lote1_idx` (`id_lote` ASC) VISIBLE,
  INDEX `fk_Ocupante_has_Lote_Ocupante1_idx` (`id_cupante` ASC) VISIBLE,
  CONSTRAINT `fk_Ocupante_has_Lote_Ocupante1`
    FOREIGN KEY (`id_cupante`)
    REFERENCES `mydb`.`ocupante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ocupante_has_Lote_Lote1`
    FOREIGN KEY (`id_lote`)
    REFERENCES `mydb`.`lote` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
