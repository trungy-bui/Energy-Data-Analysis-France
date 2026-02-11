{% macro running_total(column_name, partition_by, order_by) %}
    SUM({{ column_name }})
    OVER (
        PARTITION BY {{ partition_by }}
        ORDER BY {{ order_by }}
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )
{% endmacro %}