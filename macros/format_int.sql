-- Example: 0,2 -> 0.2 OR Null -> 0
{% macro format_int(int) %}
    COALESCE(
        CAST(REPLACE({{ int }}, ',', '.') AS FLOAT),
        0
    )
{% endmacro %}