SELECT paid, COUNT(*) AS count
FROM orders
GROUP BY paid;
