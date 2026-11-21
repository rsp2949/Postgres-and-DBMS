CREATE TABLE accounts(
id SERIAL PRIMARY KEY,
name VARCHAR(20) NOT NULL,
balance INTEGER NOT NULL CHECK(balance>=0)
);
INSERT INTO accounts(name,balance)
VALUES
('Allison',100),
('Jia',100);
SELECT * FROM accounts;
BEGIN;
UPDATE accounts
SET balance=balance-50
WHERE name='Allison';
UPDATE accounts
SET balance=balance+50
WHERE name='Jia';
SELECT * FROM accounts;
COMMIT;
SELECT * FROM accounts;
BEGIN;
UPDATE accounts
SET balance=balance-50
WHERE name='Allison';
SELECT * FROM accounts;
ROLLBACK;
SELECT * FROM accounts;
BEGIN;
UPDATE accounts
SET balance=100;
SELECT * FROM accounts;
COMMIT;
SELECT * FROM accounts;
BEGIN;
SELECT * FROM some_table_that_does_not_exist;
SELECT * FROM accounts;
ROLLBACK;
SELECT * FROM accounts;
