WITH source_emission AS (
    SELECT *
    FROM {{ source('EMISSION_RAW', 'EMISSION_HISTORY') }}
),

renamed AS (
    SELECT
        e."Date"            AS date,
        e."Pays"            AS country,
        e."Filière"         AS energy_type,
    FROM source_emission  AS e
),

cleaned AS (
    SELECT 
        date, 
        country, 
        energy_type,
        {{ format_int('mt') }} AS mt
    FROM renamed
)

SELECT *
FROM cleaned
