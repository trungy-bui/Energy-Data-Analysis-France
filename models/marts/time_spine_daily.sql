{{ config(materialized='table') }}

WITH date_spine AS (

    SELECT
        DATEADD(day, SEQ4(), '2000-01-01') AS date_day
    FROM TABLE(GENERATOR(ROWCOUNT => 20000))

)

SELECT *
FROM date_spine
WHERE date_day <= CURRENT_DATE()