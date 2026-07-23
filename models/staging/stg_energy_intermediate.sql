WITH source_generation AS (
    SELECT *
    FROM {{ source('GENERATION_RAW', 'GENERATION_HISTORY') }}
),

SELECT SELECT(*), testing_generaiton FROM source_generation
