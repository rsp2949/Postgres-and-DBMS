SHOW seq_page_cost;
SHOW random_page_cost;
SHOW cpu_tuple_cost;
SHOW cpu_index_tuple_cost;
SHOW cpu_operator_cost;
SELECT relname,relpages,reltuples
FROM pg_class
WHERE relname IN ('users','comments','likes');
EXPLAIN SELECT * FROM users WHERE username='Allison 14';
EXPLAIN ANALYZE SELECT * FROM users WHERE username='Allison 14';
EXPLAIN ANALYZE
SELECT users.username,comments.contents
FROM users
JOIN comments ON comments.user_id=users.id
WHERE users.username='Allison 14';
SELECT COUNT(*) FROM comments;
SELECT COUNT(*) FROM likes;
SELECT COUNT(*)
FROM likes
WHERE created_at<'2013-01-01';
EXPLAIN
SELECT *
FROM likes
WHERE created_at<'2013-01-01';
CREATE INDEX likes_created_at_idx ON likes(created_at);
EXPLAIN ANALYZE
SELECT *
FROM likes
WHERE created_at<'2013-01-01';
SELECT COUNT(*)
FROM likes
WHERE created_at>'2013-01-01';
EXPLAIN ANALYZE
SELECT *
FROM likes
WHERE created_at>'2013-01-01';
DROP INDEX likes_created_at_idx;
