{{
  config(
    materialized='table'
  )
}}

SELECT
    product_id,
    COUNT(distinct event_id) AS num_events,
    SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view,
    SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart,
    COUNT(DISTINCT order_id) AS num_orders  
FROM {{ ref('stg_greenery__events') }}
GROUP BY 1