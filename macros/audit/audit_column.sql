{% macro audit_column() %}
    convert_timezone(
        'UTC',
        'Europe/London',
        '{{ run_started_at.strftime("%Y-%m-%d %H:%M:%S") }}'::timestamp
    ) as dbt_updated_at
{% endmacro %}