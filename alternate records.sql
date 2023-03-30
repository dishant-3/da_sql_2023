-- SELECT alternate records starting from 3rd record
use sample1;
SELECT*
FROM
(
SELECT *,ROW_NUMBER() OVER(ORDER BY id) AS rn FROM employee
) AS tb1 
WHERE rn>2 AND rn%2 !=0;
