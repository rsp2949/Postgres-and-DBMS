CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(50) NOT NULL,
    bio VARCHAR(400)
);

INSERT INTO users (username, bio)
VALUES
('Alison14', 'This is my bio'),
('Gia67', 'This is about me'),
('cookie123', 'I am a cookie');

SELECT * FROM users;

SELECT * FROM users
WHERE id = 1;

INSERT INTO users (username, bio)
VALUES ('Mint3', 'I am Mint')
RETURNING *;

UPDATE users
SET username = 'Alison156',
    bio = 'I am Alison'
WHERE id = 1
RETURNING *;

DELETE FROM users
WHERE id = 2
RETURNING *;

SELECT * FROM users;
