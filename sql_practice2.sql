-- select * from customers;
-- select * from purchases;

-- -- select * from (
-- -- select *, dense_rank() over( partition by customerID order by purchaseDate) from Purchases)
-- --  dervied_table where dervied_table.productName='iPhone' and dervied_table.productName='Airpods' and  dervied_table.PurchaseDate ;

-- select * from Customers c join purchases p1 on p1.CustomerID=c.CustomerID 
-- join purchases p2 on p2.CustomerID=p1.CustomerID where  p2.ProductName='Airpods' and p1.ProductName='MacBook' and p1.PurchaseDate<p2.PurchaseDate;

-- SELECT 
--     COUNT(DISTINCT c.CustomerID) AS total_customers,
--     COUNT(DISTINCT CASE WHEN p2.ProductName = 'Airpods' THEN c.CustomerID END) AS customers_with_airpods,
--     (COUNT(DISTINCT CASE WHEN p2.ProductName = 'Airpods' THEN c.CustomerID END) / COUNT(DISTINCT c.CustomerID)) * 100 AS percentage
-- FROM 
--     Customers c
-- JOIN 
--     Purchases p1 ON p1.CustomerID = c.CustomerID
-- JOIN 
--     Purchases p2 ON p2.CustomerID = p1.CustomerID
-- WHERE  
--     p1.ProductName = 'MacBook'
--     AND p2.ProductName = 'Airpods'
--     AND p1.PurchaseDate < p2.PurchaseDate;




-- select count(derived.salaryCategory),derived.salaryCategory from (
-- select EmployeeID, FirstName, LastName, Department, Salary,
--  case 
-- 	when salary>70000 then "HIGH"
-- 	when salary between 50000 and 70000 then "medium"
-- 	when salary<50000 then "low"
--  end 
--  salaryCategory from employees order by salary desc) derived group by derived.salaryCategory ;



-- SELECT * FROM returns;


-- SELECT count(o.order_id), case when count(o.order_id)>1 then "Returning" else "New" end as category FROM orders o join returns r on r.order_id=o.order_id group by customer_id;

-- select *,
-- case when derived.q>=10 then "High"
-- 		when derived.q>5 and derived.q<=9 then "Medium"
-- 		else "Low" end as category from(
-- SELECT product_id,sum(quantity) as q FROM orders group by product_id ) derived order by derived.q desc  ;

-- select * from Employees;


-- select ee.id,e.unique_id from employees ee left join EmployeeUNI e  on e.id=ee.id;

-- select distinct ee.name manager_name from employees e cross join employees ee where e.manager_id=ee.emp_id;

-- select emp_id,name from employees where emp_id in(select distinct manager_id from employees);

SELECT * FROM customers;
SELECT * FROM orders;
-- Find the top 2 customers who have spent the most money across all their orders. 
-- Return their names, emails, and total amounts spent.
-- select dervived.customer_id,c.customer_name,c.customer_email,dervived.total,dervived.ranked from (
-- SELECT distinct customer_id,sum(order_amount) as total,row_number() over(order by sum(order_amount) desc) as ranked FROM orders
--  group by customer_id order by sum(order_amount) desc) dervived 
--  join customers as c on c.customer_id= dervived.customer_id where dervived.ranked<=2 ;

-- Find out customers details who has placed highest orders and total count of orders and total order amount

-- select * from orders ;
-- SELECT customer_id, max(order_amount) as highestOrderSpend,count(order_id) as totalOrders,sum(order_amount) totalOrderAmount
--  FROM orders  group by customer_id;


-- Write an SQL query to retrieve the product details for items whose revenue 
-- decreased compared to the previous month. 

-- Display the product ID, quantity sold, 
-- and revenue for both the current and previous months.

-- with previous_month as (
-- select product_id,sum(price*quantity) as pTotalSale from orders
--  where extract( month from order_date )=extract( month from current_date )-1 group by product_id),
--  current_month as(
-- select product_id,sum(price*quantity) cTotalSale from orders
--  where extract( month from order_date )=extract( month from current_date) group by product_id)
-- select p.product_id,p.pTotalSale,c.cTotalSale from previous_month p join current_month c on p.product_id=c.product_id
--  where c.cTotalSale<p.pTotalSale and (c.cTotalSale-p.pTotalSale)*100<c.cTotalSale/10;



-- Given a table named employees with the following columns:
-- id, name, department, managerId

-- Write a SQL query to find the names of 
-- managers who have at least five direct reports. 
-- Return the result table in any order.

-- Ensure that no employee is their own manager.

-- The result format should include only the names
-- of the managers meeting the criteria.
-- */

-- SELECT * FROM employees;
-- select * from (
-- select e.managerId,ee.name manager_Name,count(e.id) reporties from employees
--  e inner join employees ee on e.managerId=ee.id 
--  group by 1,2
--  ) dervied where  dervied.reporties>=5;

-- select count(name) from employees
-- where managerid is null;

-- Question:
-- Write an SQL query to find customers who have made 
-- purchases in all product categories.

-- Tables:
-- Customers: customer_id (INT), customer_name (VARCHAR)

-- Purchases: purchase_id (INT), customer_id (INT), 
-- product_category (VARCHAR)

-- Your query should return the customer_id and 
-- customer_name of these customers.
select department,avg(salary),count(department)from employees group by 1

select * from customers;
select * from purchases;
-- with categories as( select distinct product_category from purchases  )
-- select c.customer_id,c.customer_name from customers c
-- join categories t on c.customer_id=t.customer_id

-- select c.customer_id,c.customer_name,count(distinct p.product_category)
--  from customers c join purchases p on  c.customer_id=p.customer_id group by 1,2
--  having count(distinct p.product_category)=(select count( distinct product_category) from purchases)
--  ;
-- Electronics
-- select distinct * from customers where customer_id not in (select customer_id from purchases where product_category ='Electronics')

-- Write a SQL query to find out each hotal best 
-- performing months based on revenue
-- select *,dense_rank() over(partition by Extract(month from booking_date) order by hotel_name) from hotel_bookings
-- select * from (
--  select hotel_name,month(booking_date),extract(year from booking_date ),sum(total_price),
--  dense_rank() over( partition by extract(year from booking_date ),hotel_name
--  order by sum(total_price) desc ) ranks from hotel_bookings group by 1,2,3) derived 
--  where derived.ranks=1 order by derived.hotel_name; 

-- You have a table with below COLUMNS
-- emp_id employee_name, department, salary


-- Find the details of employees whose salary is greater
-- than the average salary across the entire company.
-- */
SELECT * FROM employees;
-- select * from employees where salary>(
-- SELECT sum(salary)/count(employee_id) FROM employees );

 -- Find the average salary of employees in each department, 
-- along with the total number of employees in that department.
--  

-- SELECT department,count(employee_id),avg(salary) FROM employees group by department;

-- Write a query to find products that are sold by 
-- both Supplier A and Supplier B, 
-- excluding products sold by only one supplier.
select * from products;










