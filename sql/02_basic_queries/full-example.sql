SELECT
    o.order_date,                           -- 1) Día de la orden
    oi.order_item_product_id,               -- 2) Producto vendido
    ROUND(SUM(oi.order_item_subtotal)::numeric, 2) AS order_revenue
                                            -- 3) Ingreso total (suma de subtotales) redondeado a 2 decimales
FROM orders AS o
JOIN order_items AS oi
     ON o.order_id = oi.order_item_order_id -- Une cada pedido con sus ítems
WHERE o.order_status IN ('COMPLETE','CLOSED')   -- Solo pedidos completados o cerrados
GROUP BY 1, 2                                -- Agrupa por fecha y producto
ORDER BY 1, 3 DESC;                          -- Ordena por fecha y, dentro de cada fecha, por ingreso de mayor a menor

