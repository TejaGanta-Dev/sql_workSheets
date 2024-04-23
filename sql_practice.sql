with categories as (select * from( select category,sum(spend) as sspend,dense_rank() over(order by
 sum(spend) desc) dense from orders group by category )  as dervied where dense<=2)
-- --  select *,sum(spend) from orders group by category;

-- select derived.product,derived.category,derived.spend,derived.dn from (
-- select *,dense_rank()  over(partition by o.category order by o.spend desc) dn from orders as o
-- ) as derived join categories as c on c.category= derived.category where dn<=2;
-- select * from (
-- select *,dense_rank() over( partition by department order by salary desc) dense from employees)
-- as dervied where dense=1;

-- select * from orders ;
-- select distinct * from customers where customer_id in(
-- select customer_id from orders where extract(month from order_date)=extract(month from current_date)-1
-- and extract(year from order_date)=extract(year from current_date))
-- and customer_id in(
-- select customer_id from orders where extract(month from order_date)=extract(month from current_date)
-- and extract(year from order_date)=extract(year from current_date));
-- 7 days over


-- select * from (
-- select *,row_number() over(partition by name order by name) as row_id from employees) as dervied where row_id>
-- Create Sales table

-- Insert sample records into Sales table
-- select * from products;
 select * from sales where extract(year from sale_date)=2024;
select p.product_id, p.product_name, p.category,  p.price from products as p where p.product_id Not in(
select product_id from sales where extract(year from sale_date)=2024 );
-- --  join sales s on s.product_id=p.product_id ;
-- select DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH);
-- select product_id from sales where extract();

