USE data_lemur;
-- Subject_Matter_Expert

-- solution 1
WITH cte1 AS
(
SELECT employee_id, COUNT(DISTINCT domain) AS cnt_domain, SUM(years_of_experience) AS total_exp,
MAX(CASE WHEN years_of_experience >=8 THEN 1 ELSE 0 END) AS sm_flag1
FROM employee_expertise
GROUP BY employee_id
) ,cte2 AS
(SELECT employee_id , CASE WHEN sm_flag1=1 THEN 1 
WHEN cnt_domain=2 AND total_exp>=12 THEN 1 ELSE 0 END AS sme_flag
FROM cte1
)
SELECT employee_id FROM cte2 WHERE sme_flag =1;

-- SOLUTION 2

SELECT employee_id
FROM employee_expertise
GROUP BY employee_id
HAVING SUM(years_of_experience)>=8 AND COUNT(DISTINCT domain) = 1 
OR SUM(years_of_experience)>=12 AND COUNT(DISTINCT domain)=2 ;
