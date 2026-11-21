SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM likes;
SELECT *
FROM users
ORDER BY id DESC
LIMIT 3;
SELECT users.username,posts.caption
FROM users
JOIN posts ON posts.user_id=users.id
WHERE users.id=200;
SELECT users.username,COUNT(*)
FROM users
JOIN likes ON likes.user_id=users.id
GROUP BY users.username;
