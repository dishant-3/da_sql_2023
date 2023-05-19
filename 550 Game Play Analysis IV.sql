use sample1;
--CREATE TABLE activity(player_id INT,device_id INT, event_date DATE, games_played INT);
WITH cte1 AS
(
SELECT player_id,event_date,
FIRST_VALUE(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS first_date,
LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS next_dt
FROM activity
),cte2 AS
(
SELECT player_id,DATEDIFF(day,first_date,next_dt) AS day_diff
FROM cte1
)
SELECT ROUND((COUNT(DISTINCT CASE WHEN day_diff =1 THEN cte2.player_id ELSE NULL END) * 0.1) /
COUNT(DISTINCT cte1.player_id),2)
FROM cte1, cte2;

------------------
-- Time limit exceeded in this solution

WITH cte1 AS
(
SELECT player_id,event_date,
FIRST_VALUE(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS first_date,
LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS next_dt
FROM activity
),cte2 AS
(
SELECT player_id,DATEDIFF(day,first_date,next_dt) AS day_diff
FROM cte1
)
SELECT COUNT(DISTINCT cte1.player_id) AS total_player, 
COUNT(DISTINCT CASE WHEN day_diff =1 THEN cte2.player_id ELSE NULL END) AS cnt_reg_partner,
(COUNT(DISTINCT CASE WHEN day_diff =1 THEN cte2.player_id ELSE NULL END)*1.0)/  COUNT(DISTINCT cte1.player_id) AS fraction
FROM cte1,cte2 ;

---------------------------
-- Accepted solution

WITH cte1 AS
(
SELECT player_id,event_date,
DATEDIFF(day,FIRST_VALUE(event_date) OVER(PARTITION BY player_id ORDER BY event_date),LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date)) AS day_diff
FROM activity
)
SELECT ROUND((COUNT(DISTINCT CASE WHEN day_diff =1 THEN cte1.player_id ELSE NULL END) * 1.0) /
COUNT(DISTINCT cte1.player_id),2) AS fraction
FROM cte1;

----------------------
-- WITHOUT WINDOW FUNCTIONS

SELECT ROUND(COUNT(DISTINCT tb2.player_id) *1.0 / COUNT(DISTINCT tb1.player_id),2) AS fraction
FROM 
(
  SELECT player_id, MIN(event_date) AS first_login
  FROM activity
  GROUP BY player_id
) AS tb1
LEFT JOIN 

(
  SELECT player_id,event_date
  FROM activity
) AS tb2
ON tb1.player_id = tb2.player_id AND tb1.first_login = DATEADD(day,-1,tb2.event_date);

-----------------
--Understanding

SELECT * 
FROM
(
  SELECT player_id, MIN(event_date) AS first_login
  FROM activity
  GROUP BY player_id
) AS tb1
LEFT JOIN 

(
  SELECT player_id,event_date
  FROM activity
) AS tb2
ON tb1.player_id = tb2.player_id AND tb1.first_login = DATEADD(day,-1,tb2.event_date);
