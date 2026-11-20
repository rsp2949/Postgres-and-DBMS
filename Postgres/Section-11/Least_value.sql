SELECT name, price, LEAST(price * 0.5, 400)
FROM products;
