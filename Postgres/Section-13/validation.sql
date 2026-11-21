CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40),
    department VARCHAR(40),
    price INTEGER,
    weight INTEGER
);

INSERT INTO products (name, department, price, weight)
VALUES ('shirt', 'clothes', 20, 1);

INSERT INTO products (name, department, weight)
VALUES ('pants', 'clothes', 3);

SELECT * FROM products;

UPDATE products
SET price = 999
WHERE price IS NULL;

ALTER TABLE products
ALTER COLUMN price
SET NOT NULL;

ALTER TABLE products
ALTER COLUMN price
SET DEFAULT 999;

INSERT INTO products (name, department, weight)
VALUES ('gloves', 'tools', 1);

SELECT * FROM products;

INSERT INTO products (name, department, price, weight)
VALUES ('shirt', 'tools', 24, 1);

UPDATE products
SET name = 'Red Shirt'
WHERE id = (
    SELECT MAX(id)
    FROM products
    WHERE name = 'shirt'
);

ALTER TABLE products
ADD UNIQUE (name);

ALTER TABLE products
DROP CONSTRAINT products_name_key;

ALTER TABLE products
ADD UNIQUE (name, department);

INSERT INTO products (name, department, price, weight)
VALUES ('shirt', 'housewares', 24, 1);

ALTER TABLE products
ADD CHECK (price > 0);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    estimated_delivery TIMESTAMP NOT NULL,
    CHECK (created_at < estimated_delivery)
);

INSERT INTO orders (name, created_at, estimated_delivery)
VALUES (
    'shirt',
    '2000-11-20 01:00:00'::TIMESTAMP,
    '2000-11-25 01:00:00'::TIMESTAMP
);

SELECT * FROM products;

SELECT * FROM orders;
