CREATE TABLE likes(
id SERIAL PRIMARY KEY,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
comment_id INTEGER REFERENCES comments(id) ON DELETE CASCADE,
post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
CONSTRAINT likes_check CHECK(
(post_id IS NOT NULL AND comment_id IS NULL)
OR
(post_id IS NULL AND comment_id IS NOT NULL)
)
);

CREATE UNIQUE INDEX likes_user_post_unique
ON likes(user_id,post_id)
WHERE post_id IS NOT NULL;

CREATE UNIQUE INDEX likes_user_comment_unique
ON likes(user_id,comment_id)
WHERE comment_id IS NOT NULL;

INSERT INTO likes(user_id,post_id)
VALUES(1,1);

INSERT INTO likes(user_id,comment_id)
VALUES(2,1);

SELECT COUNT(*)
FROM likes
WHERE post_id=1;

SELECT users.*
FROM users
JOIN likes ON users.id=likes.user_id
WHERE likes.post_id=1;

SELECT post_id,COUNT(*)
FROM likes
WHERE post_id IS NOT NULL
GROUP BY post_id
ORDER BY COUNT(*) DESC
LIMIT 5;

SELECT posts.*
FROM posts
JOIN likes ON posts.id=likes.post_id
WHERE likes.user_id=1;

DELETE FROM likes
WHERE user_id=1 AND post_id=1;
