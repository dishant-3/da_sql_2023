--Highest no of products e-bay customers

SELECT TOP 3 [user_id], COUNT(DISTINCT product_id) AS cnt_product,SUM(spend) AS total_spent
FROM user_transactions
GROUP BY [user_id]
HAVING SUM(spend) >=1000
ORDER BY COUNT(DISTINCT product_id) DESC, SUM(spend) DESC;
