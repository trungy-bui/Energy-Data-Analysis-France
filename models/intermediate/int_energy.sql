WITH generation AS (
    SELECT
        date,
        country,
        energy_type,
        SUM(twh) AS generation_twh
    FROM {{ ref('stg_energy_generation') }}
    GROUP BY 1,2,3
),

consumption AS (
    SELECT
        date,
        country,
        energy_type,
        SUM(twh) AS consumption_twh
    FROM {{ ref('stg_energy_consumption') }}
    GROUP BY 1,2,3
),

emissions AS (
    SELECT
        date,
        country,
        energy_type,
        SUM(mt) AS emission_mt
    FROM {{ ref('stg_energy_emission') }}
    GROUP BY 1,2,3
),

capacity AS (
    SELECT
        date,
        country,
        energy_type,
        SUM(gw) AS capacity_gw
    FROM {{ ref('stg_energy_capacity') }}
    GROUP BY 1,2,3
),

merged_energy AS (
    SELECT
        COALESCE(g.date, c.date, e.date, cap.date) AS date,
        COALESCE(g.country, c.country, e.country, cap.country) AS country,
        COALESCE(g.energy_type, c.energy_type, e.energy_type, cap.energy_type) AS energy_type,
        COALESCE(g.generation_twh, 0) AS generation_twh,
        COALESCE(c.consumption_twh, 0) AS consumption_twh,
        COALESCE(e.emission_mt, 0) AS emission_mt,
        COALESCE(cap.capacity_gw, 0) AS capacity_gw
    FROM generation g
    FULL OUTER JOIN consumption c
        ON g.date = c.date
        AND g.country = c.country
        AND g.energy_type = c.energy_type
    FULL OUTER JOIN emissions e
        ON COALESCE(g.date, c.date) = e.date
        AND COALESCE(g.country, c.country) = e.country
        AND COALESCE(g.energy_type, c.energy_type) = e.energy_type
    FULL OUTER JOIN capacity cap
        ON COALESCE(g.date, c.date, e.date) = cap.date
        AND COALESCE(g.country, c.country, e.country) = cap.country
        AND COALESCE(g.energy_type, c.energy_type, e.energy_type) = cap.energy_type
),

cleaned_energy AS (
    SELECT 
        me.date,
        me.country,
        CASE
            WHEN me.energy_type = 'Toutes les filières' THEN 'All sectors'
            WHEN me.energy_type = 'Biogaz' THEN 'Biogas'
            ELSE me.energy_type
        END AS energy_type,
        me.generation_twh,
        me.consumption_twh,
        me.emission_mt,
        me.capacity_gw
    FROM merged_energy me
    ORDER BY 1
)

SELECT * FROM cleaned_energy