USE data_lemur;
-- Most Expensive Purchase Problem
SELECT customer_id, MAX(purchase_amount) AS purchse_amount
FROM transactions
GROUP BY customer_id
ORDER BY MAX(purchase_amount) DESC;

--ApplePay Problem
SELECT merchant_id,
SUM( CASE WHEN payment_method ='Apple Pay' THEN transaction_amount ELSE 0 END) AS volume
FROM transactions
GROUP BY merchant_id
ORDER BY volume DESC ;