{% macro snowflake__create_view_as(relation, sql) -%}
  create or replace view {{ relation }} as
  with base as (
    {{ sql }}
  )
  select
    base.*,
    convert_timezone(
      'UTC',
      'Europe/London',
      '{{ run_started_at.strftime("%Y-%m-%d %H:%M:%S") }}'::timestamp
    ) as dbt_updated_at
  from base
{%- endmacro %}