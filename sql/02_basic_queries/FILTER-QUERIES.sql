
-- Estudio de queries básicas sobre estado de órdenes

-- Obtener todos los estados de órdenes únicos
SELECT DISTINCT order_status FROM orders;

-- Órdenes con estado 'COMPLETE'
SELECT * FROM orders WHERE order_status = 'COMPLETE';

-- Órdenes con estado 'CLOSED' o 'COMPLETE'
SELECT * FROM orders WHERE order_status = 'CLOSED' OR order_status = 'COMPLETE';

-- Igual que el anterior pero usando IN
SELECT * FROM orders WHERE order_status IN ('CLOSED','COMPLETE');