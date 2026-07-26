WITH source_capacity AS (
    SELECT *
    FROM {{ source('CAPACITY_RAW', 'CAPACITY_HISTORY') }}
),

renamed AS (
    SELECT
        cap."Date"            AS date,
        cap."Pays"            AS country,
        cap."Filière"         AS energy_type,
        cap."Valeur (GW)"    AS gw
    FROM source_capacity  AS cap
),

cleaned AS (
    SELECT 
        date, 
        country, 
        energy_type,
        {{ format_int('gw') }} AS gw
    FROM renamed
)

SELECT 
    *,
    testing
FROM cleaned
