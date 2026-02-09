{% set renewable = ['Hydropower', 'Biomass', 'Onshore wind', 'Offshore wind']%}

SELECT 
    DISTINCT energy_type,
    -- Energy category (Renewable or Fossil Fuel)
    CASE
        WHEN energy_type IN (
            {%- for r in renewable -%}
                '{{ r }}'{% if not loop.last %}, {% endif %}
            {%- endfor -%}
        ) THEN 'Renewable'
        ELSE 'Fossil Fuel'
    END AS energy_category,
    -- Is renewable
    energy_type in (
        {%- for r in renewable -%}
            '{{ r }}'{% if not loop.last %}, {% endif %}
        {%- endfor -%}
    ) as is_renewable,
FROM {{ ref("int_energy") }}