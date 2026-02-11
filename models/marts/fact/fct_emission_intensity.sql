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
        SUM(generation_twh) AS total_generation
    FROM int_energy
    GROUP BY 1, 2
),

final AS 
(
    SELECT
        *,
        
        {{ running_total(
            column_name='total_emissions',
            partition_by='country',
            order_by='date'
        ) }} AS running_emissions_mt,

        {{ running_total(
            column_name='total_generation',
            partition_by='country',
            order_by='date'
        ) }} AS running_generation_twh

    FROM aggregated
)

SELECT * 
FROM final