{{
  config(
    materialized='table'
  )
}}

{% set events = dbt_utils.get_column_values(table=ref('stg_greenery__events'), column='event_type') %}

SELECT
    uid,
    session_id,
    created_at_utc,
    COUNT(DISTINCT event_id) AS num_events,
    COUNT(DISTINCT order_id) AS num_orders
    {% for event_name in events %}
      , {{event_grouping(event_name)}} AS {{event_name}}
    {% endfor %}
FROM {{ ref('stg_greenery__events') }}
GROUP BY 1, 2, 3