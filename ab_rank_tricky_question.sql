--use sample1;
--create table list (id varchar(5));
--insert into list values ('a');
--insert into list values ('a');
--insert into list values ('b');
--insert into list values ('c');
--insert into list values ('c');
--insert into list values ('c');
--insert into list values ('d');
--insert into list values ('d');
--insert into list values ('e');

SELECT * FROM list;

WITH cte_dup AS
(SELECT id FROM list GROUP BY id HAVING count(1) >1),
cte_rnk AS
(SELECT id, RANK() OVER(ORDER BY id) AS rn FROM cte_dup )
SELECT l.id,cr.rn,CONCAT('DUP',CAST(cr.rn AS varchar(2))) AS op
FROM list AS l
LEFT JOIN 
cte_rnk AS cr
ON l.id = cr.id

--WITH cte_dup AS
--(SELECT id FROM list GROUP BY id HAVING count(1) >1)

--SELECT id, RANK() OVER(ORDER BY id) AS rn FROM cte_dup 