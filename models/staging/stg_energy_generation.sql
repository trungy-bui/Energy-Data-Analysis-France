WITH source_generation AS (
    SELECT *
    FROM {{ source('GENERATION_RAW', 'GENERATION_HISTORY') }}
),

renamed AS (
    SELECT
        g."Date"            AS date,
        g."Pays"            AS country,
        g."Filière"         AS energy_type,
        g."Valeur (TWh)"    AS twh
    FROM source_generation  AS g
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