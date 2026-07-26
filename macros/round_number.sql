{% macro round_currency(column_name, decimals=2) %}
    ROUND({{ column_name }}, {{ decimals }})
{% endmacro %}
