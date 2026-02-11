WITH int_energy AS 
(
    SELECT * 
    FROM {{ ref("int_energy") }}
),

joined_net AS 
(
    SELECT 
        i.date,
        i.country,
        i.energy_type,
        d.energy_category,
        i.generation_twh,
        i.consumption_twh
    FROM int_energy AS i
    INNER JOIN {{ ref("dim_energy_type") }} AS d
        ON i.energy_type = d.energy_type
),

aggregated_net AS
(
    SELECT 
        date,
        country,
        energy_type,
        energy_category,
        SUM(generation_twh) - SUM(consumption_twh) AS net_energy_twh
    FROM joined_net
    GROUP BY 
        date,
        country,
        energy_type,
        energy_category
),

final AS
(
    SELECT
        *,
        {{ running_total(
            column_name='net_energy_twh',
            partition_by='country',
            order_by='date'
        ) }} AS running_total_net
    FROM aggregated_net
)

SELECT * FROM final