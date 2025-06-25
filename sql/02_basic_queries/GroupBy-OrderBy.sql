-- Esta consulta cuenta la cantidad de órdenes por estado (order_status)
-- y las ordena de mayor a menor según la cantidad (order_count)

SELECT order_status, count(*) AS order_count
FROM orders
GROUP BY 1  -- Agrupa por la primera columna del SELECT: order_status
ORDER BY 2 DESC;  -- Ordena por la segunda columna del SELECT: order_count (de mayor a menor)

SELECT order_date, count(*) AS order_count
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT to_char(order_date, 'yyyy-MM') AS order_month, count(*) AS order_count
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- Esta consulta obtiene el total de ingresos por cada orden.
-- Se agrupa por el ID de orden (order_item_order_id) para sumar el subtotal (order_item_subtotal)
-- de todos los ítems que pertenecen a esa orden.
-- Luego, se ordena por el mismo ID de orden en orden ascendente.

SELECT order_item_order_id, 
       round(SUM(order_item_subtotal)::numeric, 2) AS order_revenue
FROM order_items
GROUP BY 1
ORDER BY 1; 
 