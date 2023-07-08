--USE data_lemur;
--CREATE TABLE pharmacy_sales
--(product_id INT,
--units_sold INT,
--total_sales decimal,
--cogs decimal,
--manufacturer varchar(25),
--drug varchar(25)
--);
SELECT manufacturer,COUNT(DISTINCT drug) AS grug_count,SUM(cogs-total_sales) AS total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY total_loss DESC;
