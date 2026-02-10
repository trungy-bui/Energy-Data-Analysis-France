WITH int_energy AS 
(
    SELECT 
        *
    FROM {{ ref("int_energy") }}
),
dates AS 
(
    SELECT 
        -- Seasonals
        year(date) AS year,
        quarter(date) AS quarter,
        month(date) AS month,
        day(date) AS day,

        dayofweek(date) AS day_of_week,
        dayofmonth(date) AS day_of_month,
        dayofyear(date) AS day_of_year,

        -- Names
        monthname(date) AS month_name,
        dayname(date) AS day_name,

        day_of_week IN (1, 7) AS is_weekend,

        -- Time
        hour(date) AS hour,
        minute(date) AS minutes,
        second(date) AS seconds
    FROM int_energy
    ORDER BY 
        year,
        quarter,
        month, 
        day,
        day_of_week,
        day_of_month
)

SELECT 
    * 
FROM dates