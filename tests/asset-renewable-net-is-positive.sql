SELECT *
FROM {{ ref('fct_energy_net') }}
WHERE energy_category = 'Renewable'
AND total_net_energy < 0