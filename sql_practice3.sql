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


