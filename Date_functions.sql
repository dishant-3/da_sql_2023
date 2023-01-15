use  sample1;

--CREATE TABLE student(stu_id INT,fn varchar(30),ln varchar(30),city varchar(30),dob date,gender varchar(20));
--CREATE TABLE course(stu_id INT,course_name varchar(30));

--SELECT * FROM student;
--SELECT * FROM course;
DECLARE @current_date date = '2020-01-01 13:05:01';

--SELECT DISTINCT s.stu_id,s.fn,s.ln,s.city,DATEDIFF(year,s.dob,@current_date) AS age
--FROM student as s
--LEFT JOIN 
--course as c
--ON s.stu_id = c.stu_id
--WHERE c.course_name IN ('PHYSICS','MATHS')
--ORDER BY s.stu_id;

--SELECT stu_id,fn,ln,year(@current_date)- year(student.dob)AS age FROM student;

-- We can use year() function directly to fetch the  
SELECT DATEPART(year,@current_date) AS year_val;
SELECT DATEPART(month,@current_date) AS month_val;
-- CHECK CAST() FUNCTION
SELECT CAST('2020-01-01' AS DATE) AS assumed_date;

SELECT CAST(5.3333 AS DEC(3,1)) AS cast_value

SELECT DATEPART(dayofyear,getdate()) AS pres_day
SELECT DATEPART(week,getdate()) AS pres_week
SELECT DATEPART(weekday,getdate()) AS week_day
-- In weekday 1 refers to Sunday as first day of the week

-- getdate() function is used to get the current datetime value
-- ROUND(decimal_value,number,operation) function is used to round or truncate the decimal_value
--'''https://www.geeksforgeeks.org/round-function-in-sql-server/ ''' 

SELECT ROUND(23.45667,3) AS rounded_value
SELECT ROUND(23.45667,3,1) AS truncated_value

-- DATEADD() function is used to add days/weeks/years in a given date
-- SYNTAX DATEADD (date_part , value , input_date ) 
-- https://www.sqlservertutorial.net/sql-server-date-functions/sql-server-dateadd-function/
SELECT DATEADD(day,2,'2022-01-23') AS added_date

--CREATE TABLE customer_orders
--(order_id INT,cutomer_id INT,order_date DATE,ship_date DATE);
SELECT * FROM customer_orders;

SELECT * ,DATEDIFF(day,order_date,ship_date) AS days_to_ship,
DATEDIFF(week,order_date,ship_date) AS weeks_between,
(DATEDIFF(day,order_date,ship_date)-(DATEDIFF(week,order_date,ship_date)*2)) AS bus_days_to_ship
FROM customer_orders;

SELECT DATEDIFF(week,'2023-01-09','2023-01-15');
-- So DATEDIFF() with week gives value one only when one weekend lies in the start_date and end_date

-- TO CALCULATE THE AGE OF CUSTOMERS/STUDENTS
SELECT stu_id,fn, ln, DATEDIFF(year,dob,getdate()) AS age
FROM student;
-- IMPORTANT
-- For a week (wk, ww) or weekday (dw) datepart, the DATEPART return value depends on the value set by SET DATEFIRST.
--https://learn.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver16
-- ASSIGNMENT HOW TO ADD BUSINESS DAYS IN A GIVEN DATE
use sample1;
SELECT * FROM customer_orders;