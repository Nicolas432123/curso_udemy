-- ========================================================
-- Total de ingresos por mes (una fila por cada mes)
-- Agrupa todos los ingresos del mes en una sola fila
-- ========================================================

SELECT 
    TO_CHAR(dr.order_date::timestamp, 'YYYY-MM') AS order_month,  -- 📅 Extrae el mes y año como texto
    SUM(order_revenue) AS order_revenue                            -- 💰 Suma todos los ingresos de ese mes
FROM daily_revenue AS dr
GROUP BY 1                                                        -- Agrupa por el mes
ORDER BY 1;                                                       -- Ordena cronológicamente


-- ========================================================
-- Ingresos por día + total mensual (función de ventana)
-- Muestra cada día con su ingreso + total del mes al que pertenece
-- ========================================================

SELECT 
    TO_CHAR(dr.order_date::timestamp, 'YYYY-MM') AS order_month,  -- 📅 Extrae el mes y año como texto
    dr.order_date,                                                -- 📆 Muestra la fecha específica
    dr.order_revenue,                                             -- 💰 Muestra el ingreso de ese día

    -- 💡 Función de ventana: suma el total del mes sin agrupar las filas
    SUM(order_revenue) OVER (
        PARTITION BY TO_CHAR(dr.order_date::timestamp, 'YYYY-MM') -- Crea una “ventana” por cada mes
    ) AS monthly_order_revenue

FROM daily_revenue AS dr
ORDER BY 1;                                                       -- Ordena por mes
