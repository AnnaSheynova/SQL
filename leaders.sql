WITH cte AS (SELECT 
    u.id AS user_id,
    u.views AS profile_views,
    CASE 
        WHEN u.views >= 350 THEN 1
        WHEN u.views >= 100 THEN 2
        WHEN u.views < 100 THEN 3
    END AS user_group
FROM stackoverflow.users AS u
WHERE TRIM(u.location) LIKE '%Canada%' 
  AND u.views > 0),
cte_2 AS (SELECT user_id,
                 profile_views,
                 user_group,
                 DENSE_RANK() OVER(PARTITION BY user_group ORDER BY profile_views DESC) AS u_rank
                 FROM cte)
SELECT user_id,
       profile_views,
       user_group
FROM cte_2 
WHERE u_rank = 1
ORDER BY profile_views DESC, user_id;