{% set energy_stats = ['generation_twh', 'consumption_twh', 'emission_mt', 'capacity_gw'] %}

SELECT
    e.country,
    {% for s in energy_stats -%}
        SUM(e.{{ s }}) AS total_{{ s }}{% if not loop.last %}, {% endif %}
    {% endfor -%}
FROM {{ ref("int_energy") }} AS e
GROUP BY 1