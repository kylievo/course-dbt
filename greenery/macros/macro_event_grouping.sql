{% macro event_grouping(event_name) %}

    SUM(CASE WHEN event_type = '{{ event_name }}' THEN 1 ELSE 0 END)

{% endmacro %}
