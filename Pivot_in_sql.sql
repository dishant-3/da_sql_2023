--use sample1;
--create table emp_compensation (
--emp_id int,
--salary_component_type varchar(20),
--val int
--);
--insert into emp_compensation
--values (1,'salary',10000),(1,'bonus',5000),(1,'hike_percent',10)
--, (2,'salary',15000),(2,'bonus',7000),(2,'hike_percent',8)
--, (3,'salary',12000),(3,'bonus',6000),(3,'hike_percent',7);
--select * from emp_compensation;

WITH cte AS
(
SELECT emp_id, 
CASE WHEN salary_component_type ='salary' THEN val ELSE NULL END AS salary,
CASE WHEN salary_component_type ='bonus' THEN val ELSE NULL END AS bonus,
CASE WHEN salary_component_type = 'hike_percent' THEN val ELSE NULL END AS hike_percent
FROM emp_compensation
) 
SELECT emp_id,SUM(salary) AS salary, SUM(bonus) AS bonus,SUM(hike_percent) AS hike_percrnt
FROM cte
GROUP BY emp_id; 