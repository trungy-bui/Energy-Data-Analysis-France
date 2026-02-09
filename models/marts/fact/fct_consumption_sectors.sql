WITH consumption AS (
    SELECT  
        *
    FROM {{ ref("stg_energy_consumption") }}
)

SELECT 
    c.energy_type,
    ROUND(SUM(c.twh), 1) AS mt
FROM consumption c
GROUP BY 1
ORDER BY 2 DESC