WITH source_consumption AS (
    SELECT *
    FROM {{ source('CONSUMPTION_RAW', 'CONSUMPTION_HISTORY') }}
),

renamed AS (
    SELECT
        g."Date"            AS renamed_date,
        g."Pays"            AS renamed_country,
        g."Filière"         AS renamed_energy_type,
        g."Valeur (TWh)"    AS renamed_twh
    FROM source_consumption  AS g
),

cleaned AS (
    SELECT 
        date, 
        country, 
        energy_type,
        {{ format_int('twh') }} AS twh
    FROM renamed
)

SELECT *
FROM cleaned
