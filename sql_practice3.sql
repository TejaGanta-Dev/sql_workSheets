SELECT * FROM customers;
SELECT distinct id FROM orders;
/*

You have given two tables customers with columns (id, name phone
address) and orders table columns(order_id, cxid order_date and cost)

Find the percentage of shipable orders.
Consider an order is shipable if the customer's address is known.
*/
with totalOrders as(select count(id) from orders)
select count(distinct cust_id),count(distinct cust_id) from orders where cust_id in(select id from customers where address is not null);



select count(o.id),count(case when oo.address is not null then oo.id end) from orders o join customers oo on o.cust_id=oo.id;


SELECT COUNT(CASE WHEN LENGTH(c.phone_number) <> 10 THEN o.id END),  COUNT(o.id),
    (COUNT(CASE WHEN LENGTH(c.phone_number) <> 10 THEN o.id END) / COUNT(o.id)) * 100 AS percentage_orders_invalid_phone
FROM 
    orders o
 JOIN 
    customers c ON o.cust_id = c.id;
select * from Orders;




/*

-- Your Task
Find out the percentage of orders where customer
doesn't have valid phone numbers 

-- Note 
The Length of valid phone no is 10 character 
*/

-- select count(o.id),count(case when length(c.phone_number)<>10 then o.id end) from orders o join customers c on c.id=o.cust_id;



/*
-- Question
You have a employees table with columns emp_id, emp_name,
department, salary, manager_id (manager is also emp in the table))

Identify employees who have a higher salary than their manager. 
*/


-- select * from Employees;

-- select e.Employee_id,e.Employee_name,e.manager_id,e.salary,ee.salary from Employees e
--  join Employees ee on e.manager_id=ee.Employee_id;
-- SELECT 
--     e.employee_id,
--     e.employee_name,
--     e.department,
--     e.salary,
--     e.manager_id,
--     m.employee_name as manager_name,
--     m.salary as manager_salary
-- from employees as e
-- JOIN
-- employees as m
-- ON e.manager_id = m.employee_id
-- WHERE e.salary > m.salary

-- Find all the employee who has salary greater than average salary?

select avg(salary) from employees;

select * from employees where salary>( select avg(salary) from employees);
/*
Find the best selling item for each month 
(no need to separate months by year) 
where the biggest total invoice was paid. 

The best selling item is calculated using the formula 
(unitprice * quantity). 
Output the month, the description of the 
item along with the amount paid.
*/

-- select distinct d.months,d.description,d.amountPaid  from (
-- select Extract(month from invoicedate) months,SUM(unitprice * quantity) amountPaid,dense_rank() 
-- over(partition by Extract(month from invoicedate)
--  order by sum(unitprice*quantity) desc) ranks from walmart_eu group by months order by months ) d where d.ranks=1  ;
-- SELECT
--     month,
--     description,
--     total_sale
-- FROM
-- (
--      SELECT 
--         EXTRACT(MONTH FROM invoicedate) as month,
--         description,
--         SUM(unitprice * quantity) as total_sale,
--         RANK() OVER( PARTITION BY EXTRACT(MONTH FROM invoicedate) 
--                     ORDER BY SUM(unitprice * quantity) DESC) as rn
--     FROM walmart_eu
--     GROUP BY month, description
-- ) as subquery
-- WHERE rn= 1


-- Find the best selling item for each month 
-- (no need to separate months by year) 
-- where the biggest total invoice was paid. 

-- The best selling item is calculated using the formula 
-- (unitprice * quantity). 
-- Output the month, the description of the 
-- item along with the amount paid.
-- */

/*
Find the best selling item for each month 
(no need to separate months by year) 
where the biggest total invoice was paid. 

The best selling item is calculated using the formula 
(unitprice * quantity). 
Output the month, the description of the 
item along with the amount paid.
*/
-- select * from (
-- select description,extract(month from invoicedate) invdat,sum(unitprice*quantity) price,
-- dense_rank() over(partition by extract(month from invoicedate) order by sum(unitprice*quantity) desc) rnk
--  from walmart_eu group by invdat,description) derived where derived.rnk=1;





-- select distinct customerid,sum(unitprice*quantity),extract(month from invoicedate) from walmart_eu 
-- group by customerid,extract(month from invoicedate)
-- order by 2,3;


-- select * from (
-- select distinct customerid,sum(unitprice*quantity) total,extract(month from invoicedate) month,dense_rank() over(partition by 
-- extract(month from invoicedate) order by sum(unitprice*quantity) desc) rnk from walmart_eu group by 1,3) d where d.rnk=1;

-- Write a query to find the highest-selling 
-- product for each customer

-- Return cx id, product description, 
-- and total count of purchase.
select * from walmart_eu;
-- select * from (
-- select customerid,stockcode,
-- count(quantity),
-- sum(quantity),
-- dense_rank() over( partition by customerid order by sum(quantity) desc) rnk
--  from walmart_eu group by 1,2
-- ) d where d.rnk=1;


/*
-- Question
Find the hotel name and their total numbers
of weekends bookings
sort the data higher number first!
*/
-- select * from bookings;

-- select hotel_name, count(booking_date),DAYOFWEEK(booking_date)from bookings where DAYOFWEEK(booking_date) IN (1, 7) group by hotel_name,3;



-- select DAYOFWEEK(current_date);
-- select current_date;

-- Find out hotel_name and their total number of booking by credit card and cash

-- select hotel_name,count(id),payment_type from bookings where payment_type in("credit","cash") group by hotel_name,3;


-- select hotel_name,payment_type from bookings group by hotel_name,2


