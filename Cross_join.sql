use sample1;
--CREATE TABLE products(id INT, [name] varchar(10));
--CREATE TABLE colors(color_id INT, color varchar(255));

SELECT p.*,c.*
FROM products AS p
CROSS JOIN
colors AS c;


--CREATE TABLE sizes(size_id INT,size varchar(40));

--create table transactions
--(
--order_id int,
--product_name varchar(20),
--color varchar(10),
--size varchar(10),
--amount int
--);
--insert into transactions values (1,'A','Blue','L',300),(2,'B','Blue','XL',150),(3,'B','Green','L',250),(4,'C','Blue','L',250),
--(5,'E','Green','L',270),(6,'D','Orange','L',200),(7,'D','Green','M',250);

-- This is example of SKU (Stock Keeping Unit)

SELECT p.*,c.*,s.*
FROM products AS p
CROSS JOIN
colors AS c
CROSS JOIN
sizes AS s;

SELECT product_name,color,size,SUM(amount) AS total_amount
FROM transactions
GROUP BY product_name,color,size;

WITH master_data AS
(SELECT p.name AS product_name,c.color ,s.size
FROM products AS p,colors AS c,sizes AS s),
sales AS(
SELECT product_name,color,size,SUM(amount) AS total_amount
FROM transactions
GROUP BY product_name,color,size)
SELECT md.*,COALESCE(s.total_amount,0) AS total_amount
FROM master_data AS md
LEFT JOIN 
sales As s
ON md.product_name = s.product_name 
AND md.color = s.color
AND md.size = s.size;
-- We could have also used ISNULL() function
