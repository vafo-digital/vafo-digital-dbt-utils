{% macro delete_recent_records(
    table_ref,
    time_col='event_date',
    backfill_value=3,
    backfill_unit='day'
) %}
    {% if execute %}

        {% if backfill_unit not in ['day', 'hour'] %}
            {{ exceptions.raise_compiler_error("backfill_unit must be 'day' or 'hour'") }}
        {% endif %}

        {# For day backfills, compare as DATE and anchor to CURRENT_DATE() #}
        {% if backfill_unit == 'day' %}
            {% set time_expr = "TO_DATE(" ~ time_col ~ ")" %}
            {% set anchor = "CURRENT_DATE()" %}
        {% else %}
            {% set time_expr = time_col %}
            {% set anchor = "CURRENT_TIMESTAMP()" %}
        {% endif %}

        {% set sql %}
            DELETE FROM {{ table_ref }}
            WHERE {{ time_expr }} >= DATEADD(
                '{{ backfill_unit }}',
                -{{ backfill_value }},
                {{ anchor }}
            );
        {% endset %}

        {{ log(
            "Deleting last " ~ backfill_value ~ " " ~ backfill_unit ~ "(s) from " ~ table_ref ~
            " using time_col=" ~ time_col,
            info=True
        ) }}

        {% do run_query(sql) %}
    {% endif %}

    {{ return('') }}
{% endmacro %}