WITH source_generation AS (
    SELECT *
    FROM {{ source('GENERATION_RAW', 'GENERATION_HISTORY') }}
),

SELECT SELECT(*) FROM source_generation
