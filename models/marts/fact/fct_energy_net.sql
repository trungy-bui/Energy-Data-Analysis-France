WITh int_energy AS 
(
    SELECT 
        * 
    FROM {{ ref("int_energy") }}
),

dim_energy_type AS 
(
    SELECT
        *
    FROM {{ ref("dim_energy_type") }}
),

joined AS 
(
    SELECT 
        i.date,
        i.country,
        i.energy_type,
        d.energy_category,
        i.generation_twh,
        i.consumption_twh
    FROM int_energy AS i
    INNER JOIN dim_energy_type AS d
        ON i.energy_type = d.energy_type
),

aggregated AS 
(
    SELECT 
        date,
        country,
        energy_type,
        energy_category,
        (SUM(generation_twh) - SUM(consumption_twh)) AS total_net_energy,
    FROM joined
    GROUP BY 1, 2, 3, 4
),

windowed AS 
(
    SELECT 
        * ,
        {{ running_total(
            column_name="total_net_energy",
            partition_by="country",
            order_by="date"
        ) }} AS running_net_energy
    FROM aggregated
),

final_net AS 
(
    SELECT 
        *
    FROM windowed
)

SELECT * FROM final_net