-- ============================================================================
-- consultas_analisis.sql
-- Consultas de analisis de negocio para el e-commerce "Sano y Fresco",
-- organizadas de lo general a lo especifico: ventas y tendencia, productos
-- y secciones, y comportamiento de clientes y pedidos.
-- Sintaxis SQLite (usa strftime para fechas).
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 0. Entendiendo los datos
-- Pregunta: ¿Que datos contiene la tabla a analizar?
-- ----------------------------------------------------------------------------
SELECT *
FROM tickets
LIMIT 100;


-- ============================================================================
-- VENTAS Y TENDENCIA
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Vision General de Ventas Totales
-- Pregunta: ¿Cual es el ingreso total generado por el negocio?
-- ----------------------------------------------------------------------------
SELECT SUM(precio_total) AS ingreso_total
FROM tickets;

-- ----------------------------------------------------------------------------
-- 2. Tendencias de Ventas en el Tiempo
-- Pregunta: ¿Como ha sido la tendencia de ingresos mensuales?
-- ----------------------------------------------------------------------------
SELECT strftime('%Y-%m', fecha) AS mes, SUM(precio_total) AS ingreso_mensual
FROM tickets
GROUP BY mes
ORDER BY mes;


-- ============================================================================
-- PRODUCTOS Y SECCIONES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 3. Analisis por Departamento y Seccion
-- Pregunta: ¿Cual es el rendimiento de cada departamento en terminos de ventas?
-- ----------------------------------------------------------------------------
SELECT id_departamento, SUM(precio_total) AS ventas_departamento
FROM tickets
GROUP BY id_departamento
ORDER BY ventas_departamento DESC;

-- Pregunta: ¿Como se distribuyen las ventas entre las diferentes secciones?
SELECT id_seccion, SUM(precio_total) AS ventas_seccion
FROM tickets
GROUP BY id_seccion
ORDER BY ventas_seccion DESC;

-- ----------------------------------------------------------------------------
-- 4. Analisis de Productos
-- Pregunta: ¿Cuales son los 10 productos mas vendidos en cantidad?
-- ----------------------------------------------------------------------------
SELECT nombre_producto, SUM(cantidad) AS total_vendido
FROM tickets
GROUP BY nombre_producto
ORDER BY total_vendido DESC
LIMIT 10;

-- Pregunta: ¿Que 10 productos generan mas ingresos?
SELECT nombre_producto, SUM(precio_total) AS ingreso_producto
FROM tickets
GROUP BY nombre_producto
ORDER BY ingreso_producto DESC
LIMIT 10;


-- ============================================================================
-- CLIENTES Y PEDIDOS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 5. Comportamiento de los Clientes
-- Pregunta: ¿Quienes son los 20 clientes que mas compran en terminos de ingresos?
-- ----------------------------------------------------------------------------
SELECT id_cliente, SUM(precio_total) AS ingreso_cliente
FROM tickets
GROUP BY id_cliente
ORDER BY ingreso_cliente DESC
LIMIT 20;

-- Pregunta: ¿Cual es la compra media por cliente?
SELECT AVG(compra_total_cliente) AS compra_media_por_cliente
FROM (
    SELECT id_cliente, SUM(precio_total) AS compra_total_cliente
    FROM tickets
    GROUP BY id_cliente
) subconsulta;

-- ----------------------------------------------------------------------------
-- 6. Analisis de Pedidos
-- Pregunta: ¿Cuantos pedidos totales se han realizado?
-- ----------------------------------------------------------------------------
SELECT COUNT(DISTINCT id_pedido) AS total_pedidos
FROM tickets;

-- Pregunta: ¿Cual es el valor promedio por pedido?
SELECT AVG(total_pedido) AS valor_promedio_pedido
FROM (
    SELECT id_pedido, SUM(precio_total) AS total_pedido
    FROM tickets
    GROUP BY id_pedido
) subconsulta;
