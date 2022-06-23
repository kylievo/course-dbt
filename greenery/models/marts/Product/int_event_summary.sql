{{
  config(
    materialized='table'
  )
}}

SELECT
    uid,
    session_id,
    created_at_utc,
    COUNT(distinct event_id) AS num_events,
    SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped,
    SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view,
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout,
    SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart,
    COUNT(distinct order_id) AS num_orders  
FROM {{ ref('stg_greenery__events') }}
GROUP BY 1, 2, 3