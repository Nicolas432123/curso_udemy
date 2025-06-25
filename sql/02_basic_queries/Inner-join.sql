-- Esta consulta realiza un INNER JOIN entre las tablas "orders" y "order_items"
-- con el objetivo de combinar información de ambas tablas relacionada a un pedido específico.

SELECT 
    o.order_date,                       -- Fecha del pedido (desde la tabla "orders")
    oi.order_item_product_id,          -- ID del producto pedido (desde la tabla "order_items")
    oi.order_item_subtotal             -- Subtotal del producto (precio * cantidad)
FROM orders AS o                       -- Alias "o" para la tabla "orders"
JOIN order_items AS oi                 -- Alias "oi" para la tabla "order_items"
    ON o.order_id = oi.order_item_order_id -- Condición de unión: relaciona pedidos con sus ítems usando el ID del pedido
;
