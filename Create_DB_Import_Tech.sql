-- DROP DATABASE IF  EXISTS DB_Import_Tech;

CREATE DATABASE IF NOT EXISTS DB_Import_Tech;

USE DB_Import_Tech;

-- DROP TABLE IF EXISTS Venta, Producto, Categoria, Direccion, Proveedor, Cliente;

-- -----------------------------------------------------
-- Table DB_Import_Tech.Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DB_Import_Tech.Cliente (
  NIP_Cliente VARCHAR(50) PRIMARY KEY NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  telefonos VARCHAR(55) NOT NULL,
  Direccion VARCHAR(20) NOT NULL
  );

-- -----------------------------------------------------
-- Tabla DB_Import_Tech.Proveedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DB_Import_Tech.Proveedor (
  NIP_Proveedor VARCHAR(50) PRIMARY KEY NOT NULL,
  NIT VARCHAR(45) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  web VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  Direccion VARCHAR(20) NOT NULL 
  );
  
-- -----------------------------------------------------
-- Table DB_Import_Tech.Direccion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DB_Import_Tech.Direccion(
	Direccion VARCHAR(20) PRIMARY KEY NOT NULL,
    ciudad VARCHAR(20)  NOT NULL,
    comuna VARCHAR(20)  NOT NULL,
    calle VARCHAR(20)  NOT NULL,
    numero VARCHAR(20)  NOT NULL,
    idCliente VARCHAR(50),
    idProveedor VARCHAR(50),
	FOREIGN KEY (idCliente) REFERENCES DB_Import_Tech.Cliente(NIP_Cliente),
	FOREIGN KEY (idProveedor) REFERENCES DB_Import_Tech.Proveedor(NIP_Proveedor)
);

-- -----------------------------------------------------
-- Table DB_Import_Tech.Categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DB_Import_Tech.Categoria (
  idCategoria VARCHAR(20) PRIMARY KEY NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  descripcion TEXT(150) NOT NULL
  );

-- -----------------------------------------------------
-- Tabla DB_Import_Tech.Producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DB_Import_Tech.Producto (
	idProducto VARCHAR(20) PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    precio FLOAT NOT NULL,
    stock INT NOT NULL,
	idProveedor VARCHAR(50) NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    FOREIGN KEY(idProveedor) REFERENCES DB_Import_Tech.Proveedor(NIP_Proveedor),
    FOREIGN KEY(categoria) REFERENCES DB_Import_Tech.Categoria(idCategoria)
);  
  
-- -----------------------------------------------------
-- Tabla DB_Import_Tech.Venta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DB_Import_Tech.Venta (
  numero_factura VARCHAR(20) PRIMARY KEY NOT NULL,
  fecha DATE NOT NULL,
  cant_producto INT NOT NULL,
  venta_unidad FLOAT NOT NULL,
  monto_total FLOAT NOT NULL,
  descuento FLOAT NOT NULL,
  monto_final FLOAT NOT NULL,
  idProducto VARCHAR(20) NOT NULL,
  idCliente VARCHAR(50) NOT NULL,
  FOREIGN KEY (idProducto) REFERENCES DB_Import_Tech.Producto(idProducto),
  FOREIGN KEY (idCliente) REFERENCES DB_Import_Tech.Cliente(NIP_Cliente)
  );
  
DESCRIBE categoria;

DESCRIBE cliente;

DESCRIBE proveedor;

DESCRIBE producto;

DESCRIBE direccion;

DESCRIBE venta;