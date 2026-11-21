CREATE TABLE hashtags(
id SERIAL PRIMARY KEY,
title VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE hashtags_posts(
id SERIAL PRIMARY KEY,
hashtag_id INTEGER REFERENCES hashtags(id) ON DELETE CASCADE,
post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
UNIQUE(hashtag_id,post_id)
);
INSERT INTO hashtags(title)
VALUES
('birthday'),
('happy'),
('snow'),
('fun');
INSERT INTO hashtags_posts(hashtag_id,post_id)
VALUES
(1,1),
(2,1),
(3,2),
(4,3);
SELECT posts.*
FROM posts
JOIN hashtags_posts ON posts.id=hashtags_posts.post_id
JOIN hashtags ON hashtags.id=hashtags_posts.hashtag_id
WHERE hashtags.title='birthday';
SELECT hashtags.title
FROM hashtags
JOIN hashtags_posts ON hashtags.id=hashtags_posts.hashtag_id
WHERE hashtags_posts.post_id=1;
ALTER TABLE users
ADD COLUMN bio VARCHAR(400),
ADD COLUMN avatar VARCHAR(200),
ADD COLUMN phone VARCHAR(25),
ADD COLUMN email VARCHAR(40),
ADD COLUMN password VARCHAR(255),
ADD COLUMN status VARCHAR(15);
SELECT * FROM users;
SELECT COUNT(*)
FROM posts
WHERE user_id=1;
SELECT COUNT(*)
FROM followers
WHERE user_id=1;
