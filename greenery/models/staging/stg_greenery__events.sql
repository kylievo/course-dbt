{{
  config(
    materialized='table'
  )
}}

SELECT
    event_id,
    user_id as uid,
    order_id,
    product_id,
    session_id,
    event_type,
    page_url,
    created_at as created_at_utc
    
FROM {{ source('src_greenery', 'events') }}