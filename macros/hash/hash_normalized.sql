{% macro hash_normalized(value) %}
    sha2(lower(trim(coalesce({{ value }}, ''))), 256)
{% endmacro %}