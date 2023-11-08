-- MySQL Script generated by MySQL Workbench
-- Tue Sep 27 23:14:09 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DB_Import_Tech
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DB_Import_Tech
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DB_Import_Tech` DEFAULT CHARACTER SET utf8 ;
USE `DB_Import_Tech` ;

-- -----------------------------------------------------
-- Table `DB_Import_Tech`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Import_Tech`.`Venta` (
  `numero_factura` VARCHAR(20) NOT NULL,
  `fecha` DATE NOT NULL,
  `cant_producto` INT NOT NULL,
  `monto_total` FLOAT NOT NULL,
  `descuento` FLOAT NOT NULL,
  `monto_final` FLOAT NOT NULL,
  PRIMARY KEY (`numero_factura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Import_Tech`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Import_Tech`.`Proveedor` (
  `NIP_Proveedor` VARCHAR(50) NOT NULL,
  `NIT` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `web` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NIP_Proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Import_Tech`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Import_Tech`.`Cliente` (
  `NIP_Cliente` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefonos` VARCHAR(50) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NIP_Cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Import_Tech`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Import_Tech`.`Categoria` (
  `idCategoria` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT(150) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Import_Tech`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Import_Tech`.`Producto` (
  `idProducto` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `stock` INT NOT NULL,
  `idCategoria` VARCHAR(20) NOT NULL,
  `NIP_Proveedor` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idProducto`, `idCategoria`, `NIP_Proveedor`),
  INDEX `fk_Producto_Categoria_idx` (`idCategoria` ASC) VISIBLE,
  INDEX `fk_Producto_Proveedor1_idx` (`NIP_Proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Categoria`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `DB_Import_Tech`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Proveedor1`
    FOREIGN KEY (`NIP_Proveedor`)
    REFERENCES `DB_Import_Tech`.`Proveedor` (`NIP_Proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Import_Tech`.`Direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Import_Tech`.`Direccion` (
  `idDireccion` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `comuna` VARCHAR(45) NOT NULL,
  `NIP_Proveedor` VARCHAR(50) NOT NULL,
  `NIP_Cliente` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idDireccion`, `NIP_Proveedor`, `NIP_Cliente`),
  INDEX `fk_Direccion_Proveedor1_idx` (`NIP_Proveedor` ASC) VISIBLE,
  INDEX `fk_Direccion_Cliente1_idx` (`NIP_Cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Direccion_Proveedor1`
    FOREIGN KEY (`NIP_Proveedor`)
    REFERENCES `DB_Import_Tech`.`Proveedor` (`NIP_Proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Direccion_Cliente1`
    FOREIGN KEY (`NIP_Cliente`)
    REFERENCES `DB_Import_Tech`.`Cliente` (`NIP_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Import_Tech`.`Producto_has_Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Import_Tech`.`Producto_has_Venta` (
  `idProducto` VARCHAR(20) NOT NULL,
  `numero_factura` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idProducto`, `numero_factura`),
  INDEX `fk_Producto_has_Venta_Venta1_idx` (`numero_factura` ASC) VISIBLE,
  INDEX `fk_Producto_has_Venta_Producto1_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_has_Venta_Producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `DB_Import_Tech`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Venta_Venta1`
    FOREIGN KEY (`numero_factura`)
    REFERENCES `DB_Import_Tech`.`Venta` (`numero_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Import_Tech`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Import_Tech`.`Compras` (
  `numero_factura` VARCHAR(20) NOT NULL,
  `NIP_Cliente` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`numero_factura`, `NIP_Cliente`),
  INDEX `fk_Venta_has_Cliente_Cliente1_idx` (`NIP_Cliente` ASC) VISIBLE,
  INDEX `fk_Venta_has_Cliente_Venta1_idx` (`numero_factura` ASC) VISIBLE,
  CONSTRAINT `fk_Venta_has_Cliente_Venta1`
    FOREIGN KEY (`numero_factura`)
    REFERENCES `DB_Import_Tech`.`Venta` (`numero_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_has_Cliente_Cliente1`
    FOREIGN KEY (`NIP_Cliente`)
    REFERENCES `DB_Import_Tech`.`Cliente` (`NIP_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;