/*
-- Question
You have amazon orders data

For each week, find the total number 
of orders. 
Include only the orders that are 
from the first quarter of 2023.

The output should contain 'week' 
and 'quantity'.

*/
-- select * from orders;



-- select extract(week from order_date),sum(quantity) from orders where extract(year from order_date)=2023 and 
-- extract(quarter from order_date)=1 group by 1 order by 1;

-- -- Find each quarter and their total qty sale
-- select extract(quarter from order_date) quarter,sum(quantity) as total_qty_sale from orders where extract(year from order_date)=2023 group by 1


/*
-- Amazon Data Analyst Interview
-- Top Monthly Sellers

You are provided with a transactional dataset from 
Amazon that contains detailed information about 
sales across different products and marketplaces. 

Your task is to list the top 3 sellers in each 
product category for January.

The output should contain 'seller_id' , 
'total_sales' ,'product_category' , 
'market_place', and 'month'.

*/
-- select * from sales_data;
-- select * from (
-- select s.seller_id,s.product_category,sum(s.total_sales), 
-- dense_rank() over(partition by s.product_category order by sum(s.total_sales) desc)
--  rnk from sales_data as s where extract(month from s.month) group by 1,2 
--  )derived where derived.rnk<=3;


--  by Market Place
--  
--  select * from (
-- select s.seller_id,s.market_place,sum(s.total_sales), 
-- dense_rank() over(partition by s.market_place order by sum(s.total_sales) desc)
--  rnk from sales_data as s where extract(month from s.month) group by 1,2 
--  )derived where derived.rnk<=3;
/*
Netflix Data Analyst Interview Question

For each video, find how many unique users 
flagged it. 
A unique user can be identified using the
combination of their first name and last name. 

Do not consider rows in which there is no flag ID.

*/

-- select * from user_flags;

-- select video_id,count(distinct(concat(user_firstname,user_lastname))) from user_flags where flag_id is not null
-- group by video_id;



/*
-- Meta Data Analyst Question 

You have meta table with columns
user_id, name, status, country

Output share of US users that are active. 
Active users are the ones with an 
"open" status in the table.

Return total users and active users
and active users share for US
*/

-- COUNT FILTER FOR US
-- COUNT ACTIVE users in US
-- active users/total users * 100


-- SELECT count(distinct user_id) total,
-- count(case when country='USA' and status='open' then user_id end) ActiveUsers,
-- Round((count(case when country='USA' and status='open' then user_id end)/count(distinct user_id))*100,2)
--  FROM fb_active_users ;
--  
--  SELECT count(case when user_id then user_id end) total
--  FROM fb_active_users ;
-- --  select * from fb_active_users where country='USA' and status='open';
--  SELECT
--  count(case when country='USA' and status='open' then user_id end) ActiveUsers  FROM fb_active_users ;

-- Find non_active users share for China

-- select * from fb_active_users where country='China'
--  and status='closed' ;


select* from Students;
/*
Data Analyst Interview Questions 

You have a students table with columns
id, name, marks and class of students

-- Write a query to fetch students
with minmum marks and maximum marks 


*/
-- select student_id, student_name, marks, class from Students
--  where marks=(select min(marks) from Students) or marks=(select max(marks) from Students) order by marks desc;


-- Write a SQL query to return students with maximum marks in each class
-- select * from (
-- select student_id, student_name, marks, class,dense_rank() over(partition by class order by max(marks)) rnk from Students group by 1
-- ) derived where derived.rnk=1;
/*
You are given a bank transaction data 
with columns bank_id, customer_id, 
amount_type(credit debit), 
transaction_amount and transaction_date



-- Write a query to find starting and ending 
trans amount for each customer

Return cx_id, their first_transaction_amt, 
last_transaction and these transaction_date

*/
-- select C;
-- -- alter
-- select customer_id,first_transaction_amt,last_transaction,transaction_date from bank_transactions;


-- with firstTransac as(
-- select * from (
-- SELECT *,dense_rank() over(partition by customer_id order by transaction_date) rnk FROM bank_transactions) d where d.rnk=1 ),
-- secondTransac as(
-- select * from (
-- SELECT *,dense_rank() over(partition by customer_id order by transaction_date desc)rnk FROM bank_transactions) d where d.rnk=1) 

-- select f.customer_id,f.transaction_amount,f.transaction_date,s.transaction_amount,s.transaction_date from firstTransac f join secondTransac s 
-- on  f.customer_id=s.customer_id;




-- select customer_id,sum( case when transaction_type='credit' then transaction_amount end) totalCredit, 
-- sum( case when transaction_type<>'credit' then transaction_amount end) totalDebit , 
-- sum( case when transaction_type='credit' then transaction_amount end)-sum( case when transaction_type<>'credit' then transaction_amount end)
--  balance
-- from bank_transactions group by customer_id;

/*
Question

Write an SQL script to display the 
immediate manager of an employee.

Given a table Employees with columns: 
Emp_No, Emp_Name, and Manager_Id.

The script should take an input parameter 
Emp_No and return the employee's name 
along with their immediate manager's name.

If an employee has no manager 
(i.e., Manager_Id is NULL), 
display "No Boss" for that employee.

*/

-- SELECT * FROM employees;

-- SELECT e.Emp_No,e.emp_name,
-- case when ee.manager_id is null then "No Boss " else ee.manager_id end
--  FROM employees e join employees ee on e.emp_no=ee.emp_no;




/*

-- Amazon Data Analyst Interview Question

You are given two table of amazon
spending_records and customers 




