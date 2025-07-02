EXPLAIN 

SELECT * FROM orders where order_id = 2; 

Explain 
select o.*, 
	round(sum(oi.order_item_subtotal)::numeric, 2) as revenue
from orders as o 
	join order_items as oi 
		on o.order_id= oi.order_item_order_id
where o.order_id = 2 
group by o.order_id,
	o.order_date,
	o.order_customer_id,
	o.order_status;