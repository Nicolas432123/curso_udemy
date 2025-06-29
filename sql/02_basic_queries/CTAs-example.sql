Create table order_count_by_status
as 
select order_status, count (*) as order_count 
from orders 
group by 1;

SELECT * FROM order_count_by_status;

create table orders_stg
as
select * from orders where false; 

select * from orders_stg;