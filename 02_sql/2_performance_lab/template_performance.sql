-- =======================================================
-- RETO 6: PERFORMANCE LAB
-- Estudiante: Juan Camilo Ortiz Ibañez
-- Fecha: 2026-01-16
-- =======================================================

USE RetoSQL;
GO

-- =======================================================
-- 1. MEDICIÓN DE PERFORMANCE (ANTES)
-- =======================================================

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

-- Consulta sin índices
SELECT 
    v.VentaID,
    v.Fecha,
    c.Nombre AS Cliente,
    c.Email,
    p.Nombre AS Producto,
    p.Precio,
    s.Nombre AS Sucursal,
    s.Ciudad
FROM Venta v
JOIN Cliente c ON v.ClienteID = c.ClienteID
JOIN Producto p ON v.ProductoID = p.ProductoID
JOIN Sucursal s ON v.SucursalID = s.SucursalID
WHERE c.Email LIKE '%@%';
GO

-- =======================================================
-- 2. CREACIÓN DE ÍNDICES
-- =======================================================

CREATE INDEX idx_cliente_email
ON Cliente(Email);

CREATE INDEX idx_venta_cliente
ON Venta(ClienteID);

CREATE INDEX idx_venta_producto
ON Venta(ProductoID);

CREATE INDEX idx_venta_sucursal
ON Venta(SucursalID);
GO

-- =======================================================
-- 3. MEDICIÓN DE PERFORMANCE (DESPUÉS)
-- =======================================================

-- Ejecutar la misma consulta después de crear índices
SELECT 
    v.VentaID,
    v.Fecha,
    c.Nombre AS Cliente,
    c.Email,
    p.Nombre AS Producto,
    p.Precio,
    s.Nombre AS Sucursal,
    s.Ciudad
FROM Venta v
JOIN Cliente c ON v.ClienteID = c.ClienteID
JOIN Producto p ON v.ProductoID = p.ProductoID
JOIN Sucursal s ON v.SucursalID = s.SucursalID
WHERE c.Email LIKE '%@%';
GO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO

/*
CONCLUSIÓN:
El CROSS JOIN genera un producto cartesiano que incrementa exponencialmente
el número de filas procesadas, causando altos costos de IO y CPU.
El INNER JOIN utiliza relaciones reales entre tablas, reduciendo
drásticamente las lecturas lógicas y mejorando el rendimiento.
*/
