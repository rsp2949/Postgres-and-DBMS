SELECT MAX(avg_price) AS max_average_price
FROM (
    SELECT manufacturer, AVG(price) AS avg_price
    FROM phones
    GROUP BY manufacturer
) AS manufacturer_averages;
