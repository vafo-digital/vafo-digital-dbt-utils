{% macro add_audit_columns_post_hook(model) %}
    {% set materialization = config.get('materialized') %}

    alter table {{ model }}
    add column if not exists dbt_updated_at timestamp_tz;

    {% if materialization == 'table' %}
        update {{ model }}
        set dbt_updated_at = convert_timezone('Europe/London', current_timestamp());

    {% elif materialization == 'incremental' %}
        update {{ model }}
        set dbt_updated_at = convert_timezone('Europe/London', current_timestamp())
        where dbt_updated_at is null;

    {% else %}
        {{ return('') }}
    {% endif %}
{% endmacro %}