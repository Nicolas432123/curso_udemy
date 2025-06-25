-- Selecciona la fecha del pedido (order_date) y la cantidad de pedidos en esa fecha
SELECT order_date, count(*) AS order_count
FROM orders
-- Filtra los pedidos que estén en estado COMPLETO o CERRADO
WHERE order_status IN ('COMPLETE', 'CLOSED')
-- Agrupa los resultados por fecha de pedido
GROUP BY 1
-- Filtra los grupos dejando solo aquellos con 120 o más pedidos
HAVING count(*) >= 120
-- Ordena los resultados por la cantidad de pedidos en orden descendente
ORDER BY 2 DESC;

-- Para cada pedido, calcula el ingreso total (order_revenue) redondeado a 2 decimales
SELECT
    order_item_order_id,
    ROUND(SUM(order_item_subtotal)::numeric, 2) AS order_revenue
FROM order_items
-- Agrupa todos los ítems del mismo pedido
GROUP BY 1           -- 1 ≡ order_item_order_id
-- Conserva solo los pedidos cuyo ingreso total sea de 2 000 o más
HAVING ROUND(SUM(order_item_subtotal)::numeric, 2) >= 2000
-- Ordena los resultados por ingreso total de mayor a menor
ORDER BY 2 DESC;     -- 2 ≡ order_revenue