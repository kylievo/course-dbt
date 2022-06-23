{{
  config(
    materialized='table'
  )
}}

SELECT
    u.uid,
    first_name,
    last_name,
    email,
    count(distinct session_id) as num_sessions,
    MIN(e.created_at_utc) as first_session_start_utc,
    MAX(e.created_at_utc) as latest_session_start_utc,
    SUM(page_view) as page_views,
    SUM(num_orders) as num_orders,
    SUM(num_orders)/count(distinct session_id)::float as order_session_ratio

FROM {{ ref('stg_greenery__users') }} u
LEFT JOIN {{ ref('int_event_summary') }} e 
    ON u.uid = e.uid
GROUP BY 1,2,3,4