SELECT ROUND(AVG(LAT_N), 4) AS median_lat
FROM (
    SELECT LAT_N
    FROM (
        SELECT LAT_N, 
               @rownum := @rownum + 1 AS rn, 
               @total_rows AS total
        FROM STATION, (SELECT @rownum := 0) r, 
             (SELECT @total_rows := (SELECT COUNT(*) FROM STATION)) t
        ORDER BY LAT_N
    ) AS ordered
    WHERE rn IN (FLOOR((total + 1)/2), CEIL((total + 1)/2))
) AS median_values;
