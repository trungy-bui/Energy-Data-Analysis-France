WITH source_capacity AS (
    SELECT *
    FROM {{ source('CAPACITY_RAW', 'CAPACITY_HISTORY') }}
)

SELECT *
FROM source_capacity
