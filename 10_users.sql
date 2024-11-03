WITH cte AS (SELECT u.id AS user_id,
       COUNT(b.id) AS cnt
FROM stackoverflow.users AS u
JOIN stackoverflow.badges AS b ON u.id=b.user_id
WHERE b.creation_date::date BETWEEN '2008-11-15' AND '2008-12-15'
GROUP BY u.id
ORDER BY cnt DESC)       
 SELECT *,
 DENSE_RANK() OVER (ORDER BY cnt DESC)
 FROM cte
 ORDER BY cnt DESC, user_id
 LIMIT 10;