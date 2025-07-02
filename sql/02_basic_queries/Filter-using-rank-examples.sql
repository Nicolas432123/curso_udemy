select *from (
	select order_date,
	order_item_product_id,
	order_revenue,
	rank() over (order by order_revenue desc) as rnk,
	dense_rank() over (order by order_revenue desc) as drnk
from daily_product_revenue2
where order_date ='2014-01-01 00:00:00.0' 
)as q
where drnk <= 5;

with daily_product_revenue_ranks as  (
	select order_date,
	order_item_product_id,
	order_revenue,
	rank() over (order by order_revenue desc) as rnk,
	dense_rank() over (order by order_revenue desc) as drnk
from daily_product_revenue2
where order_date ='2014-01-01 00:00:00.0'
)select * from daily_product_revenue_ranks
where drnk <=5
order by order_revenue desc;