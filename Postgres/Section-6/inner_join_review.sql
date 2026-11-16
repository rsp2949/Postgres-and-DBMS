SELECT users.first_name, users.last_name, orders.paid
FROM users
JOIN orders
ON orders.user_id = users.id;
