SELECT
    name,
    price,
    price::numeric / (SELECT MAX(price) FROM phones) AS price_ratio
FROM phones;
