-- =======================================================
-- RETO PARTE A: DISEÑO DEL ESQUEMA RELACIONAL
-- Estudiante: Juan Camilo Ortiz Ibañez
-- Fecha: 2026-01-16
-- =======================================================

CREATE DATABASE RetoSQL;
GO

USE RetoSQL;
GO

-- =======================================================
-- 1. TABLAS MAESTRAS
-- =======================================================

CREATE TABLE Cliente (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Producto (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE Sucursal (
    SucursalID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL
);

-- =======================================================
-- 2. TABLA TRANSACCIONAL
-- =======================================================

CREATE TABLE Venta (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),

    ClienteID INT NOT NULL,
    ProductoID INT NOT NULL,
    SucursalID INT NOT NULL,

    CONSTRAINT FK_Venta_Cliente
        FOREIGN KEY (ClienteID)
        REFERENCES Cliente(ClienteID),

    CONSTRAINT FK_Venta_Producto
        FOREIGN KEY (ProductoID)
        REFERENCES Producto(ProductoID),

    CONSTRAINT FK_Venta_Sucursal
        FOREIGN KEY (SucursalID)
        REFERENCES Sucursal(SucursalID)
);



