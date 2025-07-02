/* ================================================================
   Consultas exploratorias y ranking para daily_product_revenue2
================================================================ */

/*--------------------------------------------------------------
  1️⃣  Conteo total de filas en la tabla
--------------------------------------------------------------*/
SELECT COUNT(*) 
FROM daily_product_revenue2;
-- Resultado: número total de registros (filas) en la tabla



/*--------------------------------------------------------------
  2️⃣  Vista completa ordenada por fecha y por ingreso (desc)
--------------------------------------------------------------*/
SELECT *
FROM daily_product_revenue2
ORDER BY order_date,            -- 📅 Orden cronológico
         order_revenue DESC;    -- 💰 Dentro de cada día, mayor ingreso primero



/*--------------------------------------------------------------
  3️⃣  Filtra solo el día 2014-01-01 y ordena por ingreso desc
--------------------------------------------------------------*/
SELECT *
FROM daily_product_revenue2
WHERE order_date = '2014-01-01 00:00:00.0'   -- 🎯 Día exacto
ORDER BY order_revenue DESC;                 -- 💰 Mayor a menor



/*--------------------------------------------------------------
  4️⃣  Ranking global (sin PARTITION) para el día 2014-01-01
      - RANK       : salta números si hay empates
      - DENSE_RANK : no salta números en empates
--------------------------------------------------------------*/
SELECT
    order_date,                     -- 📅 Fecha (solo 2014-01-01 por el filtro)
    order_item_product_id,          -- 🛒 Producto
    order_revenue,                  -- 💰 Ingreso

    RANK() OVER (                   -- 🏆 Ranking (con saltos en empates)
        ORDER BY order_revenue DESC
    ) AS rnk,

    DENSE_RANK() OVER (             -- 🏅 Ranking denso (sin saltos)
        ORDER BY order_revenue DESC
    ) AS drnk

FROM daily_product_revenue2
WHERE order_date = '2014-01-01 00:00:00.0'
ORDER BY order_revenue DESC;        -- 📑 Orden final por ingresos
