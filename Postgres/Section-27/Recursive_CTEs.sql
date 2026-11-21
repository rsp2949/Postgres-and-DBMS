WITH RECURSIVE countdown(val) AS (
    SELECT 3
    UNION
    SELECT val-1
    FROM countdown
    WHERE val>1
)
SELECT * FROM countdown;
WITH RECURSIVE countdown(val) AS (
    SELECT 10
    UNION
    SELECT val-1
    FROM countdown
    WHERE val>1
)
SELECT * FROM countdown;
WITH RECURSIVE suggestions(leader_id,follower_id,depth) AS (
    SELECT leader_id,follower_id,1
    FROM followers
    WHERE follower_id=1000
    UNION
    SELECT followers.leader_id,followers.follower_id,suggestions.depth+1
    FROM followers
    JOIN suggestions ON suggestions.leader_id=followers.follower_id
    WHERE suggestions.depth<3
)
SELECT DISTINCT users.id,users.username
FROM suggestions
JOIN users ON users.id=suggestions.leader_id
WHERE suggestions.depth>1
LIMIT 30;
