--CREATE DATABASE sample1;
--USE sample1;
--CREATE TABLE emp
--(
--emp_id INT ,
--emp_name VARCHAR(20),
--department_id INT,
--salary INT,
--manager_id INT
--);

INSERT INTO emp(emp_id,emp_name,department_id,salary,manager_id)
VALUES
(1,'Ankit',100,10000,4),
(2,'Mohit',100,15000,5),
(3,'Vikas',100,10000,4),
(4,'Mohit',100,5000,2),
(5,'Mudit',200,12000,6),
(6,'Agam',200,12000,2),
(7,'Sanjay',200,9000,2),
(8,'Ashish',200,5000,2),
(1,'Saurabh',900,12000,2);

USE sample1;
-- Q1 How to find duplicates?

SELECT emp_id, COUNT(1) AS cnt_rows
FROM emp GROUP BY emp_id HAVING COUNT(1) >1;

-- Q2 How to remove duplicate records?

SELECT * INTO emp1 FROM emp;

WITH dup_cte AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY emp_id ORDER BY emp_id) AS rn FROM emp1)
DELETE FROM dup_cte WHERE rn>1;

SELECT * FROM emp1;
-- Q3 Difference between union and union all?

SELECT manager_id FROM emp
UNION ALL
SELECT manager_id FROM emp1;
--UNION ALL will give all the records merged one after another

SELECT manager_id FROM emp
UNION 
SELECT manager_id FROM emp1;

--UNION will remove the duplicates and then give merged result

-- Q4 Difference between rank(), row_number() and dense_rank() 
create table emp2(
    emp_id int,
    emp_name varchar(20),
    department_id int,
    salary int
);
insert into emp2 values(1,'Ankit',100,10000);
insert into emp2 values(2,'Mohit',100,15000);
insert into emp2 values(3,'Vikas',100,10000);
insert into emp2 values(4,'Rohit',100,5000);
insert into emp2 values(5,'Mudit',200,12000);
insert into emp2 values(6,'Agam',200,12000);
insert into emp2 values(7,'Sanjay',200,9000);
insert into emp2 values(8,'Ashish',200,5000);

SELECT * FROM emp2;

SELECT emp_id,emp_name,department_id,salary,
RANK()OVER(ORDER BY salary DESC) AS rnk,
DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rnk,
ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM emp2;

-- DENSE_RANK() function skip nhi karta hai numbers after assigning of same ranks .
-- ROW_NUMBER() function will assign consecutive numbers as ranks

--Interview question : To get department wise highest salary

SELECT *
FROM 
(
SELECT emp_id,emp_name,department_id,salary,
RANK()OVER(PARTITION BY department_id ORDER BY salary DESC) AS rnk
FROM emp2
) as tb1
WHERE tb1.rnk=1;

--create table emp(
--emp_id int,
--emp_name varchar(20),
--department_id int,
--salary int,
--manager_id int,
--emp_age int);

-- Q5 Employees which are not present in department table.
--CREATE TABLE dept (
--dep_id INT,
--dep_name VARCHAR(20));
--INSERT INTO dept VALUES
--(100, 'ANALYTICS'),
--(300,'IT');
SELECT * FROM emp;
SELECT * FROM dept;

SELECT * FROM emp
WHERE  emp.department_id NOT IN (SELECT DISTINCT dep_id FROM dept);
-- IN ABOVE AS WE USED SUBQUERY, THE PERFORMANCE WILL NOT BE GOOD. USE JOIN

SELECT emp.*,dept.dep_id,dept.dep_name
FROM emp
LEFT JOIN dept
ON emp.department_id = dept.dep_id
WHERE dept.dep_id IS NULL;

-- Q6 Second Highest salary in each dept
-- IN THIS QUESTION RANK() function will not give the correct output.
SELECT *
FROM 
(	
	SELECT * , DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rnk	
	FROM emp
) AS tb1 
WHERE tb1.rnk =2;

--Q7 Find all the transaction done by Shilpa
CREATE TABLE orders
(	customer_name VARCHAR(20),
	order_date DATE,
	order_amount INT,
	customer_gender VARCHAR(10)
);

SELECT * FROM orders WHERE customer_name ='Shilpa';
-- IN SQL SERVER IT IS CASE INSENSITIVE SEARCH
-- WE NEED TO USE UPPER/ LOWER FUNCTION
SELECT * FROM orders WHERE UPPER(customer_name)='SHILPA';
SELECT * FROM orders WHERE LOWER(customer_name)='shilpa';
--Q8 self join, manager salary > emp salary
select * from emp

SELECT * FROM 
(
SELECT tb1.emp_id,tb1.emp_name,tb1.salary,tb2.emp_id AS man_id,tb2.emp_name AS man_name,tb2.salary AS man_salary
FROM emp AS tb1
INNER JOIN
emp AS tb2
ON tb1.manager_id = tb2.emp_id
) AS tb3
WHERE tb3. man_salary> salary;

-- WITHOUT using subquery, to find employee salary > manager salary

SELECT e.emp_name,e.salary,m.emp_name AS mgr_name,m.salary AS mgr_salary
FROM emp AS e
INNER JOIN emp AS m
ON e.manager_id = m.emp_id
WHERE e.salary>m.salary;

--Q9 Explain different joins

-- Q10  Update query to swap gender

SELECT * INTO orders_inc FROM orders;

SELECT * FROM orders_inc;

UPDATE orders
SET customer_gender = CASE WHEN  customer_gender ='Male' THEN  'Female' 
		WHEN customer_gender ='Female' THEN 'Male' END;

SELECT * FROM orders;
SELECT * FROM orders_inc;

--insert into emp
--values
--(1, 'Ankit', 100,10000, 4, 39;
--insert into emp
--values (2, 'Mohit', 100, 15000, 5, 48);
--insert into emp
--values (3, 'Vikas', 100, 10000,4,37);
--insert into emp
--values (4, 'Rohit', 100, 5000, 2, 16);
--insert into emp
--values (5, 'Mudit', 200, 12000, 6,55);
--insert into emp
--values (6, 'Agam', 200, 12000,2, 14);
--insert into emp
--values (7, 'Sanjay', 200, 9000, 2,13);
--insert into emp
--values (8, 'Ashish', 200,5000,2,12);
--insert into emp
--values (9, 'Mukesh',300,6000,6,51);
--insert into emp
--values (10, 'Rakesh',300,7000,6,50);

