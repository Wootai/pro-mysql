SELECT 
   t1.ENGINE
   , t1.SIZE_IN_MB / (1024 * 1024) AS "ENGINE MB"
   , SUM(t2.SIZE_IN_MB) / (1024 * 1024) AS "Total MB"
  FROM
  (
   SELECT ENGINE, SUM(DATA_LENGTH) AS "SIZE_IN_MB"
   FROM INFORMATION_SCHEMA.TABLES
   WHERE ENGINE IS NOT NULL
   GROUP BY ENGINE
  ) as t1
  INNER JOIN 
  (
   SELECT ENGINE, SUM(DATA_LENGTH) AS "SIZE_IN_MB"
    FROM INFORMATION_SCHEMA.TABLES
    WHERE ENGINE IS NOT NULL
    GROUP BY ENGINE
  ) as t2
   ON t1.ENGINE >= t2.ENGINE
GROUP BY t1.ENGINE;