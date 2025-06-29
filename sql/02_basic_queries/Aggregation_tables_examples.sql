/* ================================================================
   Aggregation Tables: daily_revenue & daily_product_revenue2
   Proyecto  : curso_udemy  – PostgreSQL
   Autor     : Nicolás Álvarez Ahumada
   Creado    : 2025-06-29 (AEST)

   Este script materializa dos snapshots:
     1. daily_revenue            → ingresos totales por día
     2. daily_product_revenue2   → ingresos diarios por producto

   Solo se consideran pedidos con estado COMPLETE o CLOSED,
   excluyendo así pedidos pendientes o cancelados.
   Puedes recargar estas tablas cada noche en tu ETL.
================================================================ */

/*--------------------------------------------------------------
  1️⃣  Ingresos totales por día
--------------------------------------------------------------*/

-- Borrar la tabla si existía para evitar conflictos
DROP TABLE IF EXISTS daily_revenue;

CREATE TABLE daily_revenue AS
SELECT
    o.order_date,                                   -- 📅 Fecha del pedido
    ROUND(SUM(oi.order_item_subtotal)::NUMERIC, 2)  -- 💰 Ingresos totales del día
        AS order_revenue
FROM orders AS o
JOIN order_items AS oi                              -- Une pedidos e ítems
    ON o.order_id = oi.order_item_order_id
WHERE o.order_status IN ('COMPLETE', 'CLOSED')      -- Solo pedidos finalizados
GROUP BY 1;                                         -- Agrupar por fecha

-- Vista rápida de control
SELECT * FROM daily_revenue
ORDER BY order_date;



/*--------------------------------------------------------------
  2️⃣  Ingresos diarios por producto
--------------------------------------------------------------*/

DROP TABLE IF EXISTS daily_product_revenue2;

CREATE TABLE daily_product_revenue2 AS
SELECT
    o.order_date,                                   -- 📅 Fecha
    oi.order_item_product_id,                       -- 🛒 ID de producto
    ROUND(SUM(oi.order_item_subtotal)::NUMERIC, 2)  -- 💰 Ingresos producto-día
        AS order_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_item_order_id
WHERE o.order_status IN ('COMPLETE', 'CLOSED')
GROUP BY 1, 2                                       -- Agrupar por fecha y producto
ORDER BY 1, 3 DESC;                                 -- Orden opcional para inspección

-- Vista rápida: producto más vendido por día
SELECT * FROM daily_product_revenue2
ORDER BY 1, 3 DESC;



/*--------------------------------------------------------------
  📝 Recomendaciones:
    • Crea índices en (order_date) y (order_date, order_item_product_id)
      si consultas estas tablas a menudo.
    • Programa una recarga incremental (cron, Airflow, etc.)
      para procesar solo las fechas nuevas.
--------------------------------------------------------------*/
