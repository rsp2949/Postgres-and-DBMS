CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    url TEXT,
    lat NUMERIC,
    lng NUMERIC
);

SELECT * FROM posts;

ALTER TABLE posts
ADD COLUMN loc POINT;

SELECT * FROM posts;

INSERT INTO posts (url, lat, lng)
VALUES
('post1.jpg', 30, 50),
('post2.jpg', -46, 10);

UPDATE posts
SET loc = POINT(lng, lat)
WHERE loc IS NULL;

SELECT id, url, lat, lng, loc
FROM posts;

SELECT
    id,
    loc,
    (loc).x AS longitude,
    (loc).y AS latitude
FROM posts;

BEGIN;

UPDATE posts
SET lat = 2
WHERE id = 1;

COMMIT;

ALTER TABLE posts
DROP COLUMN lat,
DROP COLUMN lng;

SELECT * FROM posts;

ALTER TABLE posts
ADD COLUMN lat NUMERIC,
ADD COLUMN lng NUMERIC;

SELECT * FROM posts;
