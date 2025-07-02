/* ================================================================
   Ranking diario de productos en enero-2014
   Calcula RANK y DENSE_RANK por cada día del mes
================================================================ */

SELECT 
    order_date,                            -- 📅 Fecha de la venta
    order_item_product_id,                 -- 🛒 ID del producto
    order_revenue,                         -- 💰 Ingreso total del producto ese día

    -- 🏆 RANK: asigna posición según ingreso, salta números en empates
    RANK() OVER (
        PARTITION BY order_date            -- 🔄 Reinicia ranking por cada día
        ORDER BY order_revenue DESC        -- ⬇️ De mayor a menor ingreso
    ) AS rnk,

    -- 🏅 DENSE_RANK: igual a RANK pero no salta números en empates
    DENSE_RANK() OVER (
        PARTITION BY order_date
        ORDER BY order_revenue DESC
    ) AS drnk

FROM daily_product_revenue2
WHERE TO_CHAR(order_date::date, 'YYYY-MM') = '2014-01'  -- 🎯 Solo datos de enero-2014
ORDER BY order_date, order_revenue DESC;                -- 📑 Orden cronológico y por ingresos
