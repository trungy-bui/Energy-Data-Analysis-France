WITH generation AS (
    SELECT  
        *
    FROM {{ ref("stg_energy_generation") }}
)

SELECT 
    replace(g.energy_type, 'Toutes les filières', 'All sectors') AS energy_type,
    round(sum(g.twh), 1) AS twh
FROM generation g
GROUP BY 1
ORDER BY 2 DESC