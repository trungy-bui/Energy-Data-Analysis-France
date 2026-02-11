WITH int_energy AS 
(
    SELECT * 
    FROM {{ ref("int_energy") }}
),

aggregated AS 
(
    SELECT 
        date,
        country,
        SUM(emission_mt) AS total_emissions,
        SUM(generation_twh) AS total_generation_twh
    FROM int_energy
    GROUP BY 1, 2
)

SELECT *
FROM aggregated