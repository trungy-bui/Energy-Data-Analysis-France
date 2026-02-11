SELECT *
FROM {{ ref('fct_energy_net') }}
WHERE energy_category = 'Renewable'
AND net_energy_twh < 0