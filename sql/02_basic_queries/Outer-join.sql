/* ============================================================
   1) INNER JOIN
   ------------------------------------------------------------
   - Muestra SOLO las órdenes que tienen al menos un ítem asociado
   - Une la tabla principal de pedidos (orders) con los detalles
     de ítems (order_items) usando el ID del pedido.
   - Si una orden no tiene ítems, NO aparecerá en el resultado.
   ============================================================ */
SELECT
    o.order_date,              -- Fecha del pedido (tabla orders)
    oi.order_item_product_id,  -- ID del producto (tabla order_items)
    oi.order_item_subtotal     -- Subtotal del ítem (tabla order_items)
FROM orders AS o
JOIN order_items AS oi
     ON o.order_id = oi.order_item_order_id;  -- Condición de unión


/* ============================================================
   2) LEFT OUTER JOIN
   ------------------------------------------------------------
   - Devuelve TODAS las órdenes, incluso aquellas sin ítems.
   - Para las órdenes sin coincidencias en order_items, las
     columnas del alias "oi" se rellenan con NULL.
   - Se ordena el resultado por el ID del pedido.
   ============================================================ */
SELECT
    o.order_id,                -- Identificador único del pedido
    o.order_date,              -- Fecha del pedido
    oi.order_item_product_id,  -- ID del producto (puede ser NULL)
    oi.order_item_subtotal     -- Subtotal del ítem (puede ser NULL)
FROM orders AS o
LEFT OUTER JOIN order_items AS oi
     ON o.order_id = oi.order_item_order_id
ORDER BY 1;   -- Ordena por la primera columna del SELECT (order_id)


