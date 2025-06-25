select count (*) from orders;
select count (*) from orders_items;
select count (distinct order_status) from orders;
select count (distinct order_date) from orders;
select * from order_items;
select sum (order_item_subtotal)
from order_items
where order_item_order_id =2;