SELECT *
FROM likes
LEFT JOIN posts ON posts.id=likes.post_id
LEFT JOIN comments ON comments.id=likes.comment_id;

SELECT DATE_TRUNC('week',COALESCE(posts.created_at,comments.created_at)) AS week
FROM likes
LEFT JOIN posts ON posts.id=likes.post_id
LEFT JOIN comments ON comments.id=likes.comment_id
ORDER BY week;

SELECT DATE_TRUNC('week',COALESCE(posts.created_at,comments.created_at)) AS week
FROM likes
LEFT JOIN posts ON posts.id=likes.post_id
LEFT JOIN comments ON comments.id=likes.comment_id
GROUP BY week
ORDER BY week;

SELECT
    DATE_TRUNC('week',COALESCE(posts.created_at,comments.created_at)) AS week,
    COUNT(posts.id) AS num_likes_for_posts,
    COUNT(comments.id) AS num_likes_for_comments
FROM likes
LEFT JOIN posts ON posts.id=likes.post_id
LEFT JOIN comments ON comments.id=likes.comment_id
GROUP BY week
ORDER BY week;

CREATE MATERIALIZED VIEW weekly_likes AS
SELECT
    DATE_TRUNC('week',COALESCE(posts.created_at,comments.created_at)) AS week,
    COUNT(posts.id) AS num_likes_for_posts,
    COUNT(comments.id) AS num_likes_for_comments
FROM likes
LEFT JOIN posts ON posts.id=likes.post_id
LEFT JOIN comments ON comments.id=likes.comment_id
GROUP BY week
ORDER BY week
WITH DATA;

SELECT * FROM weekly_likes;

SELECT *
FROM weekly_likes
ORDER BY week DESC;

DELETE FROM posts
WHERE created_at<'2010-02-01';

SELECT * FROM weekly_likes;

REFRESH MATERIALIZED VIEW weekly_likes;

SELECT * FROM weekly_likes;

DROP MATERIALIZED VIEW weekly_likes;
