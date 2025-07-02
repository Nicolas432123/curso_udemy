/* ================================================================
   TOP-5 productos POR DÍA en enero-2014
   Dos formas equivalentes: subconsulta inline vs. CTE
================================================================ */

/*--------------------------------------------------------------
  MÉTODO 1: Subconsulta inline
--------------------------------------------------------------*/
SELECT *
FROM (
    /*----------------------------------------------------------
      Calcula el ranking diario de ingresos por producto
      - RANK   : salta números cuando hay empates
      - DENSE_RANK : NO salta números en empates
      Se filtra solo enero-2014
    ----------------------------------------------------------*/
    SELECT
        order_date,                            -- 📅 Día
        order_item_product_id,                 -- 🛒 Producto
        order_revenue,                         -- 💰 Ingresos de ese producto ese día

        RANK() OVER (                          -- 🏆 Ranking (con saltos)
            PARTITION BY order_date            -- 🔄 Reinicia ranking cada día
            ORDER BY order_revenue DESC        -- ⬇️ Mayor ingreso primero
        ) AS rnk,

        DENSE_RANK() OVER (                    -- 🏅 Ranking denso (sin saltos)
            PARTITION BY order_date
            ORDER BY order_revenue DESC
        ) AS drnk
    FROM daily_product_revenue2
    WHERE TO_CHAR(order_date, 'YYYY-MM') = '2014-01'  -- 🎯 Solo enero-2014
) AS q
WHERE drnk <= 5                                    -- 🔍 Quedarse con el TOP-5 por día
ORDER BY order_date, order_revenue DESC;           -- 📑 Orden final



/*--------------------------------------------------------------
  MÉTODO 2: Usando un CTE (Common Table Expression)
  Ventaja → más legible y reutilizable en consultas complejas
--------------------------------------------------------------*/
WITH daily_product_revenue_ranks AS (
    SELECT
        order_date,
        order_item_product_id,
        order_revenue,
        RANK() OVER (
            PARTITION BY order_date
            ORDER BY order_revenue DESC
        ) AS rnk,
        DENSE_RANK() OVER (
            PARTITION BY order_date
            ORDER BY order_revenue DESC
        ) AS drnk
    FROM daily_product_revenue2
    WHERE TO_CHAR(order_date, 'YYYY-MM') = '2014-01'
)
SELECT *
FROM daily_product_revenue_ranks
WHERE drnk <= 5                                    -- 🔍 TOP-5 diario
ORDER BY order_date, order_revenue DESC;           -- 📑 Orden final
