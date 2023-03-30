use sample1;
--create table mode 
--(
--id int
--);

--insert into mode values (1),(2),(2),(3),(3),(3),(3),(4),(5);

-- Using sub query
SELECT * FROM mode;
SELECT id,freq
FROM
(
SELECT id, COUNT(id) AS freq
FROM mode
GROUP BY id
) AS tb1 
WHERE freq= 
(SELECT MAX(freq) 
FROM (SELECT id, COUNT(id) AS freq
FROM mode
GROUP BY id) AS tb2)

-- Using CTE

WITH freq_cte AS
(
SELECT id, COUNT(id) AS freq
FROM mode
GROUP BY id
) SELECT id, freq
FROM freq_cte
WHERE freq = (SELECT MAX(freq) FROM freq_cte);