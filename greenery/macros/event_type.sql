{% macro event_type_agg(event_type) %}
    sum(iff(event_type = '{{ event_type }}', 1, 0 ))
{% endmacro %}