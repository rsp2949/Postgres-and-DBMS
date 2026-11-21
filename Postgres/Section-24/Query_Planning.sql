SELECT * FROM users WHERE username='Allison 14';
EXPLAIN SELECT * FROM users WHERE username='Allison 14';
EXPLAIN ANALYZE SELECT * FROM users WHERE username='Allison 14';
SELECT users.username,comments.contents
FROM users
JOIN comments ON comments.user_id=users.id
WHERE users.username='Allison 14';
EXPLAIN
SELECT users.username,comments.contents
FROM users
JOIN comments ON comments.user_id=users.id
WHERE users.username='Allison 14';
EXPLAIN ANALYZE
SELECT users.username,comments.contents
FROM users
JOIN comments ON comments.user_id=users.id
WHERE users.username='Allison 14';
SELECT *
FROM pg_stats
WHERE tablename='users';
SELECT attname,avg_width,n_distinct,most_common_vals,most_common_freqs,histogram_bounds
FROM pg_stats
WHERE tablename='users';
SELECT *
FROM pg_stats
WHERE tablename='users' AND attname='status';
