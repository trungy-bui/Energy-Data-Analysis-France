WITH source_capacity AS (
    SELECT *
    FROM {{ source('CAPACITY_RAW', 'CAPACITY_HISTORY') }}
)

WITH source_something AS (
    SELECT *
    FROM source_capacity
)

SELECT *
FROM source_capacity
