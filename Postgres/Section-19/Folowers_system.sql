CREATE TABLE followers(
id SERIAL PRIMARY KEY,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
leader_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
follower_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
CHECK(leader_id<>follower_id),
UNIQUE(leader_id,follower_id)
);
INSERT INTO followers(leader_id,follower_id)
VALUES
(1,2),
(1,3),
(2,3),
(3,4);
SELECT * FROM followers;
SELECT users.*
FROM users
JOIN followers ON users.id=followers.follower_id
WHERE followers.leader_id=1;
SELECT users.*
FROM users
JOIN followers ON users.id=followers.leader_id
WHERE followers.follower_id=2;
SELECT leader_id,COUNT(*)
FROM followers
GROUP BY leader_id
ORDER BY COUNT(*) DESC;
SELECT follower_id,COUNT(*)
FROM followers
GROUP BY follower_id
ORDER BY COUNT(*) DESC;
SELECT COUNT(*)
FROM followers
WHERE leader_id=1;
SELECT COUNT(*)
FROM followers
WHERE follower_id=1;
DELETE FROM followers
WHERE leader_id=1 AND follower_id=2;
