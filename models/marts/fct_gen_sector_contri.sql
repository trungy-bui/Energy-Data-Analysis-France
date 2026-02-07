WITH generation AS (
    SELECT  
        *
    FROM {{ ref("stg_energy_generation") }}
)

SELECT 
    g.energy_type,
    sum(g.twh) AS twh
FROM generation g
GROUP BY 1
ORDER BY 2