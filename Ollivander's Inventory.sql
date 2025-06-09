SELECT 
    w.id, 
    wp.age, 
    w.coins_needed, 
    w.power
FROM Wands w
JOIN Wands_Property wp 
    ON w.code = wp.code
JOIN (
    SELECT 
        wp.age, 
        w.power, 
        MIN(w.coins_needed) AS min_coins
    FROM Wands w
    JOIN Wands_Property wp 
        ON w.code = wp.code
    WHERE wp.is_evil = 0
    GROUP BY wp.age, w.power
) AS grouped
    ON wp.age = grouped.age 
    AND w.power = grouped.power 
    AND w.coins_needed = grouped.min_coins
WHERE wp.is_evil = 0
ORDER BY w.power DESC, wp.age DESC;
