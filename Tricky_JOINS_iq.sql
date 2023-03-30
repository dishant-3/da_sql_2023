-- TRICKY questions on JOINS

--CREATE TABLE t1(id1 INT);
--CREATE TABLE t2(id2 INT);

SELECT * FROM t1;
SELECT * FROM t2;

-- Approach: INNER JOIN will give all the matching records
-- LEFT JOIN will give matching records + non matching from LEFT table
-- RIGHT JOIN will give matching records + non matching from RIGHT table
-- OUTER JOIN will give matching records + non matching from BOTH tables
-- NULL value in one table IS NOT EQUAL to NULL value in another table

SELECT *
FROM t1
INNER JOIN t2
ON t1.id1=t2.id2;

SELECT * 
FROM t1 
LEFT JOIN t2 
ON t1.id1 = t2.id2;

SELECT * 
FROM t1 
RIGHT JOIN t2
ON t1.id1 = t2.id2;

SELECT *
FROM t1
FULL OUTER JOIN t2
ON t1.id1 = t2.id2;