WITh int_energy AS 
(
    SELECT 
        * 
    FROM {{ ref("int_energy") }}
),

joined AS 
(
    SELECT 
        i.date,
        i.country,
        i.energy_type,
        i.emission_mt,
        i.generation_twh
    FROM int_energy AS i
),

aggregated AS 
(
    SELECT 
        date,
        country,
        SUM(emission_mt) AS total_emissions,
    FROM joined
    GROUP BY 1, 2
),

windowed AS 
(
    SELECT 
        * ,
        {{ running_total(
            column_name="total_emissions",
            partition_by="country",
            order_by="date"
        ) }} AS running_energy_emission
    FROM aggregated
),

final AS 
(
    SELECT 
        *
    FROM windowed
)

SELECT * FROM final