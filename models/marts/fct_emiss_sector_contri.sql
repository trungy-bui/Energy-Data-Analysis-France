WITH emission AS (
    SELECT  
        *
    FROM {{ ref("stg_energy_emission") }}
)

SELECT 
    e.energy_type,
    round(sum(e.mt), 1) AS mt
FROM emission e
GROUP BY 1
ORDER BY 2