CREATE TABLE scores(id INT,score float(24) );
INSERT INTO scores VALUES(1,3.50), (2,3.65),(3,4.00),(4,3.85),(5,4.00),(6,3.65);

SELECT score, DENSE_RANK()OVER(ORDER BY score DESC) AS d_rank,RANK() OVER(ORDER BY score DESC) AS rnk 
FROM scores;-- Diiference b/w rank and dense_rank 

SELECT score,DENSE_RANK()OVER(ORDER BY score DESC) AS [Rank]
FROM scores;