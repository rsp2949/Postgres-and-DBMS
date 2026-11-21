ALTER TABLE posts
ADD COLUMN caption VARCHAR(240),
ADD COLUMN lat REAL,
ADD COLUMN long REAL;

CREATE TABLE photo_tags(
id SERIAL PRIMARY KEY,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
x INTEGER,
y INTEGER
);

CREATE TABLE caption_tags(
id SERIAL PRIMARY KEY,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO photo_tags(post_id,user_id,x,y)
VALUES(1,2,200,300);

INSERT INTO caption_tags(post_id,user_id)
VALUES(1,3);

SELECT * FROM posts;

SELECT * FROM photo_tags;

SELECT * FROM caption_tags;

SELECT users.*
FROM users
JOIN photo_tags ON users.id=photo_tags.user_id
WHERE photo_tags.post_id=1;

SELECT users.*
FROM users
JOIN caption_tags ON users.id=caption_tags.user_id
WHERE caption_tags.post_id=1;

SELECT user_id,COUNT(*)
FROM caption_tags
GROUP BY user_id
ORDER BY COUNT(*) DESC;

SELECT post_id,COUNT(*)
FROM photo_tags
GROUP BY post_id;
